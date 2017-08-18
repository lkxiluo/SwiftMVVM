//
//  RecommentTopicViewModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation

final class RecommentTopicViewModel: RecommentDateProtocol {

    var dateType: RecommemtDateType {
    
        return .topic
    }
    var sectionHeader: SectionHeader = SectionHeader(imageName: "recomment_activity_topic", sectionTitle: "专题推荐", isShow: true)
    var sectionFooterTitle: String {
    
        return "查看更多专题"
    }
    var topics: [TopicModel] = [TopicModel]()
}
