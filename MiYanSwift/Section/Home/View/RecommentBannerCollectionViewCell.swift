//
//  RecommentBannerCollectionViewCell.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/17.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import FSPagerView

class RecommentBannerCollectionViewCell: UICollectionViewCell {
    
    var bannerView: LoopScrollView?
    var bannerViewModel: RecommentBannerViewModel? {
    
        didSet {
        
            guard (bannerViewModel?.banners.count)! > 0 else {
                return
            }
            
            var imageURLs: [String] = [String]()
            for bannerModel in (bannerViewModel?.banners)! {
                
                imageURLs.append(bannerModel.imageURL!)
            }
            bannerView?.setImageUrls(urls: imageURLs)
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
    
        initBannerView()
    }
    
    // MARK: init subview
    func initBannerView() {
    
        bannerView = LoopScrollView(frame: self.contentView.bounds)
        bannerView?.pageDotColor = APPMACROS_MAINCOLOR
        contentView.addSubview(bannerView!)
    }
}
