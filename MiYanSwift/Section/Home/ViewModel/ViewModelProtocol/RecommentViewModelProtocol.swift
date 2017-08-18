//
//  RecommentBaseViewModelProtocol.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/11.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation

protocol RecommentViewModelProtocol {
    
    var items: [RecommentDateProtocol] { get set }
    var recommentModel: RecommentBaseModel { get set }
//    func loadRecommentDate(completeHandler: @escaping (_ message: String, _ isSuccess: Bool) -> Void) -> Void
//    func loadRecommentGoods()
}

