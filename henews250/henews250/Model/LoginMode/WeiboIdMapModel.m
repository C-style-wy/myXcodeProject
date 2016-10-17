//
//  WeiboIdMapModel.m
//  henews250
//
//  Created by 汪洋 on 2016/10/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "WeiboIdMapModel.h"

NSString *const kWeiboIdMapModelTENCENT = @"TENCENT";

@interface WeiboIdMapModel ()
@end
@implementation WeiboIdMapModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kWeiboIdMapModelTENCENT] isKindOfClass:[NSNull class]]){
        self.tENCENT = dictionary[kWeiboIdMapModelTENCENT];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.tENCENT != nil){
        dictionary[kWeiboIdMapModelTENCENT] = self.tENCENT;
    }
    return dictionary;
    
}
@end
