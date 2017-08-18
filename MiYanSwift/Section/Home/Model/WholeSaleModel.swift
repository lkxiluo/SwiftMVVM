//
//  WholeSaleModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 批发特惠
class WholeSaleModel: BaseModel {

    var linkType: Int?
    var linkValue: String?
    var list: [GoodsModel] = [GoodsModel]()
    
    override func analysizeModel(analysizeBody: JSON) -> Any {
      
        let wholeSale: WholeSaleModel = WholeSaleModel()
        
        wholeSale.linkValue = analysizeBody["link_value"].stringValue
        wholeSale.linkType  = analysizeBody["link_type"].intValue
        let listJson = analysizeBody["list"].arrayValue
        for goodsJson in listJson {
            
            let goodsModel: GoodsModel = GoodsModel().analysizeModel(analysizeBody: goodsJson) as! GoodsModel
            list.append(goodsModel)
        }
        
        return wholeSale
    }
}
