//
//  LoginMode.h
//  henews250
//
//  Created by 汪洋 on 2016/10/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "UserInfoModel.h"

@interface LoginMode : BaseMode

@property (nonatomic, strong) NSString * resultCode;
@property (nonatomic, strong) NSString * resultMsg;
@property (nonatomic, assign) NSInteger systemTime;
@property (nonatomic, strong) UserInfoModel * userInfo;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
