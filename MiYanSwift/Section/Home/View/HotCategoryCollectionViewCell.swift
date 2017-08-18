//
//  HotCategoryCollectionViewCell.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/18.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit

fileprivate let kItemCellIdentifier = "kItemCellIdentifier"
class HotCategoryCollectionViewCell: UICollectionViewCell {
    
    var itemCollectionView: UICollectionView?
    var hotCategoryViewModel: RecommentHotCategoryViewModel = RecommentHotCategoryViewModel() {
    
        didSet {
        
            itemCollectionView?.reloadData()
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

        initItemCollectionView()
    }
    
    // MARK: init subview
    private func initItemCollectionView() {
    
        let space  = APPMACROS_BASE_MARGIN * 2
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection    = .horizontal
        layout.itemSize           = CGSize(width: FITSCREEN(f: 73.0), height: 73.0)
        layout.minimumLineSpacing = space
        layout.sectionInset       = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        
        itemCollectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: layout)
        itemCollectionView?.showsVerticalScrollIndicator   = false
        itemCollectionView?.showsHorizontalScrollIndicator = false
        itemCollectionView?.delegate   = self
        itemCollectionView?.dataSource = self
        itemCollectionView?.backgroundColor = .white
        itemCollectionView?.register(HotCateItemCollectionViewCell.self, forCellWithReuseIdentifier: kItemCellIdentifier)
        
        contentView.addSubview(itemCollectionView!)
    }
}

extension HotCategoryCollectionViewCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return hotCategoryViewModel.hotCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let viewModel = hotCategoryViewModel.hotCategory[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kItemCellIdentifier, for: indexPath) as! HotCateItemCollectionViewCell
        cell.viewModel = viewModel
        return cell
    }
}

extension HotCategoryCollectionViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
