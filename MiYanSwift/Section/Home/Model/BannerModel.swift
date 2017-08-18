//
//  BannerModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 轮播图
class BannerModel: BaseModel {

    var ID: String?
    var endAt: String?
    var title: String?
    var imageURL: String?
    var linkeType: Int?
    var linkeValue: String?
    
    override func analysizeModel(analysizeBody: JSON) -> Any {
        
        let banner: BannerModel = BannerModel()
        
        banner.ID         = analysizeBody["id"].stringValue
        banner.endAt      = analysizeBody["end_at"].stringValue
        banner.title      = analysizeBody["title"].stringValue
        banner.imageURL   = analysizeBody["image"].stringValue
        banner.linkeType  = analysizeBody["link_type"].intValue
        banner.linkeValue = analysizeBody["link_value"].stringValue
        
        return banner
    }
}
