//
//  HotCategoryModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 热门分类
class HotCategoryModel: BaseModel {

    var ID: String?
    var name: String?
    var imageURL: String?
    var linkTitle: String?
    var linkType: Int?
    var linkValue: String?
    
    override func analysizeModel(analysizeBody: JSON) -> Any {
        
        let hoteCategory: HotCategoryModel = HotCategoryModel()
        
        hoteCategory.ID        = analysizeBody["id"].stringValue
        hoteCategory.name      = analysizeBody["cate_name"].stringValue
        hoteCategory.imageURL  = analysizeBody["image"].stringValue
        hoteCategory.linkTitle = analysizeBody["link_title"].stringValue
        hoteCategory.linkType  = analysizeBody["link_type"].intValue
        hoteCategory.linkValue = analysizeBody["link_value"].stringValue
        
        return hoteCategory
    }
}
