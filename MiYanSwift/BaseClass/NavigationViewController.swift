//
//  WZHNavigationViewController.swift
//  WuZhouHuiSwift
//
//  Created by QianHan on 2017/4/11.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import KeychainAccess

class NavigationViewController: UINavigationController {

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let apperance:UINavigationBar = UINavigationBar.appearance()
        apperance.titleTextAttributes = [
            NSForegroundColorAttributeName: APPMACROS_MAIN_TEXTCOLOR,
            NSFontAttributeName: UIFont.systemFont(ofSize: APPMACROS_BIG_FONTSIZE)
        ];
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.viewControllers.count > 1 {
            
            self.hidesBottomBarWhenPushed = true
        }
        
        guard !presentToLoginViewController(viewController) else {
            
            return
        }
        super.pushViewController(viewController, animated: animated)
        self.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        
        guard !presentToLoginViewController(viewControllerToPresent) else {
            
            return
        }
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /// 是否要先登录
    ///
    /// - Parameter viewController: 要判断的VC
    func presentToLoginViewController(_ viewController: UIViewController) -> Bool {
        
        if viewController is BaseViewController {
            
            let keyChain = Keychain(service: NSString.my_rootUrl())
            let token    = keyChain[APPMACROS_LOGINTOKEN_KEY]
            
            let currentViewController = viewController as! BaseViewController
            if currentViewController.isNeedLogin() && token == nil {
                
                let loginViewController:LoginViewController = LoginViewController()
                let loginNavicationController:NavigationViewController = NavigationViewController(rootViewController: loginViewController)
                self.navigationController?.present(loginNavicationController, animated: true, completion: nil)
                return true
            }
        }
        
        return false
    }
}

extension NavigationViewController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if self.viewControllers.count <= 1 {
            
            return false
        }
        return true
    }
}
