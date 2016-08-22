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
typedef void (^NWSuccessBlock)(NSDictionary *returnData);

/**
 *  请求失败回调
 *
 *  @param error 回调block
 */
typedef void (^NWFailureBlock)(NSError *error);

#endif

#endif /* NetworkDefine_h */
