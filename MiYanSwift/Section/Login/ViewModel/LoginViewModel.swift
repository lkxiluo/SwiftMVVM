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
    
    var loginModel: LoginModel = LoginModel()
    var account: String  = "" {
    
        didSet {
        
            loginModel.account = account
        }
    }
    
    var password: String = "" {
    
        didSet {
        
            loginModel.password = password
        }
    }
    
    func isCanLogin() -> Bool {
    
        guard account.isMobileNumber() && password.isPasswordRule() else {
            
            return false
        }
        return true
    }
    
    func login(messageHandler: @escaping (_ message: String) -> Void, completeHandler: @escaping (_ isSuccess: Bool) -> Void) -> Void {
    
        loginModel.login(messageHandler: messageHandler, completeHandler: completeHandler)
    }
}
