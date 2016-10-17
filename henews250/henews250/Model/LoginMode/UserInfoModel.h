//
//  UserInfoModel.h
//  henews250
//
//  Created by 汪洋 on 2016/10/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "WeiboIdMapModel.h"

@interface UserInfoModel : BaseMode

@property (nonatomic, strong) NSString * accountName;
@property (nonatomic, strong) NSString * accountType;
@property (nonatomic, strong) NSString * area;
@property (nonatomic, strong) NSString * birthday;
@property (nonatomic, strong) NSString * blood;
@property (nonatomic, strong) NSString * constellation;
@property (nonatomic, strong) NSString * endTime;
@property (nonatomic, strong) NSString * identityId;
@property (nonatomic, strong) NSString * isFree;
@property (nonatomic, assign) NSInteger isSetPwd;
@property (nonatomic, strong) NSString * mail;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * password;
@property (nonatomic, strong) NSString * perDesc;
@property (nonatomic, strong) NSString * pic;
@property (nonatomic, strong) NSString * platForm;
@property (nonatomic, strong) NSString * profession;
@property (nonatomic, strong) NSString * realName;
@property (nonatomic, strong) NSString * sex;
@property (nonatomic, strong) NSString * sname;
@property (nonatomic, strong) NSString * token;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) WeiboIdMapModel * weiboIdMap;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
