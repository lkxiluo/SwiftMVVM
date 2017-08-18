//
//  RecommentHotCategoryViewModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation
import UIKit

final class RecommentHotCategoryViewModel: RecommentDateProtocol {

    var dateType: RecommemtDateType {
    
        return .hotCategory
    }
    var sectionHeader: SectionHeader = SectionHeader(imageName: "recomment_hot_category", sectionTitle: "热门分类", isShow: true)
    var sectionFooterTitle: String {
    
        return ""
    }
    var size: CGSize {
    
        return CGSize(width: SYSTEMMACROS_SCREEN_WIDTH, height: FITSCREEN(f: 93.0))
    }
    var hotCategory: [HotCategoryModel] = [HotCategoryModel]()
}
