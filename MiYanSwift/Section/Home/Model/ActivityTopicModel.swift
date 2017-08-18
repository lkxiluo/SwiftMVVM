//
//  ActivityTopicModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 限时活动
class ActivityTopicModel: BaseModel {

    var bannerImageURL: String?
    var bannerLink: String?
    var activityEndTime: IntMax?
    var activityId: String?
    var activityList: [GoodsModel]?
    
    override func analysizeModel(analysizeBody: JSON) -> Any {
        
        let activite: ActivityTopicModel = ActivityTopicModel()
        
        activite.bannerImageURL  = analysizeBody["banner_img"].stringValue
        activite.bannerLink      = analysizeBody["banner_link"].stringValue
        activite.activityEndTime = analysizeBody["activity_end_time"].int64
        activite.activityId      = analysizeBody["activity_id"].stringValue
        let activityListJson     = analysizeBody["activity_list"].array
        for goodsJson in activityListJson! {
            
            let goodsModel: GoodsModel = GoodsModel().analysizeModel(analysizeBody: goodsJson) as! GoodsModel
            activityList?.append(goodsModel)
        }
        
        return activite
    }
}
