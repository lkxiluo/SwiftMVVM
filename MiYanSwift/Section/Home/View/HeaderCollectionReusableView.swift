//
//  HeaderCollectionReusableView.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/18.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit

/// 首页推荐的列表页眉
class HeaderCollectionReusableView: UICollectionReusableView {
    
    private var titleItem: UIButton?
    var headerModel: SectionHeader? {
    
        didSet {
        
            titleItem?.setTitle(headerModel?.sectionTitle, for: .normal)
            titleItem?.setImage(UIImage(named: (headerModel?.imageName)!), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = APPMACROS_MAIN_BACKGROUND
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private method
    private func setupView() {
    
        initTitleItem()
    }
    
    // MARK: init subview
    private func initTitleItem() {
    
        titleItem = UIButton(type: .custom)
        titleItem?.frame = CGRect(x: 0.0, y: APPMACROS_BASE_MARGIN * 2, width: self.qh_width(), height: self.qh_height() - APPMACROS_BASE_MARGIN * 2)
        titleItem?.backgroundColor = .white
        titleItem?.isUserInteractionEnabled = false
        titleItem?.setTitleColor(APPMACROS_MAIN_TEXTCOLOR, for: .normal)
        titleItem?.titleLabel?.font = APPMACROS_MAIN_FONT
        titleItem?.layoutContains(imagePosition: .left, margin: APPMACROS_BASE_MARGIN)
        self.addSubview(titleItem!)
    }
}
