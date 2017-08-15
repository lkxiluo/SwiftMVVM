//
//  RecommentViewController.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/7.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit

/// 进货->推荐

//MARK: - public method

//MARK:  - life cyclic
class RecommentViewController: BaseViewController {
    
    var recommentCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        QHLog("首页推荐")
    }
    
    // MARK: private method
    
    // MARK: init subview
    private func initRecommentCollectionView() -> Void {
    
        let layout = UICollectionViewFlowLayout()
        recommentCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        recommentCollectionView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        recommentCollectionView?.delegate   = self
        recommentCollectionView?.dataSource = self
        view.addSubview(recommentCollectionView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension RecommentViewController: UICollectionViewDataSource {

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
}

extension RecommentViewController: UICollectionViewDelegate {

}
