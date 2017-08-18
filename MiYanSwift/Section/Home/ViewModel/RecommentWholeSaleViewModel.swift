//
//  RecommentWholeSaleViewModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation


final class RecommentWholeSaleViewModel: RecommentDateProtocol {
    
    var dateType: RecommemtDateType {
   
        return .wholeSale
    }
    var sectionHeader: SectionHeader = SectionHeader(imageName: "recomment_whole_sale", sectionTitle: "批发特惠", isShow: true)
    var sectionFooterTitle: String {
    
        return ""
    }
    var wholeSaleGoods: [GoodsModel] = [GoodsModel]()
}
