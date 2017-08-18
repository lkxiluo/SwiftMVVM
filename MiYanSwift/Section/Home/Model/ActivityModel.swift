//
//  ActivetyModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import SwiftyJSON

class ActivityModel: BaseModel {

    var title: String?
    var desc: String?
    var imageURL: String?
    var linkType: Int?
    var linkValue: String?
    
    override func analysizeModel(analysizeBody: JSON) -> Any {
        
        let activety: ActivityModel = ActivityModel()
        
        activety.title     = analysizeBody["title"].stringValue
        activety.desc      = analysizeBody["desc"].stringValue
        activety.imageURL  = analysizeBody["image"].stringValue
        activety.linkType  = analysizeBody["link_type"].intValue
        activety.linkValue = analysizeBody["link_value"].stringValue
        
        return activety
    }
}
