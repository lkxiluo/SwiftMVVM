//
//  SystemMacros.swift
//  WuZhouHuiSwift
//
//  Created by QianHan on 2017/5/2.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

/************ App系统参数宏定义 ********/
import Foundation
import UIKit

/// 10.0之后的系统版本
let SYSTEMMACROS_IS_IOS10:Bool         = (UIDevice.current.systemVersion as NSString).doubleValue >= 10.0
/// 屏幕宽度
let SYSTEMMACROS_SCREEN_WIDTH:CGFloat  = UIScreen.main.bounds.size.width
/// 屏幕高度
let SYSTEMMACROS_SCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.size.height

/*********** 公共方法 **************/
// 以375.0(iPone6/7)为基准宽度适配
func FITSCREEN(f:CGFloat) -> CGFloat {
    
    return f / 375.0 * SYSTEMMACROS_SCREEN_WIDTH
}

func QHLog<T>(_ message: T, file: String = #file, funcName: String = #function, lineNum: Int = #line) {
    
    #if DEBUG
        let fileName             = (file as NSString).lastPathComponent
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        let dateString           = dateFormatter.string(from: Date())
        
        print(" ------->fileName：\(fileName)\n ------->funcName：\(funcName)\n ------->line：\(lineNum)\n ------->time：\(dateString)\n ------->message：\(message)\n")
    #endif
}
