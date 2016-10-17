//
//  LoaclUserInfoData.h
//  henews250
//
//  Created by 汪洋 on 2016/10/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "UserInfoModel.h"

@interface LoaclUserInfoData : BaseMode

@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, assign) BOOL isAutoLogin;
@property (nonatomic, assign) BOOL isRememberPassword;
@property (nonatomic, strong) UserInfoModel *userInfo;

@end
