//
//  ShareSDKManager.m
//  henews250
//
//  Created by 汪洋 on 2016/10/16.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "ShareSDKManager.h"

@implementation ShareSDKManager

+ (void)registerApp {
    [[ShareSDKHandle sharedInstance] registerApp];
}


+ (void)getQQUserInfo:(LoginSuccessBlock)success failure:(LoginFailureBlock)failure {
    [[ShareSDKHandle sharedInstance] getUserInfoWithPlatform:SSDKPlatformTypeQQ success:success failure:failure];
}

+ (void)getWeixinUserInfo:(LoginSuccessBlock)success failure:(LoginFailureBlock)failure {
    [[ShareSDKHandle sharedInstance] getUserInfoWithPlatform:SSDKPlatformTypeWechat success:success failure:failure];
}

+ (void)getWeiboUserInfo:(LoginSuccessBlock)success failure:(LoginFailureBlock)failure {
    [[ShareSDKHandle sharedInstance] getUserInfoWithPlatform:SSDKPlatformTypeSinaWeibo success:success failure:failure];
}
@end
