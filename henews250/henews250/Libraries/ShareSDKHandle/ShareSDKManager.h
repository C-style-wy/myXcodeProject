//
//  ShareSDKManager.h
//  henews250
//
//  Created by 汪洋 on 2016/10/16.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareSDKHandle.h"

@interface ShareSDKManager : NSObject

+ (void)registerApp;

+ (void)getQQUserInfo:(LoginSuccessBlock)success failure:(LoginFailureBlock)failure;

+ (void)getWeixinUserInfo:(LoginSuccessBlock)success failure:(LoginFailureBlock)failure;

+ (void)getWeiboUserInfo:(LoginSuccessBlock)success failure:(LoginFailureBlock)failure;

@end
