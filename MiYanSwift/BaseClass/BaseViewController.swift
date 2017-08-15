//
//  WZHBaseViewController.swift
//  WuZhouHuiSwift
//
//  Created by QianHan on 2017/4/11.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit

/// 登录协议，默认都是需要登录
protocol IsLoginProtocal {
    
    func isNeedLogin() -> Bool
}

class BaseViewController: UIViewController {
    
    weak var networkNoticeView: UIView?
    
    //MARK: life circle
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        super.viewDidLoad()
        view.backgroundColor = APPMACROS_MAIN_BACKGROUND
        initNavLeftItem()
        initNetworkNoticeView()
        addNotificate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        moveTabbarSubView()
    }
    
    func moveTabbarSubView() -> Void {
        
        if self.tabBarController != nil {
    
            for subView:UIView in (self.tabBarController?.tabBar.subviews)! {
                
                if !(subView is TabBar) {
                    
                    subView.removeFromSuperview();
                }
            }
        }
    }
    
    //MARK: event response
    func backAction() -> Void {
        
        navigationController?.popViewController(animated: true)
    }
    
    func networkDidChange(_ notificate: Notification) -> Void {
    
        networkNoticeView?.isHidden = (notificate.object as! Bool)
    }
    
    //MARK:add notification
    func addNotificate() {
    
        let notification = Notification.Name(rawValue: NOTIFICATIONMACROS_NETWORK_MONITOR)
        NotificationCenter.default.addObserver(self, selector: #selector(networkDidChange(_:)), name: notification, object: nil)
    }
    
    //MARK: init subview
    private func initNavLeftItem() -> Void {
        
        guard navigationController != nil && (navigationController?.viewControllers.count)! > 1 else {
            
            return
        }
        
        let leftItem:UIButton    = UIButton(type: .custom)
        leftItem.frame           = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 44.0)
        leftItem.backgroundColor = UIColor.clear
        leftItem.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -10.0, bottom: 0.0, right: 20.0)
        leftItem.setImage(UIImage.init(named: "back_arrow"), for: .normal)
        leftItem.addTarget(self, action: #selector(BaseViewController.backAction), for: .touchUpInside)
        
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0))
        leftView.addSubview(leftItem)
        leftView.isUserInteractionEnabled     = true
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                       action: #selector(BaseViewController.backAction))
        leftView.addGestureRecognizer(tapGesture)
        
        let leftBarItem:UIBarButtonItem       = UIBarButtonItem(customView: leftView);
        self.navigationItem.leftBarButtonItem = leftBarItem;
    }
    
    private func initNetworkNoticeView() {
    
        if networkNoticeView == nil {
            
            let noticeView      = UIView()
            noticeView.isHidden = true
            noticeView.qh_height(30.0)
            noticeView.qh_width(view.qh_width())
            noticeView.qh_x(0.0)
            noticeView.qh_y(0.0)
            noticeView.backgroundColor = UIColor.qh_colorWithHex(hexColor: 0xff3574, alpha: 0.6)
            view.addSubview(noticeView)
            networkNoticeView = noticeView
            
            let noticeLabel             = UILabel(frame: noticeView.bounds)
            noticeLabel.backgroundColor = .clear
            noticeLabel.textColor       = .white
            noticeLabel.font            = APPMACROS_MAIN_FONT
            noticeLabel.text            = "当前无网络，请检查您的网络设置"
            noticeLabel.qh_x(APPMACROS_BASE_MARGIN * 2)
            noticeView.addSubview(noticeLabel)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BaseViewController: IsLoginProtocal {
    
    func isNeedLogin() -> Bool {
        
        return true
    }
}
