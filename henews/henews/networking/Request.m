//
//  Request.m
//  henews
//
//  Created by 汪洋 on 15/10/29.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "Request.h"
#import "AFNetworking.h"

@implementation Request



+(void)requestPostForJSON:(NSString*)tag url:(NSString*)urlString delegate:(id)delegate paras:(NSDictionary*)paras msg:(NSInteger)msg useCache:(BOOL)use{
//    urlString = [GET_SERVER stringByAppendingString:urlString];
    //提醒：stringByAddingPercentEscapesUsingEncoding已经遗弃，用stringByAddingPercentEncodingWithAllowedCharacters代替
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //获取缓存全路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    cachePath = [cachePath stringByAppendingString:@"/"];
    NSString *filePath = [[cachePath stringByAppendingString:[MD5 encoding:urlString]] stringByAppendingString:@".txt"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]&&use) {
        NSDictionary *cacheData = [[NSDictionary alloc]initWithContentsOfFile:filePath];
        [delegate requestDidReturn:tag returnJson:cacheData msg:msg isCacheReturn:YES];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:[userDefaults stringForKey:@"clieclientNamentName"] forHTTPHeaderField:@"clientName"];
    [manager.requestSerializer setValue:[userDefaults stringForKey:@"WD_UUID"] forHTTPHeaderField:@"WD_UUID"];
    [manager.requestSerializer setValue:[userDefaults stringForKey:@"WD_CLIENT_TYPE"] forHTTPHeaderField:@"WD_CLIENT_TYPE"];
    [manager.requestSerializer setValue:[userDefaults stringForKey:@"WD_UA"] forHTTPHeaderField:@"WD_UA"];
    [manager.requestSerializer setValue:[userDefaults stringForKey:@"WD_SYSTEM"] forHTTPHeaderField:@"WD_SYSTEM"];
    [manager.requestSerializer setValue:[userDefaults stringForKey:@"WD_VERSION"] forHTTPHeaderField:@"WD_VERSION"];
    [manager.requestSerializer setValue:[userDefaults stringForKey:@"WD_CHANNEL"] forHTTPHeaderField:@"WD_CHANNEL"];
    [manager.requestSerializer setValue:[userDefaults stringForKey:@"WD_RESOLUTION"] forHTTPHeaderField:@"WD_RESOLUTION"];
    [manager.requestSerializer setValue:[userDefaults stringForKey:@"WD_CP_ID"] forHTTPHeaderField:@"WD_CP_ID"];
    NSLog(@"httpUrl=%@", urlString);
    [manager POST:urlString parameters:paras progress:nil success:^(NSURLSessionDataTask *task, id responseObject){
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (resultDic) {
            [delegate requestDidReturn:tag returnJson:resultDic msg:msg isCacheReturn:NO];
        }
        if (use) {
            [resultDic writeToFile:filePath atomically:YES];
        }
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        //失败
        [delegate requestDidReturn:tag returnJson:nil msg:msg isCacheReturn:NO];
    }];
}

@end
