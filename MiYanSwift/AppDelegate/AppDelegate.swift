//
//  AppDelegate.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/7/20.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import Alamofire
import KeychainAccess

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        startNetworkMonitor()
        window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        rootViewController()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    // MARK: private method
    func rootViewController() -> Void {
        
        let keyChain = Keychain(service: NSString.my_rootUrl())
//        keyChain[APPMACROS_LOGINTOKEN_KEY] = nil
        let token    = keyChain[APPMACROS_LOGINTOKEN_KEY]
        if token != nil {
            
            QHLog(token)
            let tabBarController = TabBarViewController()
            window?.rootViewController = tabBarController
        } else {
            
            let loginViewController:LoginViewController = LoginViewController()
            let loginNavicationController:NavigationViewController = NavigationViewController(rootViewController: loginViewController)
            window?.rootViewController = loginNavicationController;
        }
    }
    /// 网络监控
    func startNetworkMonitor() -> Void {
     
        let netManager = NetworkReachabilityManager(host: "baidu.com")
        netManager?.listener = { status in
            
            let notifcation = Notification.Name(NOTIFICATIONMACROS_NETWORK_MONITOR)
            switch status {
                
            case .notReachable:
                
                QHLog("没有网络")
                NotificationCenter.default.post(name: notifcation, object: false)
            case .unknown:
                
                QHLog("未知网络")
            case .reachable(.ethernetOrWiFi):
                
                QHLog("Wifi")
                NotificationCenter.default.post(name: notifcation, object: true)
            case .reachable(.wwan):
                
                QHLog("移动网")
                NotificationCenter.default.post(name: notifcation, object: true)
            }
        }
        
        netManager?.startListening()
    }
}

