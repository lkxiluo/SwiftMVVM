//
//  PurchasePageViewController.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/5.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import PageMenu

class PurchasePageViewController: BaseViewController {

    var tabMenu: CAPSPageMenu?
    var searchButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "进货"
        view.backgroundColor = .white
        setupView()
    }
    
    // MARK: event response
    func categoryAction(_ sender: UIButton) -> Void {
        
        QHLog("分类")
    }
    
    func searchBUttonAction() -> Void {
        
        QHLog("搜索")
    }
    
    // MARK: private method
    private func setupView() ->Void {
        
        initChildViewController()
        initCategoryButton()
        initSearchButton()
    }
    
    // MARK: init subview
    /// 添加子控制器
    private func initChildViewController() {
    
        var childViewControllers: [UIViewController] = []
        let recommentViewController   = RecommentViewController()
        recommentViewController.title = "推荐"
        childViewControllers.append(recommentViewController)
        
        let grassViewController   = GrassViewController()
        grassViewController.title = "种草"
        childViewControllers.append(grassViewController)
        
        let videoViewController   = VideoViewController()
        videoViewController.title = "视频"
        childViewControllers.append(videoViewController)
        
        let menuConfig: [CAPSPageMenuOption] = [
            
            .MenuItemSeparatorWidth(0.0),
            .ScrollMenuBackgroundColor(.white),
            .ViewBackgroundColor(.white),
            .BottomMenuHairlineColor(APPMACROS_LINECOLOR),
            .SelectionIndicatorColor(APPMACROS_MAINCOLOR),
            .MenuMargin(20.0),
            .MenuHeight(44.0),
            .SelectedMenuItemLabelColor(APPMACROS_MAINCOLOR),
            .UnselectedMenuItemLabelColor(APPMACROS_MAIN_TEXTCOLOR),
            .MenuItemFont(APPMACROS_MAIN_FONT),
            .UseMenuLikeSegmentedControl(true),
            .MenuItemSeparatorRoundEdges(true),
            .SelectionIndicatorHeight(1.0),
            .MenuItemSeparatorPercentageHeight(0.1)
        ]
        
        tabMenu = CAPSPageMenu(viewControllers: childViewControllers, frame: self.view.bounds, pageMenuOptions: menuConfig)
        tabMenu?.delegate = self
        self.view.addSubview((tabMenu?.view)!)
    }
    
    private func initCategoryButton() {
    
        let rightButton = UIButton(type: .custom)
        rightButton.frame = CGRect(x: 0.0,
                                   y: 0.0,
                                   width: 36.0,
                                   height: (self.navigationController?.navigationBar.qh_height())!)
        rightButton.titleLabel?.font = APPMACROS_SUB2_FONT
        rightButton.setTitleColor(APPMACROS_MAIN_TEXTCOLOR, for: .normal)
        rightButton.setTitle("分类", for: .normal)
        rightButton.setImage(UIImage(named: "puichase_navigate_category"), for: .normal)
        rightButton.addTarget(self, action: #selector(categoryAction(_:)), for: .touchUpInside)
        rightButton.layoutContains(imagePosition: .top, margin: APPMACROS_BASE_MARGIN)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    
    private func initSearchButton() {
    
        let searchButton = UIButton(type: .custom)
        searchButton.frame = CGRect(x: 0.0, y: 0.0, width: SYSTEMMACROS_SCREEN_WIDTH - 74.0, height: 30.0)
        searchButton.titleLabel?.font = APPMACROS_MAIN_FONT
        searchButton.setTitleColor(APPMACROS_SUB1_TEXTCOLOR, for: .normal)
        searchButton.backgroundColor     = APPMACROS_LINECOLOR
        searchButton.layer.cornerRadius  = 3.0
        searchButton.layer.masksToBounds = true
        searchButton.setTitle("请输入搜索商品名", for: .normal)
        searchButton.setImage(UIImage(named: "purchase_search"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchBUttonAction), for: .touchUpInside)
        searchButton.layoutContains(imagePosition: .left, margin: APPMACROS_BASE_MARGIN)
        self.searchButton = searchButton
        self.navigationItem.titleView = searchButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension PurchasePageViewController: CAPSPageMenuDelegate {

    func willMoveToPage(controller: UIViewController, index: Int) {
        
    }
    
    func didMoveToPage(controller: UIViewController, index: Int) {
        
    }
}
