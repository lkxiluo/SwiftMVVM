//
//  WZHTabItem.swift
//  WuZhouHuiSwift
//
//  Created by QianHan on 2017/4/7.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit

class TabItem: UIButton {
    
    private let badgeHeight:CGFloat = 14.0;
    // 数字标识
    private var badgeLabel:UILabel  = UILabel.init();
    // 点标识
    private var dotView:UIView      = UIView();
    var badgeValue:NSString = "0" {
        
        didSet {
            
            if self.badgeValue.intValue == 0 {
                
                self.badgeLabel.frame.size.width = 0.0;
            } else {
                
                self.badgeValue = self.badgeValue.intValue > 99 ? "99+" : self.badgeValue;
                let stringSize:CGSize = self.badgeValue.qh_singleLineSize(font: self.badgeLabel.font);
                self.badgeLabel.frame.size.width = stringSize.width > badgeHeight ? stringSize.width + 6.0 : badgeHeight;
                self.badgeLabel.text = self.badgeValue as String;
            }
        }
    }
    
    // 默认颜色值
    var normalColor:UIColor = UIColor.init(red: 121.0 / 255.0,
                                           green: 121.0 / 255.0,
                                           blue: 121.0 / 255.0,
                                           alpha: 1.0) {
        
        didSet {
            
            self.setTitleColor(self.normalColor, for: UIControlState.normal);
        }
    }
    
    var selectedColor:UIColor = UIColor.blue {
        
        didSet {
            
            self.setTitleColor(self.selectedColor, for: UIControlState.selected);
        }
    }
    
    // 数字标识背景颜色
    var badgeBackgroundColor:UIColor = UIColor.clear {
        
        didSet {
            
            self.badgeLabel.backgroundColor = self.badgeBackgroundColor;
            self.badgeLabel.textColor       = UIColor.white;
        }
    }
    
    // 数字标识边框颜色
    var badgeBorderColor:UIColor = UIColor.init(red: 121.0 / 255.0,
                                                green: 121.0 / 255.0,
                                                blue: 121.0 / 255.0,
                                                alpha: 1.0) {
        
        didSet {
            
            self.badgeLabel.layer.borderColor = self.badgeBorderColor.cgColor;
            self.badgeLabel.textColor         = self.badgeBorderColor;
        }
    }
    
    // 点标识颜色
    var dotColor:UIColor = UIColor.red {
        
        didSet {
            
            self.dotView.backgroundColor = dotColor
        }
    }
    
    class func instance(image:UIImage, selectedImage:UIImage, title:NSString) -> TabItem {
        
        let tabItem:TabItem = TabItem.init(frame: CGRect.zero);
        tabItem.setImage(image, for: UIControlState.normal);
        tabItem.setImage(selectedImage, for: UIControlState.selected);
        tabItem.setTitle(title as String, for: UIControlState.normal);
        
        return tabItem;
    }
    
    // MARK: - override
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.titleLabel?.font          = UIFont.systemFont(ofSize: 10.0)
        self.titleLabel?.textAlignment = NSTextAlignment.center
        self.imageView?.contentMode    = UIViewContentMode.center
        self.setTitleColor(self.normalColor, for: UIControlState.normal)
        self.setTitleColor(UIColor.blue, for: UIControlState.selected)

        self.initBadgeLabel()
        self.initDotView()
        self.addSubview(self.badgeLabel)
        self.addSubview(self.dotView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        self.imageView?.backgroundColor = UIColor.clear;
        var imageFrame:CGRect           = (self.imageView?.frame)!;
        var titleFrame:CGRect           = (self.titleLabel?.frame)!;
        let space:CGFloat               = 3.0;
        
        // 重新计算布局
        imageFrame.origin.x   = (self.frame.size.width - imageFrame.size.width) / 2;
        imageFrame.origin.y   = (self.frame.size.height - imageFrame.size.height - titleFrame.size.height - space * 2);
        self.imageView?.frame = imageFrame;

        titleFrame.origin.y    = imageFrame.origin.y + imageFrame.size.height + space;
        titleFrame.origin.x    = 0.0;
        titleFrame.size.width  = self.frame.size.width;
        self.titleLabel?.frame = titleFrame;
        
        let centerX:CGFloat      = imageFrame.origin.x + imageFrame.size.width;
        let centerY:CGFloat      = imageFrame.origin.y * 5 / 4;
        self.badgeLabel.center   = CGPoint.init(x: centerX, y: centerY);
        self.dotView.center      = CGPoint.init(x: centerX, y: centerY)
        
        let badgeOffsetX:CGFloat = (self.badgeLabel.qh_x() + self.badgeLabel.qh_width()) > self.qh_width() ? self.qh_width() - self.badgeLabel.qh_width() : self.badgeLabel.qh_x();
        let badgeOffsetY:CGFloat = self.badgeLabel.qh_y() <= 0.0 ? 3.0 : self.badgeLabel.qh_y();
        self.badgeLabel.frame.origin.x = badgeOffsetX;
        self.badgeLabel.frame.origin.y = badgeOffsetY;
    }
    
    // MARK: - init method
    func initBadgeLabel() -> Void {
        
        self.badgeLabel.frame           = CGRect.init(x: 0.0,
                                                      y: 0.0,
                                                      width: 0.0,
                                                      height: badgeHeight);
        self.badgeLabel.textColor       = UIColor.red;
        self.badgeLabel.backgroundColor = UIColor.white;
        self.badgeLabel.font            = UIFont.systemFont(ofSize: 11.0);
        self.badgeLabel.textAlignment   = NSTextAlignment.center;

        self.badgeLabel.layer.cornerRadius  = badgeHeight / 2;
        self.badgeLabel.layer.borderColor   = UIColor.red.cgColor;
        self.badgeLabel.layer.borderWidth   = 0.8;
        self.badgeLabel.layer.masksToBounds = true;
    }
    
    func initDotView() -> Void {
        
        self.dotView.frame               = CGRect(x: 0.0, y: 0.0, width: 6.0, height: 6.0)
        self.dotView.backgroundColor     = self.dotColor
        self.dotView.layer.cornerRadius  = self.dotView.qh_height() / 2
        self.dotView.layer.masksToBounds = true
        self.dotView.isHidden            = true;
    }
    
    // MARK: public method
    func isShowDotView(isShow:Bool) -> Void {
        
        self.dotView.isHidden = !isShow;
    }
}
