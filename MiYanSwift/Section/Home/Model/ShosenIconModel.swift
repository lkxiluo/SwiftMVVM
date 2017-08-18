//
//  ShosenIconModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 图标选项
class ShosenIconModel: BaseModel {

    var ID: String?
    var iconTitle: String?
    var iconImageURL: String?
    var linkType: Int?
    var linkValue: String?
    var noticeMessage: String?
    
    override func analysizeModel(analysizeBody: JSON) -> Any {
        
        let shose: ShosenIconModel = ShosenIconModel()
        
        shose.ID            = analysizeBody["id"].stringValue
        shose.iconTitle     = analysizeBody["icon_title"].stringValue
        shose.iconImageURL  = analysizeBody["icon_image"].stringValue
        shose.linkType      = analysizeBody["link_type"].intValue
        shose.linkValue     = analysizeBody["link_value"].stringValue
        shose.noticeMessage = analysizeBody["notice_msg"].stringValue
        
        return shose
    }
}
