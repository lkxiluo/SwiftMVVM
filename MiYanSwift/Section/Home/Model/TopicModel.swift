//
//  TopicModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 专题推荐
class TopicModel: BaseModel {

    var imageURL: String?
    var linkType: Int?
    var linkValue: String?
    
    override func analysizeModel(analysizeBody: JSON) -> Any {
        
        let topic: TopicModel = TopicModel()
        
        topic.imageURL = analysizeBody["image"].stringValue
        topic.linkType = analysizeBody["link_type"].intValue
        topic.linkValue = analysizeBody[""].stringValue
        
        return topic
    }
}
