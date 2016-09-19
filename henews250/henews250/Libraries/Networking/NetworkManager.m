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


#pragma mark - json数据请求的方法

/**
 *   GET请求json数据通过delegate 回调结果
 *
 *   @param url          url
 *   @param paramsDict   paramsDict
 *   @param delegate     代理
 *   @param tag          NSString标示
 *   @param msg          NSInteger标示
 *   @param use          是否使用缓存
 *   @param update       是否发出新的网络请求
 *   @param showHUD      是否加载进度指示器
 */
+ (void)getRequestJsonWithURL:(NSString*)url
                       params:(NSDictionary*)paramsDict
                     delegate:(id<NetworkDelegate>)delegate
                          tag:(NSString*)tag
                          msg:(NSInteger)msg
                     useCache:(BOOL)use
                       update:(BOOL)update
                      showHUD:(BOOL)showHUD
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:paramsDict];
    [[NetworkHandler sharedInstance]conURL:url networkType:NetWorkGET dataType:NetWorkJSON params:mutableDict delegate:delegate showHUD:showHUD target:nil action:nil cacheBlock:nil successBlock:nil failureBlock:nil tag:tag msg:msg useCache:use update:update];
}
/**
 *   GET请求json数据通过Block 回调结果
 *
 *   @param url           url
 *   @param paramsDict    paramsDict
 *   @param cacheBlock    缓存的回调
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD       是否加载进度指示器
 */
+ (void)getRequestJsonWithURL:(NSString*)url
                      params:(NSDictionary*)paramsDict
                  cacheBlock:(NWCacheBlock)cacheBlock
                successBlock:(NWSuccessBlock)successBlock
                failureBlock:(NWFailureBlock)failureBlock
                     showHUD:(BOOL)showHUD
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:paramsDict];
    [[NetworkHandler sharedInstance]conURL:url networkType:NetWorkGET dataType:NetWorkJSON params:mutableDict delegate:nil showHUD:showHUD target:nil action:nil cacheBlock:cacheBlock successBlock:successBlock failureBlock:failureBlock tag:nil msg:0 useCache:YES update:YES
     ];
}

/**
 *   post请求json数据通过delegate 回调结果
 *
 *   @param url          url
 *   @param paramsDict   paramsDict
 *   @param delegate     代理
 *   @param tag          NSString标示
 *   @param msg          NSInteger标示
 *   @param use          是否使用缓存
 *   @param update       是否发出新的网络请求
 *   @param showHUD      是否加载进度指示器
 */
+ (void)postRequestJsonWithURL:(NSString*)url
                        params:(NSDictionary*)paramsDict
                      delegate:(id<NetworkDelegate>)delegate
                           tag:(NSString*)tag
                           msg:(NSInteger)msg
                      useCache:(BOOL)use
                        update:(BOOL)update
                       showHUD:(BOOL)showHUD
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:paramsDict];
    [[NetworkHandler sharedInstance]conURL:url networkType:NetWorkPOST dataType:NetWorkJSON params:mutableDict delegate:delegate showHUD:showHUD target:nil action:nil cacheBlock:nil successBlock:nil failureBlock:nil tag:tag msg:msg useCache:use update:update];
}
/**
 *   post请求json数据通过Block 回调结果
 *
 *   @param url           url
 *   @param paramsDict    paramsDict
 *   @param cacheBlock    缓存的回调
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD       是否加载进度指示器
 */
+ (void)postRequestJsonWithURL:(NSString*)url
                       params:(NSDictionary*)paramsDict
                   cacheBlock:(NWCacheBlock)cacheBlock
                 successBlock:(NWSuccessBlock)successBlock
                 failureBlock:(NWFailureBlock)failureBlock
                      showHUD:(BOOL)showHUD
{

    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:paramsDict];
    
    [[NetworkHandler sharedInstance]conURL:url networkType:NetWorkPOST dataType:NetWorkJSON params:mutableDict delegate:nil showHUD:showHUD target:nil action:nil cacheBlock:cacheBlock successBlock:successBlock failureBlock:failureBlock tag:nil msg:0 useCache:YES update:YES];
}

#pragma mark - xml数据请求的方法

/**
 *   GET请求xml数据通过delegate 回调结果
 *
 *   @param url          url
 *   @param paramsDict   paramsDict
 *   @param delegate     代理
 *   @param tag          NSString标示
 *   @param msg          NSInteger标示
 *   @param use          是否使用缓存
 *   @param update       是否发出新的网络请求
 *   @param showHUD      是否加载进度指示器
 */
+ (void)getRequestXmlWithURL:(NSString*)url
                      params:(NSDictionary*)paramsDict
                    delegate:(id<NetworkDelegate>)delegate
                         tag:(NSString*)tag
                         msg:(NSInteger)msg
                    useCache:(BOOL)use
                      update:(BOOL)update
                     showHUD:(BOOL)showHUD
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:paramsDict];
    [[NetworkHandler sharedInstance]conURL:url networkType:NetWorkGET dataType:NetWorkXML params:mutableDict delegate:delegate showHUD:showHUD target:nil action:nil cacheBlock:nil successBlock:nil failureBlock:nil tag:tag msg:msg useCache:use update:update];
}
/**
 *   GET请求xml数据通过Block 回调结果
 *
 *   @param url           url
 *   @param paramsDict    paramsDict
 *   @param cacheBlock    缓存的回调
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD       是否加载进度指示器
 */
+ (void)getRequestXmlWithURL:(NSString*)url
                     params:(NSDictionary*)paramsDict
                 cacheBlock:(NWCacheBlock)cacheBlock
               successBlock:(NWSuccessBlock)successBlock
               failureBlock:(NWFailureBlock)failureBlock
                    showHUD:(BOOL)showHUD
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:paramsDict];
    [[NetworkHandler sharedInstance]conURL:url networkType:NetWorkGET dataType:NetWorkXML params:mutableDict delegate:nil showHUD:showHUD target:nil action:nil cacheBlock:cacheBlock successBlock:successBlock failureBlock:failureBlock tag:nil msg:0 useCache:YES update:YES];
}

/**
 *   post请求xml数据通过delegate 回调结果
 *
 *   @param url          url
 *   @param paramsDict   paramsDict
 *   @param delegate     代理
 *   @param tag          NSString标示
 *   @param msg          NSInteger标示
 *   @param use          是否使用缓存
 *   @param update       是否发出新的网络请求
 *   @param showHUD      是否加载进度指示器
 */
+ (void)postRequestXmlWithURL:(NSString*)url
                       params:(NSDictionary*)paramsDict
                     delegate:(id<NetworkDelegate>)delegate
                          tag:(NSString*)tag
                          msg:(NSInteger)msg
                     useCache:(BOOL)use
                       update:(BOOL)update
                      showHUD:(BOOL)showHUD
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:paramsDict];
    [[NetworkHandler sharedInstance]conURL:url networkType:NetWorkPOST dataType:NetWorkXML params:mutableDict delegate:delegate showHUD:showHUD target:nil action:nil cacheBlock:nil successBlock:nil failureBlock:nil tag:tag msg:msg useCache:use update:update];
}
/**
 *   post请求xml数据通过Block 回调结果
 *
 *   @param url           url
 *   @param paramsDict    paramsDict
 *   @param cacheBlock    缓存的回调
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD       是否加载进度指示器
 */
+ (void)postRequestXmlWithURL:(NSString*)url
                      params:(NSDictionary*)paramsDict
                  cacheBlock:(NWCacheBlock)cacheBlock
                successBlock:(NWSuccessBlock)successBlock
                failureBlock:(NWFailureBlock)failureBlock
                     showHUD:(BOOL)showHUD
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:paramsDict];
    [[NetworkHandler sharedInstance]conURL:url networkType:NetWorkPOST dataType:NetWorkXML params:mutableDict delegate:nil showHUD:showHUD target:nil action:nil cacheBlock:cacheBlock successBlock:successBlock failureBlock:failureBlock tag:nil msg:0 useCache:YES update:YES];
}

@end
