//
//  UserInfoHandle.m
//  henews250
//
//  Created by 汪洋 on 2016/10/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "UserInfoHandle.h"

static NSString * const userInfoKey = @"userInfoKey";

@implementation UserInfoHandle

+ (LoaclUserInfoData *)getUserInfoFromLocal {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:userInfoKey];
    LoaclUserInfoData *mode = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if (!mode) {
        mode = [[LoaclUserInfoData alloc]init];
        mode.isAutoLogin = YES;
        mode.isRememberPassword = YES;
        mode.isLogin = NO;
    }
    return mode;
}

+ (void)saveUserInfo2Local:(LoaclUserInfoData *)userInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //变为NSData类型
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    [userDefaults setObject:data forKey:userInfoKey];
    [userDefaults synchronize];
}

+ (BOOL)isLogin {
    LoaclUserInfoData *data = [self getUserInfoFromLocal];
    return data.isLogin;
}
@end
