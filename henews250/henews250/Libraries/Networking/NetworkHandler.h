//
//  NetworkHandler.h
//  henews250
//
//  Created by 汪洋 on 16/8/29.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkDefine.h"
#import "NetworkItem.h"
#import "AFNetworking.h"

@interface NetworkHandler : NSObject

/**
 *  单例
 *
 *  @return BMNetworkHandler的单例对象
 */
+ (NetworkHandler *)sharedInstance;

/**
 *  items
 */
@property(nonatomic, strong)NSMutableArray *items;

/**
 *  单个网络请求项
 */
@property(nonatomic, strong)NetworkItem *netWorkItem;

/**
 *  networkError
 */
@property(nonatomic,assign)BOOL networkError;

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
                     update:(BOOL)update;
/**
 *   监听网络状态的变化
 */
+ (void)startMonitoring;
/**
 *   取消所有正在执行的网络请求项
 */
+ (void)cancelAllNetItems;

@end
