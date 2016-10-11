//
//  WelfareBannerModel.m
//  henews250
//
//  Created by 汪洋 on 2016/10/11.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "WelfareBannerModel.h"

NSString *const kBannerModelContentType = @"contentType";
NSString *const kBannerModelImageUrl = @"imageUrl";
NSString *const kBannerModelIsGoods = @"isGoods";
NSString *const kBannerModelLinkType = @"linkType";
NSString *const kBannerModelTitle = @"title";
NSString *const kBannerModelUrl = @"url";

@interface WelfareBannerModel ()
@end

@implementation WelfareBannerModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kBannerModelContentType] isKindOfClass:[NSNull class]]){
        self.contentType = dictionary[kBannerModelContentType];
    }
    if(![dictionary[kBannerModelImageUrl] isKindOfClass:[NSNull class]]){
        self.imageUrl = dictionary[kBannerModelImageUrl];
    }
    if(![dictionary[kBannerModelIsGoods] isKindOfClass:[NSNull class]]){
        self.isGoods = dictionary[kBannerModelIsGoods];
    }
    if(![dictionary[kBannerModelLinkType] isKindOfClass:[NSNull class]]){
        self.linkType = dictionary[kBannerModelLinkType];
    }
    if(![dictionary[kBannerModelTitle] isKindOfClass:[NSNull class]]){
        self.title = dictionary[kBannerModelTitle];
    }
    if(![dictionary[kBannerModelUrl] isKindOfClass:[NSNull class]]){
        self.url = dictionary[kBannerModelUrl];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.contentType != nil){
        dictionary[kBannerModelContentType] = self.contentType;
    }
    if(self.imageUrl != nil){
        dictionary[kBannerModelImageUrl] = self.imageUrl;
    }
    if(self.isGoods != nil){
        dictionary[kBannerModelIsGoods] = self.isGoods;
    }
    if(self.linkType != nil){
        dictionary[kBannerModelLinkType] = self.linkType;
    }
    if(self.title != nil){
        dictionary[kBannerModelTitle] = self.title;
    }
    if(self.url != nil){
        dictionary[kBannerModelUrl] = self.url;
    }
    return dictionary;
    
}

@end
