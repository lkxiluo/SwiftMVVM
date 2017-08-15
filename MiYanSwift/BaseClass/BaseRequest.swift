//
//  BaseRequest.swift
//  WuZhouHuiSwift
//
//  Created by QianHan on 2017/4/12.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation
import Alamofire
import KeychainAccess

fileprivate extension NSNumber {
    
    fileprivate var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
}

public protocol RequestMethod {
    
    func starRequest(parameters: Parameters?,
                     completeSuccess: @escaping (_ respondJson: Any) -> Void,
                     completeFailure: @escaping (_ error: Error) -> Void) -> Void
}

class BaseRequest: NSObject, RequestMethod {
    
    private var manger:SessionManager? = nil
    private static var share:BaseRequest {
        
        struct Static {
            
            static let instance:BaseRequest = BaseRequest()
        }
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest   = 10
        Static.instance.manger             = SessionManager(configuration: config)
        return Static.instance
    }
    
    func starRequest(parameters: Parameters?,
                     completeSuccess: @escaping (Any) -> Void,
                     completeFailure: @escaping (Error) -> Void) {
        
    }

    class func request(url: URLConvertible,
                       method: HTTPMethod,
                       parameters: Parameters?,
                       completeSuccess: @escaping (_ respondJson: Any) -> Void,
                       completeFailure: @escaping (_ error: Error) -> Void
                       ) -> Void {
        
        //TODO: - 读取登录的Token信息, 用户Id
        let headers: HTTPHeaders = [
            "User-Agent": "",
            "X-AUTH-TOKEN": ""
        ]
        
        QHLog(url)
        var parames    = parameters
        let timeNow    = NSDate().timeIntervalSince1970
        let timeString = "\(Int64(timeNow))"
        
        parames?["appkey"]    = "ios"
        parames?["appSecret"] = "4d5dfe95646b627cf59b4feadc4a34ad"
        parames?["timestamp"] = timeString
        parames?["version"]   = APPMACROS_APP_VERSION
        
        let keyChain = Keychain(service: NSString.my_rootUrl())
        let token    = keyChain[APPMACROS_LOGINTOKEN_KEY]
        if token != nil {
            
            QHLog(token)
            parames?["token"] = token
        }
        
        let sign = BaseRequest().secretParames(parames)
        parames?["sign"]      = sign
        
        BaseRequest.share.manger?.request(url,
                                          method: method,
                                          parameters: parames,
                                          headers: headers)
            .responseJSON { response in
                
                QHLog(response)
                switch response.result {
                case .success(let value):
                     completeSuccess(value)
                case .failure(let error):
                    QHLog("Response with error: \(error as NSError): \(response.data ?? Data())")
                    completeFailure(response.error!)
                }
        }
    }
    
    func MD5(string: String) -> String {
        
        let messageData = string.data(using:.utf8)!
        var digestData  = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        var sign = digestData.map { String(format: "%02hhx", $0) }.joined()
        sign = sign.lowercased()
        return sign
    }
    
    func secretParames(_ parames: Parameters?) -> String {
    
        let paramesDict: [String: String] = parames as! [String : String]
        let allkeys = paramesDict.keys
        var sign = ""
        
        let newKeys = allkeys.sorted(by: { (string1: String, string2: String) -> Bool in
            
            return string1.compare(string2, options: .backwards, range: nil, locale: nil) == .orderedAscending
        })
        
        for key in newKeys {
            
            sign = sign.appending(paramesDict[key]!)
        }
        
        sign = self.MD5(string: sign)
        
        return sign
    }
}
