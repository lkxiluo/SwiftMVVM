//
//  UIView+EmptyView.swift
//  WuZhouHuiSwift
//
//  Created by QianHan on 2017/5/5.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation
import UIKit

private let EMPTYVIEW_TAG = 10000  // 起始tag
private var buttonAction: (_ index:NSInteger) -> Void = {_ in
}

// MARK: - 空数据提示
extension UIView {
    
    /// 显示空数据提示
    ///
    /// - Parameters:
    ///   - image: 提示的图标
    ///   - description: 提示内容
    ///   - buttonTitle: 操作按钮集合（数组）
    ///   - action: 操作
    func qh_showEmptView(image: UIImage,
                         description: String,
                         buttonTitles: String...,
        action: @escaping (_ index: NSInteger) -> Void) -> Void {
        
        if  image.isEqual(nil)
            && description.isEmpty
            && buttonTitles.count == 0 {
            
            return;
        }
        
        self.qh_dismissEmptyView()
        self.qh_EmtpyView(image: image,
                          description: description,
                          buttonTitles: buttonTitles)
        buttonAction = action
    }
    
    /// 隐藏空数据提示
    func qh_dismissEmptyView() -> Void {
        
        for subView:UIView in self.subviews {
            
            if subView.tag >= EMPTYVIEW_TAG {
                
                subView.removeFromSuperview()
            }
        }
    }
    
    @objc private func btnAction(btn: UIButton) -> Void {
        
        let index:NSInteger = btn.tag - (EMPTYVIEW_TAG + 3)
        buttonAction(index)
    }
    
    // MARK:初始化数据
    private func qh_EmtpyView(image: UIImage,
                              description: String,
                              buttonTitles: [String]) -> Void {
        
        let font:UIFont     = UIFont.systemFont(ofSize: APPMACROS_MAIN_FONTSIZE)
        
        // 背景
        let backgroundView:UIView      = UIView()
        backgroundView.frame           = self.bounds
        backgroundView.tag             = EMPTYVIEW_TAG
        backgroundView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        self.addSubview(backgroundView)
        
        // 图片
        let sizeParam = self.qh_width() > self.qh_height() ? self.qh_height() : self.qh_width()
        let imageHeight:CGFloat   = sizeParam / 5
        let imageView:UIImageView = UIImageView()
        imageView.frame = CGRect(x: (self.qh_width() - imageHeight) / 2,
                                 y: self.qh_height() / 3,
                                 width: imageHeight,
                                 height: imageHeight)
        imageView.image = image
        imageView.tag   = EMPTYVIEW_TAG + 1
        backgroundView.addSubview(imageView)
        
        // 内容描述
        let offsetX:CGFloat = 15.0
        let labelWidth:CGFloat     = self.qh_width() - offsetX * 2
        let descriptionSize:CGSize = (description as NSString).qh_multeLineSize(font: font,
                                                                                maxSize: CGSize(width: labelWidth,
                                                                                                height: CGFloat(MAXFLOAT)))
        let descriptionLabel:UILabel = UILabel()
        descriptionLabel.frame = CGRect(x: offsetX,
                                        y: 0.0,
                                        width: labelWidth,
                                        height: descriptionSize.height)
        descriptionLabel.textAlignment = .center
        descriptionLabel.font          = font
        descriptionLabel.textColor     = APPMACROS_SUB_TEXTCOLOR
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text          = description
        descriptionLabel.tag           = EMPTYVIEW_TAG + 2
        descriptionLabel.qh_topMargin(toView: imageView, margin: 5.0)
        backgroundView.addSubview(descriptionLabel)
        
        if buttonTitles.count == 0 {
            return;
        }
        // 操作按钮
        var buttonArray:[AnyObject] = [AnyObject]()
        var maxWidth:CGFloat      = 0.0
        for index in 0...(buttonTitles.count - 1) {
            
            let title:String = buttonTitles[index]
            let size:CGSize  = (title as NSString).qh_singleLineSize(font: font)
            let buttonWidth  = size.width + 10.0
            let button:UIButton      = UIButton(type: .custom)
            button.frame             = CGRect(x: 0.0,
                                              y: 0.0,
                                              width: buttonWidth,
                                              height: size.height + 10.0)
            button.tag                 = EMPTYVIEW_TAG + 3 + index
            button.layer.borderColor   = APPMACROS_MAINCOLOR.cgColor
            button.layer.borderWidth   = APPMACROS_LINE_HEIGHT
            button.layer.cornerRadius  = 3.0
            button.layer.masksToBounds = true
            button.titleLabel?.font    = UIFont.systemFont(ofSize: APPMACROS_MAIN_FONTSIZE)
            button.setTitleColor(APPMACROS_MAINCOLOR, for: .normal)
            button.setTitle(title, for: .normal)
            button.addTarget(self,
                             action: #selector(self.btnAction(btn:)),
                             for: UIControlEvents.touchUpInside)
            button.qh_topMargin(toView: descriptionLabel, margin: 10.0)
            backgroundView.addSubview(button)
            
            buttonArray.append(button)
            maxWidth = (buttonWidth > maxWidth ? buttonWidth : maxWidth) + 10.0
        }
        
        // 重新给按钮布局
        if buttonArray.count == 1 {
            
            let btn:UIButton = buttonArray[0] as! UIButton
            btn.qh_x((backgroundView.qh_width() - btn.qh_width()) / 2)
        } else {
            
            let buttonMargin:CGFloat  = 10.0
            let totalWidth:CGFloat    = maxWidth * CGFloat(buttonArray.count) + buttonMargin * CGFloat(buttonArray.count - 1)
            var buttonOffsetX:CGFloat = (backgroundView.qh_width() - totalWidth) / 2
            for button in buttonArray {
                
                let btn:UIButton = button as! UIButton
                btn.qh_x(buttonOffsetX)
                btn.qh_width(maxWidth)
                buttonOffsetX += btn.qh_width() + buttonMargin
            }
        }
    }
}



