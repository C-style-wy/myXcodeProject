//
//  AreaListModel.m
//  henews250
//
//  Created by 汪洋 on 2016/10/11.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "AreaListModel.h"

NSString *const kAreaListModelContentType = @"contentType";
NSString *const kAreaListModelGoodsList = @"goodsList";
NSString *const kAreaListModelLinkType = @"linkType";
NSString *const kAreaListModelMoreUrl = @"moreUrl";
NSString *const kAreaListModelName = @"name";
NSString *const kAreaListModelShowType = @"showType";

@interface AreaListModel ()
@end

@implementation AreaListModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kAreaListModelContentType] isKindOfClass:[NSNull class]]){
        self.contentType = dictionary[kAreaListModelContentType];
    }
    if(dictionary[kAreaListModelGoodsList] != nil && [dictionary[kAreaListModelGoodsList] isKindOfClass:[NSArray class]]){
        NSArray * goodsListDictionaries = dictionary[kAreaListModelGoodsList];
        NSMutableArray * goodsListItems = [NSMutableArray array];
        for(NSDictionary * goodsListDictionary in goodsListDictionaries){
            GoodsListModel * goodsListItem = [[GoodsListModel alloc] initWithDictionary:goodsListDictionary];
            [goodsListItems addObject:goodsListItem];
        }
        self.goodsList = goodsListItems;
    }
    if(![dictionary[kAreaListModelLinkType] isKindOfClass:[NSNull class]]){
        self.linkType = dictionary[kAreaListModelLinkType];
    }
    if(![dictionary[kAreaListModelMoreUrl] isKindOfClass:[NSNull class]]){
        self.moreUrl = dictionary[kAreaListModelMoreUrl];
    }
    if(![dictionary[kAreaListModelName] isKindOfClass:[NSNull class]]){
        self.name = dictionary[kAreaListModelName];
    }
    if(![dictionary[kAreaListModelShowType] isKindOfClass:[NSNull class]]){
        self.showType = dictionary[kAreaListModelShowType];
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
        dictionary[kAreaListModelContentType] = self.contentType;
    }
    if(self.goodsList != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(GoodsListModel * goodsListElement in self.goodsList){
            [dictionaryElements addObject:[goodsListElement toDictionary]];
        }
        dictionary[kAreaListModelGoodsList] = dictionaryElements;
    }
    if(self.linkType != nil){
        dictionary[kAreaListModelLinkType] = self.linkType;
    }
    if(self.moreUrl != nil){
        dictionary[kAreaListModelMoreUrl] = self.moreUrl;
    }
    if(self.name != nil){
        dictionary[kAreaListModelName] = self.name;
    }
    if(self.showType != nil){
        dictionary[kAreaListModelShowType] = self.showType;
    }
    return dictionary;
    
}

+ (NSDictionary*)objectClassInArray {
    return @{
             @"goodsList":@"GoodsListModel",
             };
}

@end
