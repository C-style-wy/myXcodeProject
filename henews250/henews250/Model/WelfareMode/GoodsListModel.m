//
//  GoodsListModel.m
//  henews250
//
//  Created by 汪洋 on 2016/10/11.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "GoodsListModel.h"

NSString *const kGoodsListModelContentType = @"contentType";
NSString *const kGoodsListModelCostScore = @"costScore";
NSString *const kGoodsListModelDetailUrl = @"detailUrl";
NSString *const kGoodsListModelExchangeUrl = @"exchangeUrl";
NSString *const kGoodsListModelImageUrl = @"imageUrl";
NSString *const kGoodsListModelIsActivity = @"isActivity";
NSString *const kGoodsListModelLinkType = @"linkType";
NSString *const kGoodsListModelTitle = @"title";

@interface GoodsListModel ()
@end

@implementation GoodsListModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kGoodsListModelContentType] isKindOfClass:[NSNull class]]){
        self.contentType = dictionary[kGoodsListModelContentType];
    }
    if(![dictionary[kGoodsListModelCostScore] isKindOfClass:[NSNull class]]){
        self.costScore = dictionary[kGoodsListModelCostScore];
    }
    if(![dictionary[kGoodsListModelDetailUrl] isKindOfClass:[NSNull class]]){
        self.detailUrl = dictionary[kGoodsListModelDetailUrl];
    }
    if(![dictionary[kGoodsListModelExchangeUrl] isKindOfClass:[NSNull class]]){
        self.exchangeUrl = dictionary[kGoodsListModelExchangeUrl];
    }
    if(![dictionary[kGoodsListModelImageUrl] isKindOfClass:[NSNull class]]){
        self.imageUrl = dictionary[kGoodsListModelImageUrl];
    }
    if(![dictionary[kGoodsListModelIsActivity] isKindOfClass:[NSNull class]]){
        self.isActivity = dictionary[kGoodsListModelIsActivity];
    }
    if(![dictionary[kGoodsListModelLinkType] isKindOfClass:[NSNull class]]){
        self.linkType = dictionary[kGoodsListModelLinkType];
    }
    if(![dictionary[kGoodsListModelTitle] isKindOfClass:[NSNull class]]){
        self.title = dictionary[kGoodsListModelTitle];
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
        dictionary[kGoodsListModelContentType] = self.contentType;
    }
    if(self.costScore != nil){
        dictionary[kGoodsListModelCostScore] = self.costScore;
    }
    if(self.detailUrl != nil){
        dictionary[kGoodsListModelDetailUrl] = self.detailUrl;
    }
    if(self.exchangeUrl != nil){
        dictionary[kGoodsListModelExchangeUrl] = self.exchangeUrl;
    }
    if(self.imageUrl != nil){
        dictionary[kGoodsListModelImageUrl] = self.imageUrl;
    }
    if(self.isActivity != nil){
        dictionary[kGoodsListModelIsActivity] = self.isActivity;
    }
    if(self.linkType != nil){
        dictionary[kGoodsListModelLinkType] = self.linkType;
    }
    if(self.title != nil){
        dictionary[kGoodsListModelTitle] = self.title;
    }
    return dictionary;
    
}

@end
