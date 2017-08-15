//
//  TabBarViewController.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/5.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    private var tabItems:NSMutableArray = NSMutableArray.init()
    var theTabbar:TabBar?
    
    // MARK: - override
    override func viewDidLoad() {
        
        super.viewDidLoad();
        self.addChildViewControllers()
        self.addTabBar()
        self.theTabbar?.badgeValue(value: 9, index: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated);
        self.moveTabBarSubView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - private method
    /// 删除非自定义的子视图
    private func moveTabBarSubView() -> Void {
        
        for subView:UIView in self.tabBar.subviews {
            
            if !(subView is TabBar) {
                
                subView.removeFromSuperview()
            }
        }
    }
    
    private func addTabBar() -> Void {
        
        self.theTabbar           = TabBar.init(frame: self.tabBar.bounds)
        self.theTabbar!.tabItems = self.tabItems as? Array<TabItem>
        self.theTabbar!.delegate = self
        self.tabBar.addSubview(self.theTabbar!)
    }
    
    private func addChildViewControllers() -> Void {
        
        let purchasePageViewController:PurchasePageViewController = PurchasePageViewController()
        self.addChildViewController(childViewController: purchasePageViewController,
                                    title: "进货",
                                    image: UIImage.init(named: "tabbar_purchase")!,
                                    selectedImage: UIImage.init(named: "tabbar_purchase_selected")!)
        
        
        let cartViewController:CartViewController = CartViewController()
        self.addChildViewController(childViewController: cartViewController,
                                    title: "购物车",
                                    image: UIImage.init(named: "tabbar_cart")!,
                                    selectedImage: UIImage.init(named: "tabbar_cart_selected")!)
        
        let storeHomeViewController:StoreHomeViewController = StoreHomeViewController()
        self.addChildViewController(childViewController: storeHomeViewController,
                                    title: "店铺",
                                    image: UIImage.init(named: "tabbar_shipping")!,
                                    selectedImage: UIImage.init(named: "tabbar_shipping_selected")!)
        
        let mineViewController:MineCenterViewController = MineCenterViewController()
        self.addChildViewController(childViewController: mineViewController,
                                    title: "我的",
                                    image: UIImage.init(named: "tabbar_user")!,
                                    selectedImage: UIImage.init(named: "tabbar_user_selected")!)
    }
    
    private func addChildViewController(childViewController:UIViewController,
                                        title:NSString,
                                        image:UIImage,
                                        selectedImage:UIImage) {
        
        let baseNavigationController:NavigationViewController = NavigationViewController(rootViewController:childViewController);
        self.addChildViewController(baseNavigationController)
        
        let tabItem:TabItem = TabItem.instance(image: image,
                                               selectedImage: selectedImage,
                                               title: title)
        tabItem.badgeBackgroundColor = APPMACROS_MAINCOLOR
        self.tabItems.add(tabItem)
    }
}

// MARK: - TabBarDelegate
extension TabBarViewController: TabBarDelegate {

    func selectItem(tabBar: TabBar, index: NSInteger) {
        self.selectedIndex = index
    }
}
