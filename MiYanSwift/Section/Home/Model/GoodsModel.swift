//
//  GoodsModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import  SwiftyJSON

class GoodsModel: BaseModel {

    var ID: String?
    var code: String?
    var name: String?
    var thumbURL: String?
    var salePrice: String?
    
    var shopPrice: String?
    var earnTag: String?
    var activityTag: String?
    var isSaleOut: Bool?
    var wholeSaleTag: String?
    
    var saveTag: String?
    
    override func analysizeModel(analysizeBody: JSON) -> Any {
        
        let goods: GoodsModel = GoodsModel()
        
        goods.ID        = analysizeBody["id"].stringValue
        goods.code      = analysizeBody["product_code"].stringValue
        goods.name      = analysizeBody["product_name"].stringValue
        goods.thumbURL  = analysizeBody["thumb"].stringValue
        goods.salePrice = analysizeBody["sale_price"].stringValue
        
        goods.shopPrice    = analysizeBody["shopprice"].stringValue
        goods.earnTag      = analysizeBody["earn_tag"].stringValue
        goods.activityTag  = analysizeBody["activity_tag"].stringValue
        goods.isSaleOut    = analysizeBody["is_sale_out"].boolValue
        goods.wholeSaleTag = analysizeBody["wholesale_tag"].stringValue
        
        goods.saveTag =  analysizeBody["save_tag"].stringValue
        
        return goods
    }
}
