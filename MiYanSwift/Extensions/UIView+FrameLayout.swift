//
//  UIView+FrameLayout.swift
//  WuZhouHuiSwift
//
//  Created by QianHan on 2017/4/28.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// 设置X轴起点
    ///
    /// - Parameter x: X轴起点值
    func qh_x(_ x: CGFloat) -> Void {
        self.frame.origin.x = x
    }
    
    /// 获取X轴起点
    ///
    /// - Returns: X轴起点值
    func qh_x() -> CGFloat {
        return self.frame.origin.x
    }
    
    /// 设置Y轴起点
    ///
    /// - Parameter y: Y轴起点值
    func qh_y(_ y: CGFloat) -> Void {
        self.frame.origin.y = y
    }
    
    /// 获取Y轴起点
    ///
    /// - Returns: Y轴起点值
    func qh_y() -> CGFloat {
        return self.frame.origin.y
    }
    
    /// 设置宽度
    ///
    /// - Parameter width: 宽度值
    func qh_width(_ width: CGFloat) -> Void {
        self.frame.size.width = width
    }
    
    /// 获取宽度
    ///
    /// - Returns: 宽度值
    func qh_width() -> CGFloat {
        return self.frame.size.width
    }
    
    /// 设置高度
    ///
    /// - Parameter height: 高度值
    func qh_height(_ height: CGFloat) -> Void {
        self.frame.size.height = height
    }
    
    /// 获取高度
    ///
    /// - Returns: 高度值
    func qh_height() -> CGFloat {
        return self.frame.size.height
    }
    
    /// 视图左边到目标视图右边的距离
    ///
    /// - Parameters:
    ///   - toView: 目标视图
    ///   - margin: 距离
    func qh_leftMargin(toView:UIView, margin:CGFloat) -> Void {
        self.qh_x(toView.qh_x() + toView.qh_width() + margin)
    }
    
    /// 视图右边到目标视图左边的距离
    ///
    /// - Parameters:
    ///   - toView: 目标视图
    ///   - margin: 距离
    func qh_rightMargin(toView:UIView, margin:CGFloat) -> Void {
        self.qh_x(toView.qh_x() - self.qh_width() - margin)
    }
    
    func qh_topMargin(toView:UIView, margin:CGFloat) -> Void {
        self.qh_y(toView.qh_y() + toView.qh_height() + margin)
    }
}
