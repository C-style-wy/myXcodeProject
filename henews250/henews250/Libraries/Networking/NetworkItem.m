//
//  NetworkItem.m
//  henews250
//
//  Created by 汪洋 on 16/8/29.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NetworkItem.h"
#import "AFNetworking.h"

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
                 successBlock:(NWSuccessBlock)successBlock
                 failureBlock:(NWFailureBlock)failureBlock
                          tag:(NSString*)tag
                          msg:(NSInteger)msg
                     useCache:(BOOL)use
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
        self.useCache       = use;
        self.update         = update;
    }
    NSString *requestUrl = [self addKeyWithUrl:url];
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager *manager = [self getHttpSessionManager:dataType];
    if (dataType == NetWorkJSON) {
        if (use) {
            NSString *filePath = [self getCachePathWithUrl:url];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:filePath]) {
                NSDictionary *cacheData = [[NSDictionary alloc]initWithContentsOfFile:filePath];
                if (successBlock) {
                    successBlock(cacheData);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading: returnJson: msg: isCacheReturn:)]) {
                    [weakSelf.delegate requestDidFinishLoading:tag returnJson:cacheData msg:msg isCacheReturn:YES];
                }
                [weakSelf performSelector:@selector(finishedRequest:didFaild:) withObject:cacheData withObject:nil];
                if (!update) {
                    [weakSelf removewItem];
                }
            }
        }
        if (update) {
            if (networkType == NetWorkGET) {
                [manager GET:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (successBlock) {
                        successBlock(responseObject);
                    }
                    if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading: returnJson: msg: isCacheReturn:)]) {
                        [weakSelf.delegate requestDidFinishLoading:tag returnJson:responseObject msg:msg isCacheReturn:NO];
                    }
                    [weakSelf performSelector:@selector(finishedRequest:didFaild:) withObject:responseObject withObject:nil];
                    [weakSelf removewItem];
                    [responseObject writeToFile:[self getCachePathWithUrl:url] atomically:YES];
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
                    if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading: returnJson: msg: isCacheReturn:)]) {
                        [weakSelf.delegate requestDidFinishLoading:tag returnJson:responseObject msg:msg isCacheReturn:NO];
                    }
                    [weakSelf performSelector:@selector(finishedRequest:didFaild:) withObject:responseObject withObject:nil];
                    [weakSelf removewItem];
                    [responseObject writeToFile:[self getCachePathWithUrl:url] atomically:YES];
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
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml", @"text/html", nil];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/plain",@"text/javascript", nil];
        if (params == nil) {
            params = @{@"format": @"xml"};
        }else{
            [params setValue:@"xml" forKey:@"format"];
        }
        if (networkType == NetWorkGET) {
            NSLog(@"get===xml====%@", requestUrl);
            [manager GET:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *returnData = [NSDictionary dictionaryWithXMLParser:responseObject];
//                GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:responseObject error:nil];
//                GDataXMLElement *rootElement = [doc rootElement];
                if (successBlock) {
                    successBlock(returnData);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading: returnJson: msg: isCacheReturn:)]) {
                    [weakSelf.delegate requestDidFinishLoading:tag returnJson:returnData msg:msg isCacheReturn:NO];
                }
                
                [weakSelf removewItem];
                [returnData writeToFile:[self getCachePathWithUrl:url] atomically:YES];
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
                if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading: returnJson: msg: isCacheReturn:)]) {
                    [weakSelf.delegate requestDidFinishLoading:tag returnJson:returnData msg:msg isCacheReturn:NO];
                }
                [weakSelf removewItem];
                [returnData writeToFile:[self getCachePathWithUrl:url] atomically:YES];
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
    return self;
}

//根据url获取缓存路径
- (NSString*)getCachePathWithUrl:(NSString*)url {
    //获取缓存全路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    cachePath = [cachePath stringByAppendingString:@"/"];
    NSString *filePath = [[cachePath stringByAppendingString:[MD5 encoding:url]] stringByAppendingString:@".txt"];
    return filePath;
}

//创建AFHTTPSessionManager
- (AFHTTPSessionManager *)getHttpSessionManager:(NetWorkDataType)dataType {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    if (dataType == NetWorkJSON) {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", nil];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
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
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"loginName"];
    [manager.requestSerializer setValue:[self getKeyWithUrl:_url] forHTTPHeaderField:WD_ENCRYPT];
    return manager;
}

- (NSString *)addKeyWithUrl:(NSString *)url{
    if([url rangeOfString:@"?"].location != NSNotFound){
        url = [url stringByAppendingString:@"&"];
    }else{
        url = [url stringByAppendingString:@"?"];
    }
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
    str = [str stringByAppendingString:@"&"];
    str = [str stringByAppendingString:WD_VERSION];
    str = [str stringByAppendingString:@"="];
    if ([userDefaults stringForKey:WD_VERSION] && (![[userDefaults stringForKey:WD_VERSION] isEqualToString:@""])) {
        str = [str stringByAppendingString:[userDefaults stringForKey:WD_VERSION]];
    }
    
    str = [str stringByAppendingString:@"&"];
    str = [str stringByAppendingString:WD_CHANNEL];
    str = [str stringByAppendingString:@"="];
    if ([userDefaults stringForKey:WD_CHANNEL] && (![[userDefaults stringForKey:WD_CHANNEL] isEqualToString:@""])) {
        str = [str stringByAppendingString:[userDefaults stringForKey:WD_CHANNEL]];
    }
    
    str = [str stringByAppendingString:@"&"];
    str = [str stringByAppendingString:WD_UA];
    str = [str stringByAppendingString:@"="];
    if ([userDefaults stringForKey:WD_UA] && (![[userDefaults stringForKey:WD_UA] isEqualToString:@""])) {
        str = [str stringByAppendingString:[userDefaults stringForKey:WD_UA]];
    }
    
    str = [str stringByAppendingString:@"&"];
    str = [str stringByAppendingString:WD_UUID];
    str = [str stringByAppendingString:@"="];
    if ([userDefaults stringForKey:WD_UUID] && (![[userDefaults stringForKey:WD_UUID] isEqualToString:@""])) {
        str = [str stringByAppendingString:[userDefaults stringForKey:WD_UUID]];
    }
    str = [str stringByAppendingString:@"&loginName="];
    //    str = [str stringByAppendingString:[userDefaults stringForKey:@"111"]];
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
        if ([weakSelf.delegate respondsToSelector:@selector(netWorkWillDealloc:)]) {
            [weakSelf.delegate netWorkWillDealloc:weakSelf];
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
