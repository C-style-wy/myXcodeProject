//
//  Request.m
//  henews
//
//  Created by 汪洋 on 15/10/29.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "Request.h"
#import "AFNetworking.h"

@implementation Request{
    NSString *_url;
}

- (id)initWithUrl:(NSString *)url{
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

+(void)requestPostForJSON:(NSString*)tag url:(NSString*)urlString delegate:(id)delegate paras:(NSDictionary*)paras msg:(NSInteger)msg useCache:(BOOL)use{
//    urlString = [GET_SERVER stringByAppendingString:urlString];
    //提醒：stringByAddingPercentEscapesUsingEncoding已经遗弃，用stringByAddingPercentEncodingWithAllowedCharacters代替
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([urlString isEqualToString:@""]) {
        [delegate requestDidReturn:tag returnJson:nil msg:msg isCacheReturn:YES];
        return;
    }
    Request *request = [[self alloc]initWithUrl:urlString];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //如果用缓冲才会获取缓存路径
    if (use) {
        NSString *filePath = [request getCachePathWithUrl:urlString];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:filePath]) {
            NSDictionary *cacheData = [[NSDictionary alloc]initWithContentsOfFile:filePath];
            [delegate requestDidReturn:tag returnJson:cacheData msg:msg isCacheReturn:YES];
        }
    }
    
    NSLog(@"httpUrl=%@", urlString);
    [[request createHttpWithParam] POST:urlString parameters:paras progress:nil success:^(NSURLSessionDataTask *task, id responseObject){
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

+(void)requestPostForJSON:(NSString*)tag url:(NSString*)urlString delegate:(id)delegate paras:(NSDictionary*)paras msg:(NSInteger)msg useCache:(BOOL)use update:(BOOL)update{
    if ([urlString isEqualToString:@""]) {
        [delegate requestDidReturn:tag returnJson:nil msg:msg isCacheReturn:YES];
        return;
    }
    Request *request = [[self alloc]initWithUrl:urlString];
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
        [[request createHttpWithParam] POST:urlString parameters:paras progress:nil success:^(NSURLSessionDataTask *task, id responseObject){
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
    NSLog(@"httpUrl=%@", urlString);
}

//根据url获取缓存路径
- (NSString*)getCachePathWithUrl:(NSString*)url{
    //获取缓存全路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    cachePath = [cachePath stringByAppendingString:@"/"];
    NSString *filePath = [[cachePath stringByAppendingString:[MD5 encoding:url]] stringByAppendingString:@".txt"];
    return filePath;
}

//创建AFHTTPSessionManager
- (AFHTTPSessionManager *)createHttpWithParam{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:[userDefaults stringForKey:@"clientName"] forHTTPHeaderField:@"clientName"];
    [manager.requestSerializer setValue:[userDefaults stringForKey:@"WD_UUID"] forHTTPHeaderField:@"WD_UUID"];
    [manager.requestSerializer setValue:[userDefaults stringForKey:@"WD_CLIENT_TYPE"] forHTTPHeaderField:@"WD_CLIENT_TYPE"];
    [manager.requestSerializer setValue:[userDefaults stringForKey:@"WD_UA"] forHTTPHeaderField:@"WD_UA"];
    [manager.requestSerializer setValue:[userDefaults stringForKey:@"WD_SYSTEM"] forHTTPHeaderField:@"WD_SYSTEM"];
    [manager.requestSerializer setValue:[userDefaults stringForKey:@"WD_VERSION"] forHTTPHeaderField:@"WD_VERSION"];
    [manager.requestSerializer setValue:[userDefaults stringForKey:@"WD_CHANNEL"] forHTTPHeaderField:@"WD_CHANNEL"];
    [manager.requestSerializer setValue:[userDefaults stringForKey:@"WD_RESOLUTION"] forHTTPHeaderField:@"WD_RESOLUTION"];
    [manager.requestSerializer setValue:[userDefaults stringForKey:@"WD_CP_ID"] forHTTPHeaderField:@"WD_CP_ID"];
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"loginName"];
    [manager.requestSerializer setValue:[self getKeyWithUrl:_url] forHTTPHeaderField:@"encrypt"];

    return manager;
}

//返回鉴权
- (NSString *)getKeyWithUrl:(NSString *)url{
    NSRange range = [url rangeOfString:GET_SERVER];
    NSString *str = [url substringFromIndex:range.length];
    if([str rangeOfString:@"?"].location != NSNotFound){
        NSArray *array = [str componentsSeparatedByString:@"?"];
        str = array[0];
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    str = [str stringByAppendingString:@"?WD_CP_ID="];
    if (![[userDefaults stringForKey:@"WD_CP_ID"] isEqualToString:@""]) {
        str = [str stringByAppendingString:[userDefaults stringForKey:@"WD_CP_ID"]];
    }
    
    str = [str stringByAppendingString:@"&WD_VERSION="];
    if (![[userDefaults stringForKey:@"WD_VERSION"] isEqualToString:@""]) {
        str = [str stringByAppendingString:[userDefaults stringForKey:@"WD_VERSION"]];
    }
    
    str = [str stringByAppendingString:@"&WD_CHANNEL="];
    if (![[userDefaults stringForKey:@"WD_CHANNEL"] isEqualToString:@""]) {
        str = [str stringByAppendingString:[userDefaults stringForKey:@"WD_CHANNEL"]];
    }
    
    str = [str stringByAppendingString:@"&WD_UA="];
    if (![[userDefaults stringForKey:@"WD_UA"] isEqualToString:@""]) {
        str = [str stringByAppendingString:[userDefaults stringForKey:@"WD_UA"]];
    }
    
    str = [str stringByAppendingString:@"&WD_UUID="];
    if (![[userDefaults stringForKey:@"WD_UUID"] isEqualToString:@""]) {
        str = [str stringByAppendingString:[userDefaults stringForKey:@"WD_UUID"]];
    }
    
    str = [str stringByAppendingString:@"&loginName="];
//    str = [str stringByAppendingString:[userDefaults stringForKey:@"111"]];
    
    str = [str stringByAppendingString:@"&salt="];
    str = [str stringByAppendingString:@"53b955afe7d75a1b"];
    return [MD5 encoding:str];
}
@end
