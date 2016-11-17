//
//  ReadRecordManage.m
//  henews250
//
//  Created by 汪洋 on 2016/11/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "ReadRecordManage.h"

static NSString * const ReadRecordKey = @"ReadRecordKey";

@implementation ReadRecordManage

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static ReadRecordManage *_factory;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _factory = [super allocWithZone:zone];
    });
    return _factory;
}

//返回单例
+ (instancetype)shareInstance {
    return [[super alloc]init];
}

- (void)saveReadNewsWithId:(NSString *)newsId {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:ReadRecordKey];
    NSMutableDictionary *record = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (record) {
        [record setValue:@"1" forKey:newsId];
    }else{
        record = [NSMutableDictionary dictionaryWithObject:@"1" forKey:newsId];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:record];
    [userDefaults setObject:data1 forKey:ReadRecordKey];
    [userDefaults synchronize];
}

- (BOOL)isAlreadyReadWithId:(NSString *)newsId {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:ReadRecordKey];
    NSMutableDictionary *record = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if ([record objectForKey:newsId] && [[record objectForKey:newsId] isEqualToString:@"1"]) {
        return YES;
    }else{
        return NO;
    }
}

@end
