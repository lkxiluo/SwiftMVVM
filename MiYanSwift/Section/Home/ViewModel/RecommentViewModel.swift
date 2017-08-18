//
//  RecommentViewModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit

final class RecommentViewModel: RecommentViewModelProtocol {

    var message   = ""
    var isSuccess = true
    var items: [RecommentDateProtocol]     = []
    var recommentModel: RecommentBaseModel = RecommentBaseModel()
    func loadRecommentData(completeHandler: @escaping (_ message: String, _ isSuccess: Bool) -> Void) -> Void {
        
        let dispatchGroup = DispatchGroup()
        let queueRequest = DispatchQueue.global()
        queueRequest.async(group: dispatchGroup) {
         
            let semaphore = DispatchSemaphore(value: 0)
            self.recommentModel.loadRecommentDate { (message: String, isSuccess: Bool) in
                
                semaphore.signal()
                self.message   = message
                self.isSuccess = isSuccess
            }
            
            let result = semaphore.wait(timeout: DispatchTime.distantFuture)
            if(result == DispatchTimeoutResult.success) {
                
                self.items.removeAll()
                
                let bannerViewModel: RecommentBannerViewModel = RecommentBannerViewModel()
                bannerViewModel.banners                       = self.recommentModel.banners
                self.items.append(bannerViewModel)
                
                let shoseIconViewModel        = RecommentShosenIconViewModel()
                shoseIconViewModel.shoseIcons = self.recommentModel.shoseIcons
                self.items.append(shoseIconViewModel)
                
                let hotCategoryViewModel         = RecommentHotCategoryViewModel()
                hotCategoryViewModel.hotCategory = self.recommentModel.hotCategorys
                self.items.append(hotCategoryViewModel)
                
                let wholeSaleViewModel            = RecommentWholeSaleViewModel()
                wholeSaleViewModel.wholeSaleGoods = self.recommentModel.wholeSale.list
                self.items.append(wholeSaleViewModel)
                
                let activityOneViewModel       = RecommentActivityModel()
                activityOneViewModel.activitys = self.recommentModel.activitysOne
                self.items.append(activityOneViewModel)
                
                let activityTopicViewModel           = RecommentActivityTopicViewModel()
                activityTopicViewModel.activityGoods = self.recommentModel.activityTopics
                self.items.append(activityTopicViewModel)
                
                let activityTwoViewModel       = RecommentActivityModel()
                activityTwoViewModel.activitys = self.recommentModel.activitysTwo
                self.items.append(activityTwoViewModel)
            }
        }
        
        dispatchGroup.notify(queue: queueRequest) {
            
            QHLog("请求结束")
            DispatchQueue.main.async {
                
                completeHandler(self.message, self.isSuccess)
            }
        }
    }
}
