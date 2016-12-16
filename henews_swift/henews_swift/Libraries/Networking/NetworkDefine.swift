//
//  NetworkDefine.swift
//  henews_swift
//
//  Created by 汪洋 on 2016/12/6.
//  Copyright © 2016年 汪洋. All rights reserved.
//

import Foundation

/**
 *  请求类型
 */
enum NetWorkType: Int {
    case GET = 1
    case POST
}
/**
 *  请求数据类型
 */
enum NetWorkDataType: Int {
    case JSON = 1
    case XML
}
/**
 *  运营商类型
 */
enum MNOType: Int{
    case Unknown = 0
    case Mobile              /**移动 */
    case Unicom              /**联通 */
    case Telecom             /**电信 */
    case Tietong             /**铁通 */
}

