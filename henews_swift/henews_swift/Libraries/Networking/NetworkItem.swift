//
//  NetworkItem.swift
//  henews_swift
//
//  Created by 汪洋 on 2016/12/6.
//  Copyright © 2016年 汪洋. All rights reserved.
//

import UIKit
import AFNetworking

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
    
    init(networkType: NetWorkType,
         dataType: NetWorkDataType,
         url: String
         ) {
        self.networkType = networkType
        self.dataType = dataType
//        let manager = 
        
        
        
        super.init()
    }
    
    func addKeyWithUrl(url: String) -> String {
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
