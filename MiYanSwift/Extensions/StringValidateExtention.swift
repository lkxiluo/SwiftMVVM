//
//  StringValidateExtention.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/14.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation


// MARK: - 字符串验证扩展
extension String {

    /// 手机号验证
    ///
    /// - Returns: 是否和手机号规则匹配
    func isMobileNumber() -> Bool {
        
        guard self.characters.count > 0 else {
        
            return false
        }
        let phoneRegex: String = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with:self)
    }
    
    /// 邮箱验证
    ///
    /// - Returns: 是否和邮箱的规则匹配
    func isEmailCode() -> Bool {
        
        let emailRegex: String     = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    /// 密码验证，6到16位
    ///
    /// - Returns: 是否和密码规则匹配
    func isPasswordRule() -> Bool {
        
//        let  passWordRegex    = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$" // 6到16位数字和字符串
        let  passWordRegex    = "[0-9A-Za-z]{6,16}$"   // 6到16位数字或字符串
        let passWordPredicate = NSPredicate(format: "SELF MATCHES%@", passWordRegex)
        return passWordPredicate.evaluate(with: self)
    }
}
