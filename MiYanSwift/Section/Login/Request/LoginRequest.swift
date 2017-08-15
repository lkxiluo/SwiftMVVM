//
//  LoginRequest.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/8/4.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import Alamofire

class LoginRequest: BaseRequest {

    override func starRequest(parameters: Parameters?,
                              completeSuccess: @escaping (Any) -> Void,
                              completeFailure: @escaping (Error) -> Void) {
        
        var params: Parameters = Parameters()
        if parameters != nil {
            
            params = parameters!
        }
        params["service"] = "Agency.Login"
        let loginURL = NSString.my_baseUrl(isNewInterface: false)
        BaseRequest.request(url: loginURL,
                            method: .post,
                            parameters: params,
                            completeSuccess: completeSuccess,
                            completeFailure: completeFailure)
    }
}
