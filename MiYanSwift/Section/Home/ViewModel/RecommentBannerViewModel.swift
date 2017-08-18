//
//  RecommentBannerViewModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation
import UIKit

final class RecommentBannerViewModel: RecommentDateProtocol {
    
    var dateType: RecommemtDateType {
    
        return .banner
    }
    var size: CGSize {
    
        return CGSize(width: SYSTEMMACROS_SCREEN_WIDTH, height: FITSCREEN(f: 190.0))
    }
    var sectionHeader: SectionHeader = SectionHeader(imageName: "", sectionTitle: "", isShow: false)
    var sectionFooterTitle: String {
   
        return ""
    }
    
    var banners: [BannerModel] = []
}
