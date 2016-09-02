//
//  NetworkManager.h
//  henews250
//
//  Created by 汪洋 on 16/9/1.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkHandler.h"


@interface NetworkManager : NSObject

//返回单例
+(instancetype)shareInstance;

#pragma mark - 发送 GET json数据请求的方法

/**
 *   GET请求json数据通过Block 回调结果
 *
 *   @param url          url
 *   @param paramsDict   paramsDict
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD      是否加载进度指示器
 */
+ (void)getRequstJsonWithURL:(NSString*)url
                  params:(NSDictionary*)paramsDict
            successBlock:(NWSuccessBlock)successBlock
            failureBlock:(NWFailureBlock)failureBlock
                 showHUD:(BOOL)showHUD;


/**
 *   POST请求json数据通过 Block回调结果
 *
 *   @param url           url
 *   @param paramsDict    请求的参数字典
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD       是否加载进度指示器
 */
+ (void)postReqeustJsonWithURL:(NSString*)url
                    params:(NSDictionary*)params
              successBlock:(NWSuccessBlock)successBlock
              failureBlock:(NWFailureBlock)failureBlock
                   showHUD:(BOOL)showHUD;

/**
 *   post请求json 通过代理回调
 *
 *   @param url         url
 *   @param paramsDict  请求的参数
 *   @param delegate    delegate
 *   @param showHUD    是否转圈圈
 */
+ (void)postReqeustJsonWithURL:(NSString*)url
                    params:(NSDictionary*)params
                  delegate:(id<NetworkDelegate>)delegate
                       tag:(NSString*)tag
                       msg:(NSInteger)msg
                  useCache:(BOOL)use
                    update:(BOOL)update
                   showHUD:(BOOL)showHUD;

/**
 *   POST请求xml数据通过 Block回调结果
 *
 *   @param url           url
 *   @param paramsDict    请求的参数字典
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD       是否加载进度指示器
 */
+ (void)postReqeustXmlWithURL:(NSString*)url
                        params:(NSDictionary*)params
                  successBlock:(NWSuccessBlock)successBlock
                  failureBlock:(NWFailureBlock)failureBlock
                       showHUD:(BOOL)showHUD;
@end
