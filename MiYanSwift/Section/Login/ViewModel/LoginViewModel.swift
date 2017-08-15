//
//  LoginViewModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/1.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import SwiftyJSON
import KeychainAccess

final class LoginViewModel: LoginViewModelProtocol {
    
    var account: String  = ""
    var password: String = ""
    
    func isCanLogin() -> Bool {
    
        guard account.isMobileNumber() && password.isPasswordRule() else {
            
            return false
        }
        return true
    }
    
    func login(completeHandler: @escaping (_ isSuccess: Bool) -> Void) {
        
        QHLog("\(account) \(password)")
        ProgressHub.show()
        
        let params = ["username": account,
                      "password": password]
        
        LoginRequest().starRequest(parameters: params, completeSuccess: { (respondJson: Any) in
            
            let respondJs = JSON(respondJson)
            let message   = respondJs["msg"].stringValue
            let ret       = respondJs["ret"].intValue
            
            if ret != 200 {
                
                ProgressHub.showStatus(statusString: message)
            } else {
                
                let data    = respondJs["data"].dictionary
                let message = data?["msg"]?.stringValue
                let code    = data?["code"]?.intValue
                if code == 0 {
                    
                    let info     = data?["info"]?.dictionary
                    let keyChain = Keychain(service: NSString.my_rootUrl())
                    keyChain[APPMACROS_LOGINTOKEN_KEY] = info?["token"]?.stringValue
                    
                    completeHandler(true)
                }
                ProgressHub.showStatus(statusString: message!)
            }
        }) { (error: Error) in
            
            ProgressHub.showStatus(statusString: error.localizedDescription)
        }
    }
}
