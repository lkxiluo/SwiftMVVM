//
//  UIButton+Extensions.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/10.
//  Copyright © 2017年 karl.luo. All rights reserved.
//


/// 带图片按钮图片的位置
///
/// - left: 图片在左边
/// - right: 图片在右边
/// - top: 图片在上边
/// - bottom: 图片在底部
enum ButtonImagePosition {
    case left
    case right
    case top
    case bottom
}

import Foundation
import UIKit

extension UIButton {

    
    /// 重新设置按钮中图片和标题的布局
    ///
    /// - Parameters:
    ///   - imagePosition: 图片的位置
    ///   - margin: 间距
    func layoutContains(imagePosition: ButtonImagePosition, margin: CGFloat) {
    
        let imageWidth  = imageView?.qh_width()
        let imageHeight = imageView?.qh_height()
        let titleWidth  = titleLabel?.intrinsicContentSize.width
        let titleHeight = titleLabel?.intrinsicContentSize.height
        
        var imageEdgeInsets = UIEdgeInsets()
        var titleEdgeInsets = UIEdgeInsets()
        
        // 系统默认是.left关系
        switch imagePosition {
            
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -margin / 2.0, bottom: 0.0, right: margin / 2.0)
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: margin / 2.0, bottom: 0.0, right: -margin / 2.0)
            break
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0.0, left: titleWidth! + margin / 2.0, bottom: 0.0, right: -(titleWidth! + margin / 2.0))
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -(imageWidth! + margin / 2.0), bottom: 0.0, right: imageWidth! + margin / 2.0)
            break
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -(titleHeight! + margin / 2.0), left: 0.0, bottom: 0.0, right: -titleWidth!)
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageWidth!, bottom: -(imageHeight! + margin / 2.0), right: 0.0)
            break
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -(titleHeight! + margin / 2.0), right: -titleWidth!)
            titleEdgeInsets = UIEdgeInsets(top: -(imageHeight! + margin / 2.0), left: -imageWidth!, bottom:0.0, right: 0.0)
            break
        }
        
        self.imageEdgeInsets = imageEdgeInsets
        self.titleEdgeInsets = titleEdgeInsets
    }
}
