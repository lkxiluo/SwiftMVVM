//
//  NSString+WuZhouHui.swift
//  WuZhouHuiSwift
//
//  Created by QianHan on 2017/4/8.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation
import UIKit

extension NSString {
    
    /// 计算字符串单行尺寸
    ///
    /// - Parameter font: 字符字体
    /// - Returns: 单行尺寸
    func qh_singleLineSize(font:UIFont) -> CGSize {
        
        if self.length <= 0 {
            
            return CGSize.zero
        }
        
        let attribute = [NSFontAttributeName: font]
        let resultSize:CGSize = self.size(attributes: attribute)
        return resultSize
    }
    
    /// 计算字符串多行尺寸
    ///
    /// - Parameters:
    ///   - font: 字符串字体
    ///   - maxSize: 显示字符串宽高的阈值
    /// - Returns: 多行字符尺寸
    func qh_multeLineSize(font:UIFont, maxSize:CGSize) -> CGSize {
        
        if self.length <= 0 {
            
            return CGSize.zero
        }
        
        let attribute = [NSFontAttributeName: font]
        let resultSize:CGSize = self.boundingRect(with: maxSize,
                                                  options: .usesLineFragmentOrigin,
                                                  attributes: attribute,
                                                  context: nil).size
        return resultSize
    }
}
