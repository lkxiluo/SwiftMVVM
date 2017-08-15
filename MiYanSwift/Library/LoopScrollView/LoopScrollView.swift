//
//  LoopScrollView.swift
//  LibrarySwift
//
//  Created by 罗坤 on 2017/5/4.
//  Copyright © 2017年 Qianhan. All rights reserved.
//

import UIKit
import Foundation

protocol LoopScrollViewDelegate:NSObjectProtocol {
    
    func selectedItem(loopScrollView:LoopScrollView, index: NSInteger) -> Void
}

/// 轮播图
final class LoopScrollView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    static let cellId:String = "loopItemCellId"
    private var theCollectionView:UICollectionView!
    private var pageControll:UIPageControl = UIPageControl()
    private var imageNames:[String]! = []     // 本地图片集合
    private var imageUrls:[String]!  = []     // 网络图片URL集合
    private var timer:Timer!                  // 倒计时对象
    private var timerCount:NSInteger = 0      // 倒计时数
    weak var delegate:LoopScrollViewDelegate?
    
    var animationTime:TimeInterval = 5.0 {    // 图片轮换的时间
        
        didSet {
            
            self.reloadData()
        }
    }
    
    private var currentIndexPath:IndexPath = IndexPath(row: 0, section: 0)
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
        self.timer.invalidate()
        self.timer = nil
    }
    
    // MARK: public method
    func setImageNames(names: [String]) -> Void {
        
        if self.imageUrls.count > 0 {
            
            self.imageUrls.removeAll()
        }
        self.imageNames = names
        if self.imageNames.count > 0 {
            
            self.reloadData()
        }
    }
    
    func setImageUrls(urls: [String]) -> Void {
        
        if self.imageNames.count > 0 {
            
            self.imageNames.removeAll()
        }
        self.imageUrls = urls
        if self.imageUrls.count > 0 {
            
            self.reloadData()
        }
    }
    
    private func setupView() -> Void {
        self.initTheCollectionView()
        self.addSubview(self.pageControll)
    }
    
    // MARK:UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return self.itemCount() == 1 ? 1 : 3
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return self.itemCount()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:LoopCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: LoopScrollView.cellId,
                                                                             for: indexPath) as! LoopCollectionViewCell
        if self.imageNames.count > 0 {
            
            cell.configData(name: self.imageNames[indexPath.row])
        } else {
            
            cell.configData(url: self.imageUrls[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.delegate?.selectedItem(loopScrollView: self, index: indexPath.row)
    }
    
    // MARK: scrollDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let point = CGPoint(x: scrollView.contentOffset.x + scrollView.qh_width() / 2,
                            y: scrollView.qh_height() / 2)
        let indexPath:IndexPath       = self.theCollectionView.indexPathForItem(at: point)!
        self.pageControll.currentPage = indexPath.row
        self.initTimer()
        self.timerCount       = indexPath.row
        if indexPath.section != self.currentIndexPath.section
        || self.currentIndexPath.section != 1 {
            
            self.currentIndexPath =  indexPath
            self.resetPosition()
        } else {
            
            self.currentIndexPath =  indexPath
        }
    }
    
    // MARK: private method
    private func itemCount() -> NSInteger {
        
        return self.imageNames.count > 0 ? self.imageNames.count : self.imageUrls.count
    }
    
    /// 重新加载
    private func reloadData() -> Void {
        
        self.initPageController()
        self.theCollectionView.reloadData()
        self.resetPosition()
        self.initTimer()
    }
    
    /// 重新定位
    private func resetPosition() -> Void {
        
        if self.itemCount() > 1 {
            
            let indexPath:IndexPath       = IndexPath(row: self.currentIndexPath.row, section: 1)
            self.loopScrollView(indexPath: indexPath, animated: false)
        }
    }
    
    @objc private func loopTimer() -> Void {
        
        self.timerCount += 1
        let row:Int = self.timerCount % self.itemCount()
        
        // 当切换的第一个的时候，先转到下个section
        if row == 0 {
            
            let indexPath:IndexPath = IndexPath(row: row, section: 2)
            self.loopScrollView(indexPath: indexPath, animated: true)
        } else {
            
            if row == 1 {
                
                let indexPath:IndexPath = IndexPath(row: 0, section: 1)
                self.loopScrollView(indexPath: indexPath, animated: false)
            }
            let indexPath:IndexPath = IndexPath(row: row, section: 1)
            self.loopScrollView(indexPath: indexPath, animated: true)
        }
    }
    
    private func loopScrollView(indexPath:IndexPath, animated: Bool) -> Void {
        
        self.currentIndexPath         = indexPath
        self.pageControll.currentPage = indexPath.row
        self.theCollectionView.scrollToItem(at: indexPath as IndexPath,
                                            at: .centeredHorizontally,
                                            animated: animated)
    }
    
    // MARK:初始化
    private func initTheCollectionView() -> Void {
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing             = 0.0
        layout.minimumInteritemSpacing        = 0.0
        layout.scrollDirection                = .horizontal
        layout.estimatedItemSize              = CGSize(width: self.frame.size.width,
                                                       height: self.frame.size.height)
        
        self.theCollectionView = UICollectionView(frame: self.bounds,
                                                  collectionViewLayout: layout)
        self.theCollectionView.backgroundColor                = UIColor.clear
        self.theCollectionView.delegate                       = self
        self.theCollectionView.dataSource                     = self
        self.theCollectionView.showsVerticalScrollIndicator   = false
        self.theCollectionView.showsHorizontalScrollIndicator = false
        self.theCollectionView.isPagingEnabled                = true
        
        self.theCollectionView.register(LoopCollectionViewCell.self,
                                        forCellWithReuseIdentifier: LoopScrollView.cellId)
        
        self.addSubview(self.theCollectionView)
    }
    
    private func initPageController() -> Void {

        let height:CGFloat = 20.0
        self.pageControll.frame                         = CGRect(x: 0.0,
                                                                 y: self.qh_height() - height,
                                                                 width: self.qh_width(),
                                                                 height: height)
        self.pageControll.currentPage                   = 0
        self.pageControll.numberOfPages                 = self.itemCount()
        self.pageControll.currentPageIndicatorTintColor = APPMACROS_MAINCOLOR
        self.pageControll.pageIndicatorTintColor        = UIColor.white
        self.pageControll.isUserInteractionEnabled      = false
    }
    
    private func initTimer() -> Void {
        
        if self.timer == nil {
            
            if self.itemCount() > 1 {
                
                self.timerCount = 0
                self.timer = Timer(timeInterval: self.animationTime,
                                   target: self,
                                   selector: #selector(LoopScrollView.loopTimer),
                                   userInfo: nil,
                                   repeats: true)
                RunLoop.current.add(self.timer, forMode: .commonModes)
            }
        } else {
            
            self.timer.invalidate()
            self.timer = nil
            self.initTimer()
        }
    }
}
