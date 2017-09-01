//
//  RecommentDateProtocol.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation
import UIKit

// 推荐页显示的数据类型
enum RecommemtDateType {
    
    case banner             // 轮播图
    case shoseIcon          // 图标选项
    case hotCategory        // 热门分类
    case wholeSale          // 批发特惠
    case activityOne        // 活动1
    case topic              // 专题推荐
    case activityTwo        // 活动2
    case activityTopic      // 专题活动
    case goods              // 推荐商品
}

struct SectionHeader {
    
    var sectionTitle: String
    var imageName: String
    var isShow: Bool
    init(imageName: String, sectionTitle: String, isShow: Bool) {
        
        self.sectionTitle = sectionTitle
        self.imageName    = imageName
        self.isShow       = isShow
    }
    var height: CGFloat {
    
        var headerHeight = 0.0
        guard isShow else {
            return CGFloat(headerHeight)
        }
        
        if sectionTitle.characters.count > 0 {
            headerHeight = 44.0
        } else {
            headerHeight = Double(APPMACROS_BASE_MARGIN * 2)
        }
        
        return CGFloat(headerHeight)
    }
}

protocol RecommentDateProtocol {
    
    var dateType: RecommemtDateType { get }
    var rowCount: Int { get set }
    var size: CGSize { get }
    
    var sectionHeader: SectionHeader { get }
    var sectionFooterTitle: String { get }
    
//    mutating func setRowCount(rowCount: Int)
}

extension RecommentDateProtocol {
    
    var rowCount: Int {
        
        get {
            return 1
        }
        
        set {
            rowCount = newValue
        }
    }
    
    var size: CGSize {
        
        return CGSize(width: 0.0, height: 0.0)
    }
}
