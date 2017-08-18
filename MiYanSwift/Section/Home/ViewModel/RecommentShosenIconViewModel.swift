//
//  RecommentShosenIconViewModel.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation
import UIKit

final class RecommentShosenIconViewModel: RecommentDateProtocol {
    
    var dateType: RecommemtDateType {
    
        return .shoseIcon
    }
    var sectionHeader: SectionHeader = SectionHeader(imageName: "", sectionTitle: "", isShow: false)
    var sectionFooterTitle: String {
    
        return ""
    }
    var size: CGSize {
    
        return CGSize(width: SYSTEMMACROS_SCREEN_WIDTH, height: FITSCREEN(f: 90.0))
    }
    var shoseIcons: [ShosenIconModel] = [ShosenIconModel]()
}
