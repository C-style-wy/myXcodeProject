//
//  NetworkItem.m
//  henews250
//
//  Created by 汪洋 on 16/8/29.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NetworkItem.h"
#import "AFNetworking.h"
#import "NetworkCache.h"
#import "UserInfoHandle.h"

@implementation NetworkItem

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
 *  @param useCache     是否适用缓存
 *  @param update       是否请求网络
 *
 *  @return MHAsiNetworkItem对象
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
                       update:(BOOL)update
{
    if (self = [super init]) {
        self.networkType    = networkType;
        self.dataType       = dataType;
        self.url            = url;
        self.params         = params;
        self.delegate       = delegate;
        self.showHUD        = showHUD;
        self.tagrget        = target;
        self.select         = action;
        self.tag            = tag;
        self.useCache       = useCache;
        self.update         = update;
    }
    NSString *requestUrl = [self addKeyWithUrl:url];
    NTLog(@"url=====%@", [self getParamString:url]);
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager *manager = [self getHttpSessionManager:dataType];
    if (dataType == NetWorkJSON) {
        if (useCache) {
            NSDictionary *cacheData = [NetworkCache getHttpCacheForKey:url];
            if (cacheBlock && cacheData) {
                cacheBlock(cacheData);
            }
            
            if ([weakSelf.delegate respondsToSelector:@selector(requestDidCacheReturn: returnJson: msg:)] && cacheData) {
                [weakSelf.delegate requestDidCacheReturn:tag returnJson:cacheData msg:msg];
            }

            if (!update) {
                [weakSelf removewItem];
            }
        }
        if (update) {
            if (networkType == NetWorkGET) {
                NSLog(@"json===get======");
                [manager GET:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (successBlock) {
                        successBlock(responseObject);
                    }
                    if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading: returnJson: msg:)]) {
                        [weakSelf.delegate requestDidFinishLoading:tag returnJson:responseObject msg:msg];
                    }
                    [weakSelf performSelector:@selector(finishedRequest:didFaild:) withObject:responseObject withObject:nil];
                    //对数据进行异步缓存
                    responseObject ? [NetworkCache saveHttpCache:responseObject forKey:url] : nil;
                    [weakSelf removewItem];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (failureBlock) {
                        failureBlock(error);
                    }
                    if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError: tag: msg:)]) {
                        [weakSelf.delegate requestdidFailWithError:error tag:tag msg:msg];
                    }
                    [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:nil withObject:error];
                    [weakSelf removewItem];
                }];
            }else{
                [manager POST:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (successBlock) {
                        successBlock(responseObject);
                    }
                    if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading: returnJson: msg:)]) {
                        [weakSelf.delegate requestDidFinishLoading:tag returnJson:responseObject msg:msg];
                    }
                    [weakSelf performSelector:@selector(finishedRequest:didFaild:) withObject:responseObject withObject:nil];
                    //对数据进行异步缓存
                    responseObject ? [NetworkCache saveHttpCache:responseObject forKey:url] : nil;
                    
                    [weakSelf removewItem];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (failureBlock) {
                        failureBlock(error);
                    }
                    if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError: tag: msg:)]) {
                        [weakSelf.delegate requestdidFailWithError:error tag:tag msg:msg];
                    }
                    [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:nil withObject:error];
                    [weakSelf removewItem];
                }];
            }
        }
    }else if (dataType == NetWorkXML){
        if (params == nil) {
            params = @{@"format": @"xml"};
        }else{
            [params setValue:@"xml" forKey:@"format"];
        }
        if (useCache) {
            NSDictionary *cacheData = [NetworkCache getHttpCacheForKey:url];
            if (cacheBlock && cacheData) {
                cacheBlock(cacheData);
            }
            
            if ([weakSelf.delegate respondsToSelector:@selector(requestDidCacheReturn: returnJson: msg:)] && cacheData) {
                [weakSelf.delegate requestDidCacheReturn:tag returnJson:cacheData msg:msg];
            }
            
            if (!update) {
                [weakSelf removewItem];
            }
        }
        if (update) {
            if (networkType == NetWorkGET) {
                NSLog(@"xml===get======");
                [manager GET:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSDictionary *returnData = [NSDictionary dictionaryWithXMLParser:responseObject];
                    if (successBlock) {
                        successBlock(returnData);
                    }
                    if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading: returnJson: msg:)]) {
                        [weakSelf.delegate requestDidFinishLoading:tag returnJson:returnData msg:msg ];
                    }
                    //对数据进行异步缓存
                    returnData ? [NetworkCache saveHttpCache:returnData forKey:url] : nil;
                    
                    [weakSelf removewItem];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (failureBlock) {
                        failureBlock(error);
                    }
                    if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError: tag: msg:)]) {
                        [weakSelf.delegate requestdidFailWithError:error tag:tag msg:msg];
                    }
                    [weakSelf removewItem];
                }];
            }else{
                [manager POST:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSDictionary *returnData = [NSDictionary dictionaryWithXMLParser:responseObject];
                    if (successBlock) {
                        successBlock(returnData);
                    }
                    if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading: returnJson: msg:)]) {
                        [weakSelf.delegate requestDidFinishLoading:tag returnJson:returnData msg:msg ];
                    }
                    //对数据进行异步缓存
                    returnData ? [NetworkCache saveHttpCache:returnData forKey:url] : nil;
                    [weakSelf removewItem];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (failureBlock) {
                        failureBlock(error);
                    }
                    if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError: tag: msg:)]) {
                        [weakSelf.delegate requestdidFailWithError:error tag:tag msg:msg];
                    }
                    [weakSelf removewItem];
                }];
            }
        }
    }
    return self;
}

//创建AFHTTPSessionManager
- (AFHTTPSessionManager *)getHttpSessionManager:(NetWorkDataType)dataType {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    if (dataType == NetWorkJSON) {
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    }else{
        manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    }
    [manager.requestSerializer setValue:[userDefaults stringForKey:WD_CLIENTNAME] forHTTPHeaderField:WD_CLIENTNAME];
    [manager.requestSerializer setValue:[userDefaults stringForKey:WD_UUID] forHTTPHeaderField:WD_UUID];
    [manager.requestSerializer setValue:[userDefaults stringForKey:WD_CLIENT_TYPE] forHTTPHeaderField:WD_CLIENT_TYPE];
    [manager.requestSerializer setValue:[userDefaults stringForKey:WD_UA] forHTTPHeaderField:WD_UA];
    [manager.requestSerializer setValue:[userDefaults stringForKey:WD_SYSTEM] forHTTPHeaderField:WD_SYSTEM];
    [manager.requestSerializer setValue:[userDefaults stringForKey:WD_VERSION] forHTTPHeaderField:WD_VERSION];
    [manager.requestSerializer setValue:[userDefaults stringForKey:WD_CHANNEL] forHTTPHeaderField:WD_CHANNEL];
    [manager.requestSerializer setValue:[userDefaults stringForKey:WD_RESOLUTION] forHTTPHeaderField:WD_RESOLUTION];
    [manager.requestSerializer setValue:[userDefaults stringForKey:WD_CP_ID] forHTTPHeaderField:WD_CP_ID];
    if ([UserInfoHandle isLogin]) {
        LoaclUserInfoData *data = [UserInfoHandle getUserInfoFromLocal];
        UserInfoModel *user = data.userInfo;
        [manager.requestSerializer setValue:user.name forHTTPHeaderField:LoginName];
        [manager.requestSerializer setValue:user.realName forHTTPHeaderField:RealName];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",user.userId] forHTTPHeaderField:UserId];
        if (user.accountType && ![user.accountType isEqualToString:@""]) {
            [manager.requestSerializer setValue:user.accountType forHTTPHeaderField:AccountType];
        }
    }
    
    [manager.requestSerializer setValue:[self getKeyWithUrl:_url] forHTTPHeaderField:WD_ENCRYPT];
    return manager;
}

- (NSString *)getParamString:(NSString *)url {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *paramStr = @"?";
    if ([url rangeOfString:@"?"].location != NSNotFound){
        paramStr = @"&";
    }

    paramStr = [paramStr stringByAppendingString:WD_CLIENTNAME];
    paramStr = [paramStr stringByAppendingString:@"="];
    if ([userDefaults stringForKey:WD_CLIENTNAME] && (![[userDefaults stringForKey:WD_CLIENTNAME] isEqualToString:@""])) {
        paramStr = [paramStr stringByAppendingString:[userDefaults stringForKey:WD_CLIENTNAME]];
    }
    
    paramStr = [self addOneParam:paramStr key:WD_UUID];
    paramStr = [self addOneParam:paramStr key:WD_CLIENT_TYPE];
    paramStr = [self addOneParam:paramStr key:WD_UA];
    paramStr = [self addOneParam:paramStr key:WD_SYSTEM];
    paramStr = [self addOneParam:paramStr key:WD_VERSION];
    paramStr = [self addOneParam:paramStr key:WD_CHANNEL];
    
    paramStr = [self addOneParam:paramStr key:WD_RESOLUTION];
    paramStr = [self addOneParam:paramStr key:WD_CP_ID];
    
    if ([UserInfoHandle isLogin]) {
        paramStr = [paramStr stringByAppendingString:@"&"];
        paramStr = [paramStr stringByAppendingString:LoginName];
        paramStr = [paramStr stringByAppendingString:@"="];
        LoaclUserInfoData *data = [UserInfoHandle getUserInfoFromLocal];
        UserInfoModel *user = data.userInfo;
        paramStr = [paramStr stringByAppendingString:user.name];
        paramStr = [paramStr stringByAppendingString:@"&"];
        paramStr = [paramStr stringByAppendingString:RealName];
        paramStr = [paramStr stringByAppendingString:@"="];
        paramStr = [paramStr stringByAppendingString:user.realName];
        
        paramStr = [paramStr stringByAppendingString:@"&"];
        paramStr = [paramStr stringByAppendingString:UserId];
        paramStr = [paramStr stringByAppendingString:@"="];
        paramStr = [paramStr stringByAppendingString:[NSString stringWithFormat:@"%ld",user.userId]];
        
        paramStr = [paramStr stringByAppendingString:@"&"];
        paramStr = [paramStr stringByAppendingString:AccountType];
        paramStr = [paramStr stringByAppendingString:@"="];
        if (user.accountType && ![user.accountType isEqualToString:@""]) {
            paramStr = [paramStr stringByAppendingString:user.accountType];
        }
    }
    
    url = [url stringByAppendingString:paramStr];
    
    return [self addKeyWithUrl:url];
}

- (NSString *)addOneParam:(NSString *)param key:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    param = [param stringByAppendingString:@"&"];
    param = [param stringByAppendingString:key];
    param = [param stringByAppendingString:@"="];
    if ([userDefaults stringForKey:key] && (![[userDefaults stringForKey:key] isEqualToString:@""])) {
        param = [param stringByAppendingString:[userDefaults stringForKey:key]];
    }
    
    return param;
}

- (NSString *)addKeyWithUrl:(NSString *)url{
    if([url rangeOfString:@"?"].location != NSNotFound){
        url = [url stringByAppendingString:@"&"];
    }else{
        url = [url stringByAppendingString:@"?"];
    }
    
    if ([UserInfoHandle isLogin]) {
        url = [url stringByAppendingString:LoginName];
        url = [url stringByAppendingString:@"="];
        LoaclUserInfoData *data = [UserInfoHandle getUserInfoFromLocal];
        UserInfoModel *user = data.userInfo;
        url = [url stringByAppendingString:user.name];
        
        url = [url stringByAppendingString:@"&"];
        url = [url stringByAppendingString:RealName];
        url = [url stringByAppendingString:@"="];
        url = [url stringByAppendingString:user.realName];
        
        url = [url stringByAppendingString:@"&"];
        url = [url stringByAppendingString:UserId];
        url = [url stringByAppendingString:@"="];
        url = [url stringByAppendingString:[NSString stringWithFormat:@"%ld",user.userId]];
        
        url = [url stringByAppendingString:@"&"];
        url = [url stringByAppendingString:AccountType];
        url = [url stringByAppendingString:@"="];
        if (user.accountType && ![user.accountType isEqualToString:@""]) {
            url = [url stringByAppendingString:user.accountType];
        }
    }
    url = [url stringByAppendingString:@"&"];
    url = [url stringByAppendingString:WD_ENCRYPT];
    url = [url stringByAppendingString:@"="];
    url = [url stringByAppendingString:[self getKeyWithUrl:url]];
    return [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

//返回鉴权
- (NSString *)getKeyWithUrl:(NSString *)url{
    NSRange range = [url rangeOfString:API_HOST];
    NSString *str = [url substringFromIndex:range.length];
    if([str rangeOfString:@"?"].location != NSNotFound){
        NSArray *array = [str componentsSeparatedByString:@"?"];
        str = array[0];
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    str = [str stringByAppendingString:@"?"];
    str = [str stringByAppendingString:WD_CP_ID];
    str = [str stringByAppendingString:@"="];
    if ([userDefaults stringForKey:WD_CP_ID] && (![[userDefaults stringForKey:WD_CP_ID] isEqualToString:@""])) {
        str = [str stringByAppendingString:[userDefaults stringForKey:WD_CP_ID]];
    }
    
    str = [self addOneParam:str key:WD_VERSION];
    str = [self addOneParam:str key:WD_CHANNEL];
    str = [self addOneParam:str key:WD_UA];
    str = [self addOneParam:str key:WD_UUID];
    str = [str stringByAppendingString:@"&"];
    str = [str stringByAppendingString:LoginName];
    str = [str stringByAppendingString:@"="];
    if ([UserInfoHandle isLogin]) {
        LoaclUserInfoData *data = [UserInfoHandle getUserInfoFromLocal];
        UserInfoModel *user = data.userInfo;
        str = [str stringByAppendingString:user.name];
    }
    str = [str stringByAppendingString:@"&salt="];
    str = [str stringByAppendingString:@"3d6809f2373db28c"];
    return [MD5 encoding:str];
}


/**
 *   移除网络请求项
 */
- (void)removewItem
{
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([weakSelf.handlerDelegate respondsToSelector:@selector(netWorkWillDealloc:)]) {
            [weakSelf.handlerDelegate netWorkWillDealloc:weakSelf];
        }
    });
}

- (void)finishedRequest:(id)data didFaild:(NSError*)error
{
    if ([self.tagrget respondsToSelector:self.select]) {
        [self.tagrget performSelector:@selector(finishedRequest:didFaild:) withObject:data withObject:error];
    }
}

- (void)dealloc
{
    
    
}

@end
