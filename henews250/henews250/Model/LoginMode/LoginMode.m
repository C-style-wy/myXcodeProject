//
//  LoginMode.m
//  henews250
//
//  Created by 汪洋 on 2016/10/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "LoginMode.h"

NSString *const kRootClassModelResultCode = @"resultCode";
NSString *const kRootClassModelResultMsg = @"resultMsg";
NSString *const kRootClassModelSystemTime = @"systemTime";
NSString *const kRootClassModelUserInfo = @"userInfo";

@interface LoginMode ()
@end
@implementation LoginMode
/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kRootClassModelResultCode] isKindOfClass:[NSNull class]]){
        self.resultCode = dictionary[kRootClassModelResultCode];
    }
    if(![dictionary[kRootClassModelResultMsg] isKindOfClass:[NSNull class]]){
        self.resultMsg = dictionary[kRootClassModelResultMsg];
    }
    if(![dictionary[kRootClassModelSystemTime] isKindOfClass:[NSNull class]]){
        self.systemTime = [dictionary[kRootClassModelSystemTime] integerValue];
    }
    
    if(![dictionary[kRootClassModelUserInfo] isKindOfClass:[NSNull class]]){
        self.userInfo = [[UserInfoModel alloc] initWithDictionary:dictionary[kRootClassModelUserInfo]];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.resultCode != nil){
        dictionary[kRootClassModelResultCode] = self.resultCode;
    }
    if(self.resultMsg != nil){
        dictionary[kRootClassModelResultMsg] = self.resultMsg;
    }
    dictionary[kRootClassModelSystemTime] = @(self.systemTime);
    if(self.userInfo != nil){
        dictionary[kRootClassModelUserInfo] = [self.userInfo toDictionary];
    }
    return dictionary;
}


@end
