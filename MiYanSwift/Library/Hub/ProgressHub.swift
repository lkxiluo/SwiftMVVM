//
//  ProgressHub.swift
//  LibrarySwift
//
//  Created by 罗坤 on 2017/5/3.
//  Copyright © 2017年 Qianhan. All rights reserved.
//

import Foundation
import UIKit

final class ProgressHub: NSObject {
    
    private let margin:CGFloat = 15.0
    
    private var backgroundView:UIView?
    private var logoImageView:UIImageView = UIImageView()
    private var pinkImageView:UIImageView = UIImageView()
    
    private var tipBackgrountView:UIView?
    private var containerView:UIView = UIView()
    private var tipLabel:UILabel     = UILabel()
    
    private static var shared: ProgressHub {
        
        struct Static {
            
            static let instance: ProgressHub = ProgressHub()
        }
        return Static.instance
    }
    
    private override init() {
    }
    
    deinit {
        
        ProgressHub.shared.pinkImageView.layer.removeAllAnimations()
    }
    
    /// 展示加载
    class func show() -> Void {
        
        if ProgressHub.shared.backgroundView == nil {
            
            ProgressHub.shared.initBackgrounView()
        }
        UIApplication.shared.windows.last?.addSubview(ProgressHub.shared.backgroundView!)
        ProgressHub.shared.addPinkAnimation()
    }
    
    /// 展示提示
    ///
    /// - Parameter statusString: 提示内容
    class func showStatus(statusString: String) -> Void {
        
        if ProgressHub.shared.backgroundView != nil {
            
            ProgressHub.dismiss()
        }
        
        if statusString.isEmpty {
            return
        }
        
        if ProgressHub.shared.tipBackgrountView == nil {
            
            ProgressHub.shared.initTipBackgroundView()
        }
        
        UIApplication.shared.windows.last?.addSubview(ProgressHub.shared.tipBackgrountView!)
        ProgressHub.shared.showTipString(tipString: statusString)
    }
    
    class func dismiss() -> Void {
        
        if ProgressHub.shared.backgroundView != nil {
            
            ProgressHub.shared.backgroundView!.removeFromSuperview()
        }
    }
    
    // MARK: 初始化
    private func initBackgrounView() -> Void {
        
        self.backgroundView        = UIView()
        self.backgroundView!.frame = UIScreen.main.bounds
        
        self.initLogoImageView()
        self.initPinkImageView()
    }
    
    private func initLogoImageView() -> Void {
        
        let imageWidth:CGFloat   = 24.0
        self.logoImageView.frame = CGRect(x: (self.backgroundView!.frame.size.width - imageWidth) / 2,
                                          y: (self.backgroundView!.frame.size.height - imageWidth) / 2,
                                          width: imageWidth,
                                          height: imageWidth)
        self.logoImageView.backgroundColor = UIColor.clear
        self.logoImageView.clipsToBounds   = true
        self.logoImageView.image           = UIImage.init(named: "loading_image_center")
        self.backgroundView!.addSubview(self.logoImageView)
    }
    
    private func initPinkImageView() -> Void {
        
        let imageWidth:CGFloat   = 30.0
        self.pinkImageView.frame = CGRect(x: (self.backgroundView!.frame.size.width - imageWidth) / 2,
                                          y: (self.backgroundView!.frame.size.height - imageWidth) / 2,
                                          width: imageWidth,
                                          height: imageWidth)
        self.pinkImageView.backgroundColor = UIColor.clear
        self.pinkImageView.clipsToBounds   = true
        self.pinkImageView.image           = UIImage.init(named: "loading_image_circle")
        self.backgroundView!.addSubview(self.pinkImageView)
    }
    
    private func initTipBackgroundView() -> Void {
        
        self.tipBackgrountView        = UIView()
        self.tipBackgrountView!.frame = UIScreen.main.bounds
        
        self.initContainerView()
        self.initTipLabel()
    }
    
    private func initContainerView() -> Void {
        
        self.containerView.frame = CGRect.zero
        self.containerView.layer.cornerRadius  = 5.0
        self.containerView.layer.masksToBounds = true
        self.containerView.center              = (ProgressHub.shared.tipBackgrountView?.center)!
        ProgressHub.shared.containerView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        ProgressHub.shared.tipBackgrountView?.addSubview(self.containerView)
    }
    
    private func initTipLabel() -> Void {
        
        self.tipLabel.textColor     = UIColor.white
        self.tipLabel.font          = UIFont.systemFont(ofSize: 14.0)
        self.tipLabel.textAlignment = NSTextAlignment.left
        self.tipLabel.numberOfLines = 0
        ProgressHub.shared.containerView.addSubview(self.tipLabel)
    }
    
    private func addPinkAnimation() -> Void {
        
        let baseAnimation:CABasicAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        
        baseAnimation.fromValue      = NSNumber(value: 0.0)
        baseAnimation.toValue        = NSNumber(value: 2 * Double.pi)
        baseAnimation.repeatCount    = MAXFLOAT
        baseAnimation.duration       = 0.4
        baseAnimation.isRemovedOnCompletion = false
        
        ProgressHub.shared.pinkImageView.layer.add(baseAnimation, forKey: nil)
    }
    
    private func showTipString(tipString: String) -> Void {
        
        let maxWidth:CGFloat = (self.tipBackgrountView?.frame.size.width)! - 60.0;
        self.tipLabel.text        = tipString
        let statusString:NSString = tipString as NSString
        let size:CGSize           = statusString.boundingRect(with: CGSize(width: maxWidth - ProgressHub.shared.margin * 2,
                                                                           height: CGFloat(MAXFLOAT)),
                                                              options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                              attributes: [NSFontAttributeName: self.tipLabel.font],
                                                              context: nil).size
        
        var containerWidth:CGFloat  = size.width + ProgressHub.shared.margin * 2.0
        let containerHeight:CGFloat = size.height + 10.0 * 2.0
        containerWidth = containerWidth < 100.0 ? 100.0 : containerWidth
        ProgressHub.shared.containerView.frame = CGRect(x: ((ProgressHub.shared.tipBackgrountView?.frame.size.width)! - containerWidth) / 2,
                                                        y: ((ProgressHub.shared.tipBackgrountView?.frame.size.height)! - containerHeight) / 2,
                                                        width: containerWidth,
                                                        height: containerHeight)
        ProgressHub.shared.tipLabel.frame = CGRect(x: (containerWidth - size.width) / 2,
                                                   y: 10.0,
                                                   width: size.width,
                                                   height: size.height)
        
        let animationTime:TimeInterval = 0.5 + 0.1 * Double(statusString.length) > 3.5 ? 3.5 : 0.5 + 0.1 * Double(statusString.length)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + animationTime) {
            
            ProgressHub.shared.tipBackgrountView?.removeFromSuperview()
        }
    }
}
