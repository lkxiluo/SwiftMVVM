//
//  RecommentActivityModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation

final class RecommentActivityModel: RecommentDateProtocol {
    
    var dateType: RecommemtDateType {
    
        return .activityOne
    }
    var sectionHeader: SectionHeader = SectionHeader(imageName: "", sectionTitle: "", isShow: true)
    var sectionFooterTitle: String {
    
        return ""
    }
    var activitys: [ActivityModel] = [ActivityModel]()
}
