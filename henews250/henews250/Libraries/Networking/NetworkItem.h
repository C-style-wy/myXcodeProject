//
//  NetworkItem.h
//  henews250
//
//  Created by 汪洋 on 16/8/29.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkDefine.h"
#import "NetworkDelegate.h"
#import "NetworkUrl.h"
#import "MD5.h"

#import "XMLDictionary.h"

/**
 *  网络请求子项
 */
@interface NetworkItem : NSObject

/**
 *  网络请求方式
 */
@property (nonatomic, assign) NetWorkType networkType;

/**
 *  网络请求数据类型
 */
@property (nonatomic, assign) NetWorkDataType dataType;
/**
 *  网络请求URL
 */
@property (nonatomic, strong) NSString *url;

/**
 *  网络请求参数
 */
@property (nonatomic, strong) NSDictionary *params;

/**
 *  网络请求的委托
 */
@property (nonatomic, assign) id<NetworkDelegate>delegate;
/**
 *  移除网络请求项的委托
 */
@property (nonatomic, assign) id<NetworkHandlerDelegate>handlerDelegate;
/**
 *   target
 */
@property (nonatomic,assign) id tagrget;
/**
 *   action
 */
@property (nonatomic,assign) SEL select;

/**
 *  是否显示HUD
 */
@property (nonatomic, assign) BOOL showHUD;

/**
 *  请求标示
 */
@property (nonatomic, strong) NSString *tag;

/**
 *  请求数字标示
 */
@property (nonatomic, assign) NSInteger msg;

/**
 *  是否使用缓存
 */
@property (nonatomic, assign) BOOL useCache;

/**
 *  是否请求网络
 */
@property (nonatomic, assign) BOOL update;

#pragma mark - 创建一个网络请求项，开始请求网络
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
- (NetworkItem *)initWithtype:(NetWorkType)networkType
                          dataType:(NetWorkDataType)dataType
                               url:(NSString *)url
                            params:(NSDictionary *)params
                          delegate:(id)delegate
                            target:(id)target
                            action:(SEL)action
                         hashValue:(NSUInteger)hashValue
                           showHUD:(BOOL)showHUD
                        cacheBlock:(NWCacheBlock)cacheBlock
                      successBlock:(NWSuccessBlock)successBlock
                      failureBlock:(NWFailureBlock)failureBlock
                               tag:(NSString*)tag
                               msg:(NSInteger)msg
                          useCache:(BOOL)useCache
                            update:(BOOL)update;

@end
