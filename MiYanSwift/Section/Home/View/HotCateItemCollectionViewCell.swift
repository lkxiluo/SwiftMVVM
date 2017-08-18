//
//  HotCateItemCollectionViewCell.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/18.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import Kingfisher

class HotCateItemCollectionViewCell: UICollectionViewCell {
    
    private var itemImageView: UIImageView?
    private var tagTitleLabel: UILabel?
    var viewModel: HotCategoryModel = HotCategoryModel() {
    
        didSet {
        
            itemImageView?.kf.setImage(with: URL(string: viewModel.imageURL!))
            tagTitleLabel?.text = viewModel.linkTitle
        }
    }
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private method
    private func setupView() {
    
        initItemImageView()
        initTagTitleLabel()
    }
    
    // MARK: init subview
    private func initItemImageView() {
    
        itemImageView = UIImageView(frame: contentView.bounds)
        itemImageView?.backgroundColor     = .white
        itemImageView?.layer.cornerRadius  = 5.0
        itemImageView?.layer.masksToBounds = true
        contentView.addSubview(itemImageView!)
    }
    
    private func initTagTitleLabel() {
    
        tagTitleLabel = UILabel(frame: CGRect(x: 0.0, y: (itemImageView?.qh_height())! - 20.0, width: (itemImageView?.qh_width())!, height: 20.0))
        tagTitleLabel?.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        tagTitleLabel?.font            = APPMACROS_SUB1_FONT
        tagTitleLabel?.textColor       = .white
        tagTitleLabel?.textAlignment   = .center
        itemImageView?.addSubview(tagTitleLabel!)
    }
}
