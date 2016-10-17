//
//  UserInfoModel.m
//  henews250
//
//  Created by 汪洋 on 2016/10/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "UserInfoModel.h"

#import "UserInfoModel.h"

NSString *const kUserInfoModelAccountName = @"accountName";
NSString *const kUserInfoModelAccountType = @"accountType";
NSString *const kUserInfoModelArea = @"area";
NSString *const kUserInfoModelBirthday = @"birthday";
NSString *const kUserInfoModelBlood = @"blood";
NSString *const kUserInfoModelConstellation = @"constellation";
NSString *const kUserInfoModelEndTime = @"endTime";
NSString *const kUserInfoModelIdentityId = @"identityId";
NSString *const kUserInfoModelIsFree = @"isFree";
NSString *const kUserInfoModelIsSetPwd = @"isSetPwd";
NSString *const kUserInfoModelMail = @"mail";
NSString *const kUserInfoModelMobile = @"mobile";
NSString *const kUserInfoModelName = @"name";
NSString *const kUserInfoModelPassword = @"password";
NSString *const kUserInfoModelPerDesc = @"perDesc";
NSString *const kUserInfoModelPic = @"pic";
NSString *const kUserInfoModelPlatForm = @"platForm";
NSString *const kUserInfoModelProfession = @"profession";
NSString *const kUserInfoModelRealName = @"realName";
NSString *const kUserInfoModelSex = @"sex";
NSString *const kUserInfoModelSname = @"sname";
NSString *const kUserInfoModelToken = @"token";
NSString *const kUserInfoModelUserId = @"userId";
NSString *const kUserInfoModelWeiboIdMap = @"weiboIdMap";

@interface UserInfoModel ()
@end
@implementation UserInfoModel
/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kUserInfoModelAccountName] isKindOfClass:[NSNull class]]){
        self.accountName = dictionary[kUserInfoModelAccountName];
    }
    if(![dictionary[kUserInfoModelAccountType] isKindOfClass:[NSNull class]]){
        self.accountType = dictionary[kUserInfoModelAccountType];
    }
    if(![dictionary[kUserInfoModelArea] isKindOfClass:[NSNull class]]){
        self.area = dictionary[kUserInfoModelArea];
    }
    if(![dictionary[kUserInfoModelBirthday] isKindOfClass:[NSNull class]]){
        self.birthday = dictionary[kUserInfoModelBirthday];
    }
    if(![dictionary[kUserInfoModelBlood] isKindOfClass:[NSNull class]]){
        self.blood = dictionary[kUserInfoModelBlood];
    }
    if(![dictionary[kUserInfoModelConstellation] isKindOfClass:[NSNull class]]){
        self.constellation = dictionary[kUserInfoModelConstellation];
    }
    if(![dictionary[kUserInfoModelEndTime] isKindOfClass:[NSNull class]]){
        self.endTime = dictionary[kUserInfoModelEndTime];
    }
    if(![dictionary[kUserInfoModelIdentityId] isKindOfClass:[NSNull class]]){
        self.identityId = dictionary[kUserInfoModelIdentityId];
    }
    if(![dictionary[kUserInfoModelIsFree] isKindOfClass:[NSNull class]]){
        self.isFree = dictionary[kUserInfoModelIsFree];
    }
    if(![dictionary[kUserInfoModelIsSetPwd] isKindOfClass:[NSNull class]]){
        self.isSetPwd = [dictionary[kUserInfoModelIsSetPwd] integerValue];
    }
    
    if(![dictionary[kUserInfoModelMail] isKindOfClass:[NSNull class]]){
        self.mail = dictionary[kUserInfoModelMail];
    }
    if(![dictionary[kUserInfoModelMobile] isKindOfClass:[NSNull class]]){
        self.mobile = dictionary[kUserInfoModelMobile];
    }
    if(![dictionary[kUserInfoModelName] isKindOfClass:[NSNull class]]){
        self.name = dictionary[kUserInfoModelName];
    }
    if(![dictionary[kUserInfoModelPassword] isKindOfClass:[NSNull class]]){
        self.password = dictionary[kUserInfoModelPassword];
    }
    if(![dictionary[kUserInfoModelPerDesc] isKindOfClass:[NSNull class]]){
        self.perDesc = dictionary[kUserInfoModelPerDesc];
    }
    if(![dictionary[kUserInfoModelPic] isKindOfClass:[NSNull class]]){
        self.pic = dictionary[kUserInfoModelPic];
    }
    if(![dictionary[kUserInfoModelPlatForm] isKindOfClass:[NSNull class]]){
        self.platForm = dictionary[kUserInfoModelPlatForm];
    }
    if(![dictionary[kUserInfoModelProfession] isKindOfClass:[NSNull class]]){
        self.profession = dictionary[kUserInfoModelProfession];
    }
    if(![dictionary[kUserInfoModelRealName] isKindOfClass:[NSNull class]]){
        self.realName = dictionary[kUserInfoModelRealName];
    }
    if(![dictionary[kUserInfoModelSex] isKindOfClass:[NSNull class]]){
        self.sex = dictionary[kUserInfoModelSex];
    }
    if(![dictionary[kUserInfoModelSname] isKindOfClass:[NSNull class]]){
        self.sname = dictionary[kUserInfoModelSname];
    }
    if(![dictionary[kUserInfoModelToken] isKindOfClass:[NSNull class]]){
        self.token = dictionary[kUserInfoModelToken];
    }
    if(![dictionary[kUserInfoModelUserId] isKindOfClass:[NSNull class]]){
        self.userId = [dictionary[kUserInfoModelUserId] integerValue];
    }
    
    if(![dictionary[kUserInfoModelWeiboIdMap] isKindOfClass:[NSNull class]]){
        self.weiboIdMap = [[WeiboIdMapModel alloc] initWithDictionary:dictionary[kUserInfoModelWeiboIdMap]];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.accountName != nil){
        dictionary[kUserInfoModelAccountName] = self.accountName;
    }
    if(self.accountType != nil){
        dictionary[kUserInfoModelAccountType] = self.accountType;
    }
    if(self.area != nil){
        dictionary[kUserInfoModelArea] = self.area;
    }
    if(self.birthday != nil){
        dictionary[kUserInfoModelBirthday] = self.birthday;
    }
    if(self.blood != nil){
        dictionary[kUserInfoModelBlood] = self.blood;
    }
    if(self.constellation != nil){
        dictionary[kUserInfoModelConstellation] = self.constellation;
    }
    if(self.endTime != nil){
        dictionary[kUserInfoModelEndTime] = self.endTime;
    }
    if(self.identityId != nil){
        dictionary[kUserInfoModelIdentityId] = self.identityId;
    }
    if(self.isFree != nil){
        dictionary[kUserInfoModelIsFree] = self.isFree;
    }
    dictionary[kUserInfoModelIsSetPwd] = @(self.isSetPwd);
    if(self.mail != nil){
        dictionary[kUserInfoModelMail] = self.mail;
    }
    if(self.mobile != nil){
        dictionary[kUserInfoModelMobile] = self.mobile;
    }
    if(self.name != nil){
        dictionary[kUserInfoModelName] = self.name;
    }
    if(self.password != nil){
        dictionary[kUserInfoModelPassword] = self.password;
    }
    if(self.perDesc != nil){
        dictionary[kUserInfoModelPerDesc] = self.perDesc;
    }
    if(self.pic != nil){
        dictionary[kUserInfoModelPic] = self.pic;
    }
    if(self.platForm != nil){
        dictionary[kUserInfoModelPlatForm] = self.platForm;
    }
    if(self.profession != nil){
        dictionary[kUserInfoModelProfession] = self.profession;
    }
    if(self.realName != nil){
        dictionary[kUserInfoModelRealName] = self.realName;
    }
    if(self.sex != nil){
        dictionary[kUserInfoModelSex] = self.sex;
    }
    if(self.sname != nil){
        dictionary[kUserInfoModelSname] = self.sname;
    }
    if(self.token != nil){
        dictionary[kUserInfoModelToken] = self.token;
    }
    dictionary[kUserInfoModelUserId] = @(self.userId);
    if(self.weiboIdMap != nil){
        dictionary[kUserInfoModelWeiboIdMap] = [self.weiboIdMap toDictionary];
    }
    return dictionary;
    
}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if(self.accountName != nil){
        [aCoder encodeObject:self.accountName forKey:kUserInfoModelAccountName];
    }
    if(self.accountType != nil){
        [aCoder encodeObject:self.accountType forKey:kUserInfoModelAccountType];
    }
    if(self.area != nil){
        [aCoder encodeObject:self.area forKey:kUserInfoModelArea];
    }
    if(self.birthday != nil){
        [aCoder encodeObject:self.birthday forKey:kUserInfoModelBirthday];
    }
    if(self.blood != nil){
        [aCoder encodeObject:self.blood forKey:kUserInfoModelBlood];
    }
    if(self.constellation != nil){
        [aCoder encodeObject:self.constellation forKey:kUserInfoModelConstellation];
    }
    if(self.endTime != nil){
        [aCoder encodeObject:self.endTime forKey:kUserInfoModelEndTime];
    }
    if(self.identityId != nil){
        [aCoder encodeObject:self.identityId forKey:kUserInfoModelIdentityId];
    }
    if(self.isFree != nil){
        [aCoder encodeObject:self.isFree forKey:kUserInfoModelIsFree];
    }
    [aCoder encodeObject:@(self.isSetPwd) forKey:kUserInfoModelIsSetPwd];	if(self.mail != nil){
        [aCoder encodeObject:self.mail forKey:kUserInfoModelMail];
    }
    if(self.mobile != nil){
        [aCoder encodeObject:self.mobile forKey:kUserInfoModelMobile];
    }
    if(self.name != nil){
        [aCoder encodeObject:self.name forKey:kUserInfoModelName];
    }
    if(self.password != nil){
        [aCoder encodeObject:self.password forKey:kUserInfoModelPassword];
    }
    if(self.perDesc != nil){
        [aCoder encodeObject:self.perDesc forKey:kUserInfoModelPerDesc];
    }
    if(self.pic != nil){
        [aCoder encodeObject:self.pic forKey:kUserInfoModelPic];
    }
    if(self.platForm != nil){
        [aCoder encodeObject:self.platForm forKey:kUserInfoModelPlatForm];
    }
    if(self.profession != nil){
        [aCoder encodeObject:self.profession forKey:kUserInfoModelProfession];
    }
    if(self.realName != nil){
        [aCoder encodeObject:self.realName forKey:kUserInfoModelRealName];
    }
    if(self.sex != nil){
        [aCoder encodeObject:self.sex forKey:kUserInfoModelSex];
    }
    if(self.sname != nil){
        [aCoder encodeObject:self.sname forKey:kUserInfoModelSname];
    }
    if(self.token != nil){
        [aCoder encodeObject:self.token forKey:kUserInfoModelToken];
    }
    [aCoder encodeObject:@(self.userId) forKey:kUserInfoModelUserId];	if(self.weiboIdMap != nil){
        [aCoder encodeObject:self.weiboIdMap forKey:kUserInfoModelWeiboIdMap];
    }
    
}

@end
