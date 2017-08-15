//
//  AlertView.swift
//  WuZhouHuiSwift
//
//  Created by QianHan on 2017/5/4.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation
import UIKit

class AlertView: NSObject {
    
    private let containerWidth:CGFloat     = SYSTEMMACROS_SCREEN_WIDTH - 80.0
    private let maxHeight:CGFloat          = SYSTEMMACROS_SCREEN_HEIGHT - 80.0
    private let margin:CGFloat             = 10.0
    private static var buttonTag:NSInteger = 0
    private var backgroundView:UIView!
    private var containerView:UIView!
    
    private var buttonAction: (_ index:NSInteger) -> Void = {_ in
    }
    
    private static var share:AlertView {
        
        struct Static {
            
            static let instance:AlertView = AlertView()
        }
        return Static.instance
    }
    
    /// 展示提示框
    ///
    /// - Parameters:
    ///   - title: 提示框标题
    ///   - message: 提示内容
    ///   - buttonTitles: 操作标题集（数组）
    ///   - action: 操作回调
    class func alertView(title: String,
                         message: String,
                         buttonTitles:String...,
        action: @escaping(_ index: NSInteger) -> Void) -> Void {
        
        AlertView.share.removeAllSubView()
        
        if title.isEmpty
        && message.isEmpty
        && buttonTitles.count == 0 {
            
            return;
        }
        
        AlertView.share.initBackgroundView()
        AlertView.share.initContainerView()

        var offsetY:CGFloat = AlertView.share.initTitle(title: title)
        offsetY             = AlertView.share.initMessage(message: message, offsetY: offsetY)
        AlertView.share.initButtonTitles(titles: buttonTitles, offsetY: offsetY)
        
        AlertView.share.show()
        AlertView.share.buttonAction = action
    }
    
    class func dismiss() -> Void {
        
        
        UIView.animate(withDuration: 0.25, animations: { 
            
            AlertView.share.backgroundView.alpha = 0.0
        }) { (Bool) in
            
            AlertView.share.removeAllSubView()
        }
    }
    
    private func show() -> Void {
        
        UIApplication.shared.windows.last?.addSubview(AlertView.share.backgroundView)
        
        UIView.animate(withDuration: 0.25, animations: {
            
            AlertView.share.backgroundView.alpha = 1.0
        }) { (Bool) in
            
            AlertView.share.backgroundView.alpha = 1.0
        }
    }
    
    private func removeAllSubView() -> Void {
        
        if AlertView.share.containerView != nil
        && AlertView.share.backgroundView != nil {
            
            for subView:UIView in AlertView.share.containerView.subviews {
                
                subView.removeFromSuperview()
            }
            AlertView.share.backgroundView.removeFromSuperview()
        }
    }
    
    func buttonAction(btn: UIButton) -> Void {
        
        AlertView.share.buttonAction(btn.tag)
    }
    
    // MARK:初始化
    private func initBackgroundView() -> Void {
        
        if AlertView.share.backgroundView == nil {
            
            self.backgroundView                 = UIView()
            self.backgroundView.frame           = UIScreen.main.bounds
            self.backgroundView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.3)
            self.backgroundView.alpha           = 0.0
        }
    }
    
    private func initContainerView() -> Void {
        
        if AlertView.share.containerView == nil {
            
            AlertView.share.containerView = UIView()
            AlertView.share.containerView.frame              = CGRect(x: (AlertView.share.backgroundView.qh_width() - containerWidth) / 2,
                                                           y: AlertView.share.backgroundView.qh_height() / 2,
                                                           width: containerWidth,
                                                           height: 0.0)
            AlertView.share.containerView.backgroundColor    = UIColor.white
            AlertView.share.containerView.layer.cornerRadius = 5.0
            AlertView.share.containerView.clipsToBounds      = true
            AlertView.share.backgroundView.addSubview(AlertView.share.containerView)
        }
    }
    
    private func initTitle(title: String) -> CGFloat {
        
        var offsetY:CGFloat = 0.0
        
        if !title.isEmpty {
            
            offsetY = AlertView.share.margin
            let font:UIFont = APPMACROS_MAIN_FONT
            let size:CGSize = (title as NSString).qh_singleLineSize(font: font)
            
            let titleLabel:UILabel   = UILabel()
            titleLabel.frame         = CGRect(x: AlertView.share.margin,
                                              y: offsetY,
                                              width: containerWidth - AlertView.share.margin * 2.0,
                                              height: size.height)
            titleLabel.font          = font
            titleLabel.textAlignment = NSTextAlignment.center
            titleLabel.textColor     = APPMACROS_SUB1_TEXTCOLOR
            titleLabel.text          = title
            AlertView.share.containerView.addSubview(titleLabel)
            
            offsetY += size.height
        }
        
        return offsetY
    }
    
    private func initMessage(message: String, offsetY: CGFloat) -> CGFloat {
        
        var offsetY:CGFloat = offsetY
        
        if !message.isEmpty {
            
            offsetY += AlertView.share.margin
            let font:UIFont = APPMACROS_MAIN_FONT
            let size:CGSize = (message as NSString).qh_multeLineSize(font: font,
                                                                     maxSize: CGSize(width: containerWidth
                                                                                            - AlertView.share.margin * 2.0,
                                                                                     height: CGFloat(MAXFLOAT)))
            
            let messageLabel:UILabel   = UILabel()
            messageLabel.frame         = CGRect(x: AlertView.share.margin,
                                                y: offsetY,
                                                width: containerWidth - AlertView.share.margin * 2.0,
                                                height: size.height)
            messageLabel.font          = font
            messageLabel.textAlignment = NSTextAlignment.center
            messageLabel.textColor     = APPMACROS_MAIN_TEXTCOLOR
            messageLabel.numberOfLines = 0
            messageLabel.text          = message
            AlertView.share.containerView.addSubview(messageLabel)
            
            offsetY += size.height
        }
        
        return offsetY
    }
    
    private func initSeperateView(offsetY: CGFloat) -> CGFloat {
        
        var offsetY:CGFloat          = offsetY
        offsetY                      += AlertView.share.margin
        let seperateView:UIView      = UIView()
        seperateView.frame           = CGRect(x: 0.0,
                                              y: offsetY,
                                              width: AlertView.share.containerWidth,
                                              height: APPMACROS_LINE_HEIGHT)
        seperateView.backgroundColor = APPMACROS_LINECOLOR
        AlertView.share.containerView.addSubview(seperateView)
        
        return offsetY;
    }
    
    private func initButtonTitles(titles: [String], offsetY: CGFloat) -> Void {
        
        var offsetY:CGFloat      = offsetY
        offsetY                  += AlertView.share.margin
        let buttonHeight:CGFloat = 36.0
        if titles.count == 0 {
            
            let buttonWidth:CGFloat = AlertView.share.containerView.qh_width()
            offsetY = AlertView.share.initButton(titile: "确认",
                                                 frame: CGRect(x: 0.0,
                                                               y: offsetY,
                                                               width: buttonWidth,
                                                               height: buttonHeight))
        } else if titles.count == 2 {
            
            for titleString:String in titles {
                
                let buttonWidth:CGFloat = AlertView.share.containerView.qh_width() / 2
                offsetY = AlertView.share.initButton(titile: titleString,
                                                     frame: CGRect(x: buttonWidth * CGFloat(AlertView.buttonTag),
                                                                   y: offsetY,
                                                                   width: buttonWidth + APPMACROS_LINE_HEIGHT,
                                                                   height: buttonHeight + APPMACROS_LINE_HEIGHT))
            }
            offsetY += buttonHeight;
        } else {
            
            for titleString:String in titles {
                
                let buttonWidth:CGFloat = AlertView.share.containerView.qh_width()
                offsetY = AlertView.share.initButton(titile: titleString,
                                                     frame: CGRect(x: 0.0,
                                                                   y: offsetY,
                                                                   width: buttonWidth,
                                                                   height: buttonHeight))
            }
        }
        
        AlertView.buttonTag = 0
        AlertView.share.containerView.qh_height(offsetY)
        AlertView.share.containerView.qh_y((AlertView.share.backgroundView.qh_height()
            - AlertView.share.containerView.qh_height()) / 2)
    }
    
    private func initButton(titile: String, frame: CGRect) -> CGFloat {
        
        var offsetY:CGFloat      = frame.origin.y

        let button:UIButton      = UIButton(type: .custom)
        button.frame             = frame
        button.tag               = AlertView.buttonTag
        button.layer.borderColor = APPMACROS_LINECOLOR.cgColor
        button.layer.borderWidth = APPMACROS_LINE_HEIGHT
        button.titleLabel?.font  = UIFont.systemFont(ofSize: APPMACROS_MAIN_FONTSIZE)
        button.setTitleColor(APPMACROS_MAIN_TEXTCOLOR, for: .normal)
        button.setTitle(titile, for: .normal)
        button.addTarget(self, action: #selector(AlertView.share.buttonAction(btn:)), for: UIControlEvents.touchUpInside)
        
        if frame.size.width == AlertView.share.containerView.qh_width() {
            
            offsetY += frame.size.height
            button.qh_y(frame.origin.y - APPMACROS_LINE_HEIGHT)
        } else if AlertView.buttonTag <= 1 {
            
            button.setTitleColor(APPMACROS_MAINCOLOR, for: .normal)
        }
        
        AlertView.share.containerView.addSubview(button);
        AlertView.buttonTag += 1
        
        return offsetY
    }
}
