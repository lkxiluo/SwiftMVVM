//
//  NSString+MYURL.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/1.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation
import UIKit


extension NSString {
    
    /// 请求链接基础
    ///
    /// - Parameter isNewInterface: 是否是对接新接口
    /// - Returns: 请求链接
    class func my_baseUrl(isNewInterface: Bool) -> String {
    
        var baseUrl: String = NSString.my_rootUrl()
        baseUrl = isNewInterface ? (baseUrl + "/v3_0/") : (baseUrl + "/v1/")
        return baseUrl
    }
    
    /// 网络请求的根路径
    ///
    /// - Returns: 请求链接
    class func my_rootUrl() -> String {
    
        var rootUrl: String = ""
        
//        rootUrl = "http://page.miyanmz.hqygou.com"     // 正式环境
//        rootUrl = "http://gray.page.miyanmz.com"       // 灰度环境
        rootUrl = "http://api.miyanmz.hqygou.com"        // 测试环境
        
        return rootUrl
    }
}
