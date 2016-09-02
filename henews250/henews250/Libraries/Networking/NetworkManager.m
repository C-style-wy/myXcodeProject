//
//  NetworkManager.m
//  henews250
//
//  Created by 汪洋 on 16/9/1.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static NetworkManager *_manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}

//返回单例
+ (instancetype)shareInstance{
    return [[super alloc]init];
}

+ (void)getRequstJsonWithURL:(NSString*)url
                      params:(NSDictionary*)paramsDict
                successBlock:(NWSuccessBlock)successBlock
                failureBlock:(NWFailureBlock)failureBlock
                     showHUD:(BOOL)showHUD
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:paramsDict];
    [[NetworkHandler sharedInstance]conURL:url networkType:NetWorkGET dataType:NetWorkJSON params:mutableDict delegate:nil showHUD:showHUD target:nil action:nil successBlock:successBlock failureBlock:failureBlock tag:nil msg:0 useCache:NO update:YES];
}

+ (void)postReqeustJsonWithURL:(NSString*)url
                        params:(NSDictionary*)params
                  successBlock:(NWSuccessBlock)successBlock
                  failureBlock:(NWFailureBlock)failureBlock
                       showHUD:(BOOL)showHUD
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [[NetworkHandler sharedInstance]conURL:url networkType:NetWorkPOST dataType:NetWorkJSON params:mutableDict delegate:nil showHUD:showHUD target:nil action:nil successBlock:successBlock failureBlock:failureBlock tag:nil msg:0 useCache:NO update:YES];
}

+ (void)postReqeustJsonWithURL:(NSString*)url
                        params:(NSDictionary*)params
                      delegate:(id<NetworkDelegate>)delegate
                           tag:(NSString*)tag
                           msg:(NSInteger)msg
                      useCache:(BOOL)use
                        update:(BOOL)update
                       showHUD:(BOOL)showHUD
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [[NetworkHandler sharedInstance]conURL:url networkType:NetWorkPOST dataType:NetWorkJSON params:mutableDict delegate:delegate showHUD:showHUD target:nil action:nil successBlock:nil failureBlock:nil tag:tag msg:msg useCache:use update:update];
}

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
                      showHUD:(BOOL)showHUD
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [[NetworkHandler sharedInstance]conURL:url networkType:NetWorkPOST dataType:NetWorkXML params:mutableDict delegate:nil showHUD:showHUD target:nil action:nil successBlock:successBlock failureBlock:failureBlock tag:nil msg:0 useCache:NO update:YES];
}
@end
