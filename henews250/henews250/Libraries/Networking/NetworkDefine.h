//
//  NetworkDefine.h
//  henews250
//
//  Created by 汪洋 on 16/8/19.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "MYPhoneParam.h"
#import "MYLoading.h"

#ifndef NetworkDefine_h
#define NetworkDefine_h

#ifdef DEBUG
#define NTString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent

#define NTLog(...) printf("%s 第%d行: %s\n", [NTString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else
#define NTLog(...)
#endif

/**
 *  请求类型
 */
typedef enum {
    NetWorkGET = 1,    /**< GET请求 */
    NetWorkPOST        /**< POST请求 */
}NetWorkType;

/**
 *  请求数据类型
 */
typedef enum {
    NetWorkJSON = 1,    /**< 请求json */
    NetWorkXML        /**< 请求xml */
}NetWorkDataType;

/**
 *  运营商类型
 */
typedef enum {
    MNOTypeUnknown = 0,
    MNOTypeMobile,              /**移动 */
    MNOTypeUnicom,              /**联通 */
    MNOTypeTelecom,             /**电信 */
    MNOTypeTietong,             /**铁通 */
}MNOType;

/**
 *  网络请求超时的时间
 */
#define API_TIME_OUT 20

#if NS_BLOCKS_AVAILABLE

/**
 *  请求开始的回调（下载时用到）
 */
typedef void (^NWStartBlock)(void);

/**
 *  请求成功回调
 *
 *  @param returnData 回调block
 */
typedef void (^NWSuccessBlock)(NSDictionary *returnJson);
/**
 *  缓存回调
 *
 *  @param returnData 回调block
 */
typedef void (^NWCacheBlock)(NSDictionary *returnJson);

//typedef void (^NWXMLSuccessBlock)(GDataXMLElement *returnData);

/**
 *  请求失败回调
 *
 *  @param error 回调block
 */
typedef void (^NWFailureBlock)(NSError *error);

#endif

#endif /* NetworkDefine_h */
