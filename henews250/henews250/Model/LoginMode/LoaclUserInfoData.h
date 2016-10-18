//
//  LoaclUserInfoData.h
//  henews250
//
//  Created by 汪洋 on 2016/10/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "UserInfoModel.h"

typedef NS_ENUM(NSUInteger, LoginType) {
    LoginTypeUnknown = 0,  //未知
    LoginTypeThirdParty,   //第三方登录
    LoginTypeOneKey,       //一键登录
    LoginTypeCommon,       //普通登录
};

@interface LoaclUserInfoData : BaseMode

@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, assign) BOOL isAutoLogin;
@property (nonatomic, assign) BOOL isRememberPassword;
@property (nonatomic, strong) UserInfoModel *userInfo;
@property (nonatomic, assign) LoginType loginType;
@property (nonatomic, retain) NSString *password;

@end
