//
//  WZHTabBar.swift
//  WuZhouHuiSwift
//
//  Created by QianHan on 2017/4/7.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import Foundation

protocol TabBarDelegate: NSObjectProtocol {
    func selectItem(tabBar:TabBar, index:NSInteger);
}

class TabBar: UIView {

    private static let kItemTag:NSInteger = 1000;
    
    weak var delegate:TabBarDelegate?;
    
    var selectedIndex:NSInteger = 0 {
        
        didSet {
            
            for tabItem in self.tabItems! {
                
                tabItem.isSelected = false;
                tabItem.isUserInteractionEnabled  = true;
            }
            
            let tabItem:TabItem = self.tabItems![self.selectedIndex];
            tabItem.isSelected = true;
            tabItem.isUserInteractionEnabled  = false;
        }
    }
    
    var tabItems:Array<TabItem>? {
        
        didSet {
            
            let itemWidth:CGFloat = self.frame.size.width / (CGFloat)((tabItems?.count)!);
            self.moveSubItems();
            
            for index in 0...((tabItems?.count)! - 1) {

                let tabItem:TabItem   = tabItems![index];
                tabItem.frame            = CGRect.init(x: itemWidth * (CGFloat)(index),
                                                       y: 0.0,
                                                       width: itemWidth,
                                                       height: self.frame.size.height);
                tabItem.tag              = TabBar.kItemTag + index;
                tabItem.selectedColor    = APPMACROS_MAINCOLOR;
                tabItem.dotColor         = APPMACROS_MAINCOLOR
                tabItem.addTarget(self,
                                  action: #selector(TabBar.tabItemClick(tabItem:)),
                                  for: UIControlEvents.touchUpInside);
                self.addSubview(tabItem);
                
                if index == self.selectedIndex {
                    
                    tabItem.isSelected = true;
                    tabItem.isUserInteractionEnabled  = false;
                }
            }
            
            if !SYSTEMMACROS_IS_IOS10 {
                self.addSeperateLineView()
            }
        }
    }
    
    // MARK: - override
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private method
    /// 删除所有子视图
    private func moveSubItems() -> Void {
        
        for subView:UIView in self.subviews {
            
            subView.removeFromSuperview();
        }
    }
    
    // 添加分割线
    private func addSeperateLineView() -> Void {

        let lineView:UIView      = UIView()
        lineView.frame           = CGRect(x: 0.0,
                                          y: 0.0,
                                          width: self.qh_width(),
                                          height: APPMACROS_LINE_HEIGHT)
        lineView.backgroundColor = APPMACROS_LINECOLOR
        self.addSubview(lineView)
        self.bringSubview(toFront: lineView)
    }
    
    func tabItemClick(tabItem:TabItem) -> Void {
        
        let clickIndex:NSInteger = tabItem.tag - TabBar.kItemTag;
        self.delegate?.selectItem(tabBar: self, index: clickIndex);
        self.selectedIndex = clickIndex;
    }
    
    // MARK: - public method
    /// 设置数字标识
    ///
    /// - Parameters:
    ///   - value: 数字
    ///   - index: 要显示的tabItem索引
    final func badgeValue(value:NSInteger, index:NSInteger) -> Void {

        let tabItem:TabItem = self.tabItems![index];
        tabItem.badgeValue     = NSString.init(format: "%ld", value);
    }
    
    /// 右上角显示点标识
    ///
    /// - Parameter 
    ///   - index: 要显示的选项索引
    ///   - isShow: 是否要展示 true展示 false不展示
    final func showDotView(index:NSInteger, isShow:Bool) -> Void {
        
        let tabItem:TabItem = self.tabItems![index]
        tabItem.isShowDotView(isShow: isShow)
    }
}
