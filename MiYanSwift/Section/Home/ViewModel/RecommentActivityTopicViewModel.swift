//
//  RecommentActivityTopicViewModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation

final class RecommentActivityTopicViewModel: RecommentDateProtocol {

    var dateType: RecommemtDateType {
    
        return .activityTopic
    }
    var sectionHeader: SectionHeader = SectionHeader(imageName: "recomment_timer_activity", sectionTitle: "限时活动", isShow: true)
    var sectionFooterTitle: String {
    
        return ""
    }
    var activityGoods: [ActivityTopicModel] = [ActivityTopicModel]()
}
