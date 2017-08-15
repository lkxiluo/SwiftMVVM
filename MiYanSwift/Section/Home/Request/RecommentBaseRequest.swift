//
//  RecommentBaseRequest.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/11.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import Alamofire

/// 请求推荐各模块数据
class RecommentBaseRequest: BaseRequest {

    override func starRequest(parameters: Parameters?,
                              completeSuccess: @escaping (Any) -> Void,
                              completeFailure: @escaping (Error) -> Void) {
        
        var params: Parameters = Parameters()
        if parameters != nil {
            
            params = parameters!
        }
        params["service"] = "Index.getAppIndex"
        let loginURL = NSString.my_baseUrl(isNewInterface: true)
        BaseRequest.request(url: loginURL,
                            method: .post,
                            parameters: params,
                            completeSuccess: completeSuccess,
                            completeFailure: completeFailure)
    }
}
