//
//  ShareSDKHandle.h
//  henews250
//
//  Created by 汪洋 on 2016/10/16.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareSDKDefine.h"

@interface ShareSDKHandle : NSObject

+ (ShareSDKHandle *)sharedInstance;

- (void)registerApp;

- (void)getUserInfoWithPlatform:(SSDKPlatformType)platform  success:(LoginSuccessBlock)success failure:(LoginFailureBlock)failure;

@end
