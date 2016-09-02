//
//  NetworkHandler.m
//  henews250
//
//  Created by 汪洋 on 16/8/29.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NetworkHandler.h"

@interface NetworkHandler ()

<NetworkDelegate>

@end

@implementation NetworkHandler

+ (NetworkHandler *)sharedInstance {
    static NetworkHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[NetworkHandler alloc] init];
    });
    return handler;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.networkError = NO;
    }
    return self;
}

#pragma mark - 创建一个网络请求项
/**
 *  创建一个网络请求项，开始请求网络
 *
 *  @param networkType  网络请求方式
 *  @param dataType     网络请求数据类型
 *  @param url          网络请求URL
 *  @param params       网络请求参数
 *  @param delegate     网络请求的委托，如果没有取消网络请求的需求，可传nil
 *  @param hashValue    网络请求的委托delegate的唯一标示
 *  @param showHUD      是否显示HUD
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 *  @param tag          请求标示
 *  @param msg          请求数字标示
 *  @param useCache     是否使用缓存
 *  @param update       是否请求网络
 *
 *  @return NetworkItem对象
 */
- (NetworkItem*)conURL:(NSString *)url
           networkType:(NetWorkType)networkType
              dataType:(NetWorkDataType)dataType
                params:(NSMutableDictionary *)params
              delegate:(id)delegate
               showHUD:(BOOL)showHUD
                target:(id)target
                action:(SEL)action
          successBlock:(NWSuccessBlock)successBlock
          failureBlock:(NWFailureBlock)failureBlock
                   tag:(NSString*)tag
                   msg:(NSInteger)msg
              useCache:(BOOL)use
                update:(BOOL)update
{
    if (self.networkError == YES) {
        if (failureBlock) {
            failureBlock(nil);
        }
        return nil;
    }
    //如果有一些公共处理，可以写在这里
    NSUInteger hashValue = [delegate hash];
    self.netWorkItem = [[NetworkItem alloc]initWithtype:networkType dataType:dataType url:url params:params delegate:delegate target:target action:action hashValue:hashValue showHUD:showHUD successBlock:successBlock failureBlock:failureBlock tag:tag msg:msg useCache:use update:update];
//    self.netWorkItem.delegate = self;
    [self.items addObject:self.netWorkItem];
    return self.netWorkItem;
}

#pragma makr - 开始监听网络连接

+ (void)startMonitoring
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                [NetworkHandler sharedInstance].networkError = NO;
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                [NetworkHandler sharedInstance].networkError = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                [NetworkHandler sharedInstance].networkError = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                [NetworkHandler sharedInstance].networkError = NO;
                break;
        }
    }];
    [mgr startMonitoring];
}
/**
 *   懒加载网络请求项的 items 数组
 *
 *   @return 返回一个数组
 */
- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}
/**
 *   取消所有正在执行的网络请求项
 */
+ (void)cancelAllNetItems
{
    NetworkHandler *handler = [NetworkHandler sharedInstance];
    [handler.items removeAllObjects];
    handler.netWorkItem = nil;
}

- (void)netWorkWillDealloc:(NetworkItem *)itme
{
    [self.items removeObject:itme];
    self.netWorkItem = nil;
}

@end
