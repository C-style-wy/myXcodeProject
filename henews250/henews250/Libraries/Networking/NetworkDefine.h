//
//  NetworkDefine.h
//  henews250
//
//  Created by 汪洋 on 16/8/19.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#ifndef NetworkDefine_h
#define NetworkDefine_h

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

#define WD_CLIENTNAME            (@"clientName")
#define WD_UUID                  (@"WD_UUID")
#define WD_CLIENT_TYPE           (@"WD_CLIENT_TYPE")
#define WD_UA                    (@"WD_UA")
#define WD_SYSTEM                (@"WD_SYSTEM")
#define WD_CHANNEL               (@"WD_CHANNEL")
#define WD_RESOLUTION            (@"WD_RESOLUTION")
#define WD_CP_ID                 (@"WD_CP_ID")
#define WD_VERSION               (@"WD_VERSION")
#define WD_ENCRYPT               (@"encrypt")

#endif /* NetworkDefine_h */
