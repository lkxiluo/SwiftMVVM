//
//  ShoseIconsCollectionViewCell.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/17.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import Kingfisher

class ShoseIconsCollectionViewCell: UICollectionViewCell {
    
    var scrollView = UIScrollView()
    var shoseIconViewModel: RecommentShosenIconViewModel = RecommentShosenIconViewModel() {
    
        didSet {
        
            removeSubView()
            addShoseIconItem()
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: event response
    func iconItemAction() {
    
        QHLog("图标选项操作")
    }
    
    // MARK: private method
    private func setupView() {
    
        initScrollView()
    }
    
    private func removeSubView() {
    
        for subView in scrollView.subviews {
            
            subView.removeFromSuperview()
        }
    }
    
    private func addShoseIconItem() {
    
        let itemWidth  = contentView.qh_width() / 5.0
        let iconHeight = contentView.qh_height()
        var offsetX    = 0.0
        
        for shoseIconModel in shoseIconViewModel.shoseIcons {
            
            let iconItem   = UIButton(type: .custom)
            iconItem.frame = CGRect(x: Double(offsetX), y: 0.0, width: Double(itemWidth), height: Double(iconHeight))
            iconItem.backgroundColor = .clear
            iconItem.clipsToBounds   = true
            iconItem.setTitleColor(APPMACROS_MAIN_TEXTCOLOR, for: .normal)
            iconItem.titleLabel?.font = APPMACROS_SUB1_FONT
            iconItem.setTitle(shoseIconModel.iconTitle, for: .normal)
            iconItem.kf.setImage(with: URL(string: shoseIconModel.iconImageURL!), for: .normal)
            iconItem.addTarget(self, action: #selector(iconItemAction), for: .touchUpInside)
            iconItem.layoutContains(imagePosition: .left, margin: 3.0)
            
            scrollView.addSubview(iconItem)
            offsetX += Double(itemWidth)
            scrollView.contentSize = CGSize(width: Double(offsetX), height: Double(contentView.qh_height()))
        }
    }
    
    // MARK: init subview
    private func initScrollView() {
    
        scrollView.frame                          = contentView.bounds
        scrollView.backgroundColor                = .white
        scrollView.showsVerticalScrollIndicator   = false
        scrollView.showsHorizontalScrollIndicator = false
        contentView.addSubview(scrollView)
    }
}
