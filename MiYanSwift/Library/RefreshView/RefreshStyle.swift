//
//  RefreshStyle.swift
//  WuZhouHuiSwift
//
//  Created by QianHan on 2017/5/12.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation

enum RefreshStyle {
    case header   // 下拉刷新
    case footer   // 上拉加载更多
}

enum RefreshStatus {
    case initial    // 初始状态
    case loading    // 加载中
    case ending     // 加载结束
    case nomore     // 没有更多了
}

struct Default {
    
}
