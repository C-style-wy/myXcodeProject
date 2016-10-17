//
//  UserInfoHandle.h
//  henews250
//
//  Created by 汪洋 on 2016/10/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoaclUserInfoData.h"

@interface UserInfoHandle : NSObject

+ (LoaclUserInfoData *)getUserInfoFromLocal;

+ (void)saveUserInfo2Local:(LoaclUserInfoData *)userInfo;

@end
