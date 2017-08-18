//
//  LoginModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/15.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import Alamofire
import KeychainAccess
import SwiftyJSON

class LoginModel: BaseModel {

    var account: String  = ""
    var password: String = ""
    func login(messageHandler: @escaping (_ message: String) -> Void, completeHandler: @escaping (_ isSuccess: Bool) -> Void) {
        
        QHLog("\(account) \(password)")
        let params = ["username": account,
                      "password": password]
        
        LoginRequest().starRequest(parameters: params, completeSuccess: { (respondJson: Any) in
            
            let respondJs = JSON(respondJson)
            let message   = respondJs["msg"].stringValue
            let ret       = respondJs["ret"].intValue
            
            if ret != 200 {
                
                completeHandler(false)
                messageHandler(message)
            } else {
                
                let data    = respondJs["data"].dictionary
                let message = data?["msg"]?.stringValue
                let code    = data?["code"]?.intValue
                if code == 0 {
                    
                    let info     = data?["info"]?.dictionary
                    let keyChain = Keychain(service: NSString.my_rootUrl())
                    keyChain[APPMACROS_LOGINTOKEN_KEY] = info?["token"]?.stringValue
                    
                    completeHandler(true)
                } else {
                
                    completeHandler(false)
                }
                messageHandler(message!)
            }
        }) { (error: Error) in
            
            completeHandler(false)
            messageHandler(error.localizedDescription)
        }
    }
}
