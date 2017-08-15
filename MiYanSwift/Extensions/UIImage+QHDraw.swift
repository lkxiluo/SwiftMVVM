//
//  UIImage+QHDraw.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/7/28.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    /// 根据颜色获取图片
    ///
    /// - Parameter color: 图片的颜色
    /// - Returns: 图片
    class func qh_creatImageWithColor(color: UIColor) -> (UIImage) {
    
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
}
