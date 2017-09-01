//
//  RecommentViewController.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/7.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import ESPullToRefresh

fileprivate let kBannerCellIdentifier        = "kBannerCellIdentifier"
fileprivate let kShoseCellIdentifier         = "kShoseCellIdentifier"
fileprivate let kHotCategoryCellIndetifier   = "kHotCategoryCellIndetifier"
fileprivate let kWholeSaleCellIdentifier     = "kWholeSaleCellIdentifier"
fileprivate let kActivityCellIdentifier      = "kActivityCellIdentifier"
fileprivate let kActivityTopicCellIdentifier = "kActivityTopicCellIdentifier"
fileprivate let kGoodsCellIdentifier         = "kGoodsCellIdentifier"

fileprivate let kHeaderIdentifer             = "kHeaderIdentifer"

//MARK:  - life cyclic
/// 进货->推荐
class RecommentViewController: BaseViewController {
    
    var viewModel: RecommentViewModel = RecommentViewModel() {
    
        didSet {
        
            QHLog("Do something change")
        }
    }
    var recommentCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: private method
    func setupView() {
    
        initRecommentCollectionView()
    }
    
    // MARK: init subview
    private func initRecommentCollectionView() -> Void {
    
        let layout = UICollectionViewFlowLayout()
        recommentCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        recommentCollectionView?.backgroundColor  = .white
        recommentCollectionView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        recommentCollectionView?.showsVerticalScrollIndicator = false
        recommentCollectionView?.showsHorizontalScrollIndicator = false
        recommentCollectionView?.alwaysBounceVertical = true
        recommentCollectionView?.delegate   = self
        recommentCollectionView?.dataSource = self
        
        recommentCollectionView?.register(RecommentBannerCollectionViewCell.self, forCellWithReuseIdentifier: kBannerCellIdentifier)
        recommentCollectionView?.register(ShoseIconsCollectionViewCell.self, forCellWithReuseIdentifier: kShoseCellIdentifier)
        recommentCollectionView?.register(HotCategoryCollectionViewCell.self, forCellWithReuseIdentifier: kHotCategoryCellIndetifier)
        
        recommentCollectionView?.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderIdentifer)
        
        recommentCollectionView?.es_addPullToRefresh {
            
            // 下拉刷新
            ProgressHub.show()
            self.viewModel.loadRecommentData(completeHandler: { (message: String, isSuccess: Bool) in
                
                self.recommentCollectionView?.es_stopPullToRefresh()
                guard isSuccess else {
                
                    ProgressHub.showStatus(statusString: message)
                    return
                }
                ProgressHub.dismiss()
                self.recommentCollectionView?.reloadData()
            })
        }
        recommentCollectionView?.es_startPullToRefresh()
        recommentCollectionView?.es_addInfiniteScrolling {
            
            // TODO:上拉加载更多（这里只加载推荐商品）
            self.recommentCollectionView?.es_stopLoadingMore()
        }
        view.addSubview(recommentCollectionView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension RecommentViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item: RecommentDateProtocol = viewModel.items[indexPath.section]
        return item.size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let item: RecommentDateProtocol = viewModel.items[section]
        return CGSize(width: collectionView.qh_width(), height: item.sectionHeader.height)
    }
}

extension RecommentViewController: UICollectionViewDataSource {

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        let item: RecommentDateProtocol = viewModel.items[section]
        return item.rowCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item: RecommentDateProtocol = viewModel.items[indexPath.section]
        switch item.dateType {
        case .banner:
            
            let cell: RecommentBannerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: kBannerCellIdentifier, for: indexPath) as! RecommentBannerCollectionViewCell
            cell.bannerViewModel = item as? RecommentBannerViewModel
            return cell
            
        case .shoseIcon:
            
            let cell: ShoseIconsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: kShoseCellIdentifier, for: indexPath) as! ShoseIconsCollectionViewCell
            cell.shoseIconViewModel = item as! RecommentShosenIconViewModel
            return cell
            
        case .hotCategory:
            
            let cell: HotCategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: kHotCategoryCellIndetifier, for: indexPath) as! HotCategoryCollectionViewCell
            cell.hotCategoryViewModel = item as! RecommentHotCategoryViewModel
            return cell
        default:
            
            break
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            
            let item: RecommentDateProtocol = viewModel.items[indexPath.section]
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderIdentifer, for: indexPath) as! HeaderCollectionReusableView
            headerView.headerModel = item.sectionHeader
            return headerView
        }
        
        return UICollectionReusableView()
    }
}

extension RecommentViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
