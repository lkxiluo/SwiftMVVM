//
//  RecommentBaseModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/15.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RecommentBaseModel: BaseModel {

    var banners: [BannerModel]               = [BannerModel]()
    var shoseIcons: [ShosenIconModel]        = [ShosenIconModel]()
    var hotCategorys: [HotCategoryModel]     = [HotCategoryModel]()
    var wholeSale: WholeSaleModel            = WholeSaleModel()
    var activitysOne: [ActivityModel]        = [ActivityModel]()
    var topics: [TopicModel]                 = [TopicModel]()
    var activitysTwo: [ActivityModel]        = [ActivityModel]()
    var activityTopics: [ActivityTopicModel] = [ActivityTopicModel]()
    var goods: [GoodsModel]                  = [GoodsModel]()
    
    func loadRecommentDate(completeHandler: @escaping (_ message: String, _ isSuccess: Bool) -> Void) -> Void {
    
        let params = Parameters()
        RecommentBaseRequest().starRequest(parameters: params, completeSuccess: { (responseJson: Any) in
            
            QHLog("\(responseJson)")
            let responseJs = JSON(responseJson)
            let message    = responseJs["msg"].stringValue
            let ret        = responseJs["ret"].intValue
            guard ret == 200 else {
            
                completeHandler(message, false)
                return
            }
            
            let data = responseJs["data"].dictionary
            let code = data?["code"]?.intValue
            let info = data?["info"]?.dictionary
            if code == 0 {
                
                self.analysizeInfoDatas(info: info!)
                completeHandler(message, true)
            } else {
                
                completeHandler(message, false)
            }
        }) { (error: Error) in
            
            completeHandler(error.localizedDescription, false)
        }
    }
    
    private func analysizeInfoDatas(info: [String: JSON]) {
    
        analysizeBanners(info: info)
        analysizeShoseIcons(info: info)
        analysizeHotCategorys(info: info)
        analysizeWholeSales(info: info)
        anylysizeActivityOnes(info: info)
        analysizeActivityTopics(info: info)
        anylysizeActivityTwos(info: info)
    }
    
    private func analysizeBanners(info: [String: JSON]) {
        
        let bannerInfos = info["banners"]?.array
        banners.removeAll()
        for bannerInfo in bannerInfos! {
            
            let banner = BannerModel().analysizeModel(analysizeBody: bannerInfo)
            banners.append(banner as! BannerModel)
        }
    }
    
    private func analysizeShoseIcons(info: [String: JSON]) {
    
        let choseIconInfos = info["chosen_icons"]?.array
        shoseIcons.removeAll()
        for shoseIconInfo in choseIconInfos! {
            
            let shoseIcon = ShosenIconModel().analysizeModel(analysizeBody: shoseIconInfo)
            shoseIcons.append(shoseIcon as! ShosenIconModel)
        }
    }
    
    private func analysizeHotCategorys(info: [String: JSON]) {
    
        let hotCategoryInfos = info["hot_category"]?.array
        hotCategorys.removeAll()
        for hotCategoryInfo in hotCategoryInfos! {
            
            let hotCategory = HotCategoryModel().analysizeModel(analysizeBody: hotCategoryInfo)
            hotCategorys.append(hotCategory as! HotCategoryModel)
        }
    }
    
    private func analysizeWholeSales(info: [String: JSON]) {
    
        let wholeSaleInfo = info["wholesale_offers"]
        wholeSale = WholeSaleModel().analysizeModel(analysizeBody: wholeSaleInfo!) as! WholeSaleModel
    }
    
    private func anylysizeActivityOnes(info: [String: JSON]) {
    
        let positionOnes = info["position_one"]?.array
        activitysOne.removeAll()
        for positionInfo in positionOnes! {
            
            let position = ActivityModel().analysizeModel(analysizeBody: positionInfo)
            activitysOne.append(position as! ActivityModel)
        }
    }
    
    private func analysizeActivityTopics(info: [String: JSON]) {
    
        let activityTopicInfos = info["activity_topics"]?.array
        activityTopics.removeAll()
        for activityTopicInfo in activityTopicInfos! {
            
            let activityTopic = ActivityTopicModel().analysizeModel(analysizeBody: activityTopicInfo)
            activityTopics.append(activityTopic as! ActivityTopicModel)
        }
    }
    
    private func anylysizeActivityTwos(info: [String: JSON]) {
        
        let positionOnes = info["position_two"]?.array
        activitysTwo.removeAll()
        for positionInfo in positionOnes! {
            
            let position = ActivityModel().analysizeModel(analysizeBody: positionInfo)
            activitysTwo.append(position as! ActivityModel)
        }
    }
}
