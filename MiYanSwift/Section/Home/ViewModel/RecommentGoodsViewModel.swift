//
//  RecommentGoodsViewModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation


final class RecommentGoodsViewModel: RecommentDateProtocol {

    var dateType: RecommemtDateType {
    
        return .goods
    }
    var sectionFooterTitle: String {
    
        return ""
    }
    
    var rowCount: Int = 0
    var sectionHeader: SectionHeader =  SectionHeader(imageName: "", sectionTitle: "人气推荐", isShow: true)
    var goodsList: [GoodsModel] = [GoodsModel]() {
    
        didSet {
        
            rowCount = goodsList.count
        }
    }
}
