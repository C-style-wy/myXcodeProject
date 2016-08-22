//
//  Request.m
//  henews250
//
//  Created by 汪洋 on 16/7/12.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "Request.h"
#import "MacroDefinition.h"

@implementation Request {
    NSString *_url;
}

- (id)initWithUrl:(NSString*)url {
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

+ (void)requestPostForJSON:(NSString *)tag url:(NSString *)urlString delegate:(id)delegate paras:(NSDictionary *)paras msg:(NSInteger)msg useCache:(BOOL)use {
    if ([urlString isEqualToString:@""]) {
        [delegate requestDidReturn:tag returnJson:nil msg:msg isCacheReturn:YES];
        return;
    }
    Request *request = [[self alloc]initWithUrl:urlString];
    if([urlString rangeOfString:@"?"].location != NSNotFound){
        urlString = [urlString stringByAppendingString:@"&"];
    }else{
        urlString = [urlString stringByAppendingString:@"?"];
    }
    urlString = [urlString stringByAppendingString:WD_ENCRYPT];
    urlString = [urlString stringByAppendingString:@"="];
    urlString = [urlString stringByAppendingString:[request getKeyWithUrl:urlString]];
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //如果用缓存，才会获取缓存路径
    if (use) {
        NSString *filePath = [request getCachePathWithUrl:urlString];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:filePath]) {
            NSDictionary *cacheData = [[NSDictionary alloc]initWithContentsOfFile:filePath];
            [delegate requestDidReturn:tag returnJson:cacheData msg:msg isCacheReturn:YES];
        }
    }
    
    [[request createHttpWithParam:@"JSON"] POST:urlString parameters:paras progress:nil success:^(NSURLSessionDataTask *task, id responseObject){
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (resultDic) {
            [delegate requestDidReturn:tag returnJson:resultDic msg:msg isCacheReturn:NO];
            
            [resultDic writeToFile:[request getCachePathWithUrl:urlString] atomically:YES];
        }
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        //失败
        [delegate requestDidReturn:tag returnJson:nil msg:msg isCacheReturn:NO];
    }];
    
}

+ (void)requestPostForJSON:(NSString *)tag url:(NSString *)urlString delegate:(id)delegate paras:(NSDictionary *)paras msg:(NSInteger)msg useCache:(BOOL)use update:(BOOL)update {
    if ([urlString isEqualToString:@""]) {
        [delegate requestDidReturn:tag returnJson:nil msg:msg isCacheReturn:YES];
        return;
    }
    Request *request = [[self alloc]initWithUrl:urlString];
    
    if([urlString rangeOfString:@"?"].location != NSNotFound){
        urlString = [urlString stringByAppendingString:@"&"];
    }else{
        urlString = [urlString stringByAppendingString:@"?"];
    }
    urlString = [urlString stringByAppendingString:WD_ENCRYPT];
    urlString = [urlString stringByAppendingString:@"="];
    urlString = [urlString stringByAppendingString:[request getKeyWithUrl:urlString]];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if (!update) {
        use = true;
    }
    //如果用缓冲才会获取缓存路径
    if (use) {
        NSString *filePath = [request getCachePathWithUrl:urlString];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:filePath]) {
            NSDictionary *cacheData = [[NSDictionary alloc]initWithContentsOfFile:filePath];
            [delegate requestDidReturn:tag returnJson:cacheData msg:msg isCacheReturn:YES];
        }
    }
    if (update) {
        [[request createHttpWithParam:@"JSON"] POST:urlString parameters:paras progress:nil success:^(NSURLSessionDataTask *task, id responseObject){
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (resultDic) {
                [delegate requestDidReturn:tag returnJson:resultDic msg:msg isCacheReturn:NO];
                [resultDic writeToFile:[request getCachePathWithUrl:urlString] atomically:YES];
            }
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            //失败
            [delegate requestDidReturn:tag returnJson:nil msg:msg isCacheReturn:NO];
        }];
    }
}

+ (void)requestPostForXML:(NSString*)tag url:(NSString*)urlString delegate:(id)delegate paras:(NSDictionary*)paras msg:(NSInteger)msg useCache:(BOOL)use update:(BOOL)update {
    Request *request = [[self alloc]initWithUrl:urlString];
    if([urlString rangeOfString:@"?"].location != NSNotFound){
        urlString = [urlString stringByAppendingString:@"&"];
    }else{
        urlString = [urlString stringByAppendingString:@"?"];
    }
    urlString = [urlString stringByAppendingString:WD_ENCRYPT];
    urlString = [urlString stringByAppendingString:@"="];
    urlString = [urlString stringByAppendingString:[request getKeyWithUrl:urlString]];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary *dict = @{@"format": @"xml"};
    [[request createHttpWithParam:@"XML"] POST:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
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
- (AFHTTPSessionManager *)createHttpWithParam:(NSString*)dataTypeString {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if ([dataTypeString isEqualToString:@"JSON"]) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }else if ([dataTypeString isEqualToString:@"XML"]) {
        manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
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

//返回鉴权
- (NSString *)getKeyWithUrl:(NSString *)url{
    NSRange range = [url rangeOfString:SERVER_URL];
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
@end
