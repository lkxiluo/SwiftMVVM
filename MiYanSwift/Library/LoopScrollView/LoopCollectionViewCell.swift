//
//  LoopCollectionViewCell.swift
//  LibrarySwift
//
//  Created by 罗坤 on 2017/5/4.
//  Copyright © 2017年 Qianhan. All rights reserved.
//

import UIKit
import Kingfisher.Swift

final class LoopCollectionViewCell: UICollectionViewCell {
    
    private var itemImageView:UIImageView!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.initItemImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.itemImageView.frame = self.bounds
    }
    
    func configData(name: String) -> Void {
        
        self.itemImageView.image = UIImage.init(named: name)
    }
    
    func configData(url: String) -> Void {
        
        let imageUrl = URL(string: url)
        self.itemImageView.kf.setImage(with: imageUrl,
                                       placeholder: UIImage.init(named: "loop_place"),
                                       options: [.transition(ImageTransition.fade(1))],
                                       progressBlock: nil,
                                       completionHandler: nil)
    }
    
    // MARK:初始化
    private func initItemImageView() -> Void {
        
        if self.itemImageView == nil {
            
            self.itemImageView                 = UIImageView()
            self.itemImageView.frame           = self.bounds
            self.itemImageView.backgroundColor = UIColor.clear
            self.itemImageView.contentMode     = .scaleAspectFill
            self.contentView.addSubview(self.itemImageView)
        }
    }
}
