//
//  LoginViewModelProtocol.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/4.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation

protocol LoginViewModelProtocol {
    
    var account: String {get set}
    var password: String {get set}
    
    func login(messageHandler: @escaping (_ message: String) -> Void, completeHandler: @escaping (_ isSuccess: Bool) -> Void) -> Void
    func isCanLogin() -> Bool
}
