//
//  NetworkItem.swift
//  henews_swift
//
//  Created by 汪洋 on 2016/12/6.
//  Copyright © 2016年 汪洋. All rights reserved.
//

import UIKit
import Alamofire

class NetworkItem: NSObject {
    /**
     *  网络请求方式
     */
    var networkType: NetWorkType?
    /**
     *  网络请求数据类型
     */
    var dataType: NetWorkDataType?
    /**
     *  网络请求URL
     */
    var url: String?
    /**
     *  网络请求参数
     */
    
    init(networkType p1: NetWorkType,
            dataType p2: NetWorkDataType,
                    url: String
         ) {
        self.networkType = p1
        self.dataType = p2
//        let manager = 
        
        let parameters: Parameters = ["foo": "bar"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                debugPrint(response)
        }
        
        super.init()
    }
    
    private func addKeyWithUrl(url: String) -> String {
        var urlString: String? = url
        if urlString != nil {
            if urlString!.range(of: "?") != nil {
                urlString! += "&"
            } else {
                urlString! += "?"
            }
        }
        
        return url
    }
}
