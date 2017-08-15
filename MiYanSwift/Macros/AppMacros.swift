//
//  WZHAppMacros.swift
//  WuZhouHuiSwift
//
//  Created by QianHan on 2017/4/8.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

/************* App规范参数宏定义 **********/

import Foundation
import UIKit

/************* 接口配置 *************/
//let WZHAPPMACROS_MAIN_URL = "https://www.wzhouhui.egocdn.com/api/index.php" // 测试环境
//let WZHAPPMACROS_MAIN_URL = "https://gray.www.wzhouhui.com/api/index.php" // 灰度环境
let APPMACROS_MAIN_URL = "https://www.wzhouhui.com/api/index.php" // 正式环境

let APPMACROS_APP_VERSION    = Bundle.main.infoDictionary?["CFBundleShortVersionString"] // APP版本
let APPMACROS_LOGINTOKEN_KEY = "APPMACROS_LOGINTOKEN_KEY"                                // 保存登录token

/************* 字体大小 *************/
let APPMACROS_SUPERBIG_FONTSIZE: CGFloat = 18.0  // 大字体
let APPMACROS_BIG_FONTSIZE: CGFloat      = 16.0  // 大字体
let APPMACROS_MAIN_FONTSIZE: CGFloat     = 14.0  // 主字体
let APPMACROS_SUB_FONTSIZE: CGFloat      = 13.0  // 备用字体
let APPMACROS_SUB1_FONTSIZE: CGFloat     = 12.0  // 次字体
let APPMACROS_SUB2_FONTSIZE: CGFloat     = 11.0  // 副字体

let APPMACROS_SUPERBIG_FONT: UIFont = UIFont.systemFont(ofSize: APPMACROS_SUPERBIG_FONTSIZE) // 大字体
let APPMACROS_BIG_FONT: UIFont      = UIFont.systemFont(ofSize: APPMACROS_BIG_FONTSIZE)      // 大字体
let APPMACROS_MAIN_FONT: UIFont     = UIFont.systemFont(ofSize: APPMACROS_MAIN_FONTSIZE)     // 主字体
let APPMACROS_SUB_FONT: UIFont      = UIFont.systemFont(ofSize: APPMACROS_SUB_FONTSIZE)      // 备用字体
let APPMACROS_SUB1_FONT: UIFont     = UIFont.systemFont(ofSize: APPMACROS_SUB1_FONTSIZE)     // 次字体
let APPMACROS_SUB2_FONT: UIFont     = UIFont.systemFont(ofSize: APPMACROS_SUB2_FONTSIZE)     // 副字体

/************* 字体颜色 *************/
let APPMACROS_MAIN_TEXTCOLOR: UIColor = UIColor.qh_colorWithHex(hexColor: 0x333333)
let APPMACROS_SUB_TEXTCOLOR: UIColor  = UIColor.qh_colorWithHex(hexColor: 0x666666)
let APPMACROS_SUB1_TEXTCOLOR: UIColor = UIColor.qh_colorWithHex(hexColor: 0x999999)
let APPMACROS_SUB2_TEXTCOLOR: UIColor = UIColor.qh_colorWithHex(hexColor: 0xcccccc)

/************* 其他颜色 *************/
let APPMACROS_LINECOLOR: UIColor       = UIColor.qh_colorWithHex(hexColor: 0xd8d8d8) // 分割线颜色
let APPMACROS_MAINCOLOR: UIColor       = UIColor.qh_colorWithHex(hexColor: 0xff3574) // APP主调色
let APPMACROS_UNENBLECOLOR: UIColor    = UIColor.qh_colorWithHex(hexColor: 0xcccccc) // 不可操作时颜色
let APPMACROS_MAIN_BACKGROUND: UIColor = UIColor(red: 247.0 / 255.0, green: 248.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0) // 背景颜色

/************* 其他 *************/
let APPMACROS_LINE_HEIGHT: CGFloat         = 1.0     // 线条高
let APPMACROS_VIEW_TAG: NSInteger          = 1000    // 如果要设置视图的tag，则从APPMACROS_VIEW_TAG开始
let APPMACROS_BASE_MARGIN: CGFloat         = 5.0     // 间距最小单位，以此为基数成倍增加
let APPMACROS_ANIMATION_TIME: TimeInterval = 0.35    // 动画的执行时间




		
