//
//  WelfareMode.m
//  henews250
//
//  Created by 汪洋 on 2016/10/11.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "WelfareMode.h"

NSString *const kRootClassModelAreaList = @"areaList";
NSString *const kRootClassModelBanners = @"banners";
NSString *const kRootClassModelExchangeRecordUrl = @"exchangeRecordUrl";
NSString *const kRootClassModelFuliNodeId = @"fuliNodeId";
NSString *const kRootClassModelMoreFuliUrl = @"moreFuliUrl";
NSString *const kRootClassModelScore = @"score";

@interface WelfareMode ()
@end

@implementation WelfareMode

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(dictionary[kRootClassModelAreaList] != nil && [dictionary[kRootClassModelAreaList] isKindOfClass:[NSArray class]]){
        NSArray * areaListDictionaries = dictionary[kRootClassModelAreaList];
        NSMutableArray * areaListItems = [NSMutableArray array];
        for(NSDictionary * areaListDictionary in areaListDictionaries){
            AreaListModel * areaListItem = [[AreaListModel alloc] initWithDictionary:areaListDictionary];
            [areaListItems addObject:areaListItem];
        }
        self.areaList = areaListItems;
    }
    if(dictionary[kRootClassModelBanners] != nil && [dictionary[kRootClassModelBanners] isKindOfClass:[NSArray class]]){
        NSArray * bannersDictionaries = dictionary[kRootClassModelBanners];
        NSMutableArray * bannersItems = [NSMutableArray array];
        for(NSDictionary * bannersDictionary in bannersDictionaries){
            WelfareBannerModel * bannersItem = [[WelfareBannerModel alloc] initWithDictionary:bannersDictionary];
            [bannersItems addObject:bannersItem];
        }
        self.banners = bannersItems;
    }
    if(![dictionary[kRootClassModelExchangeRecordUrl] isKindOfClass:[NSNull class]]){
        self.exchangeRecordUrl = dictionary[kRootClassModelExchangeRecordUrl];
    }
    if(![dictionary[kRootClassModelFuliNodeId] isKindOfClass:[NSNull class]]){
        self.fuliNodeId = dictionary[kRootClassModelFuliNodeId];
    }
    if(![dictionary[kRootClassModelMoreFuliUrl] isKindOfClass:[NSNull class]]){
        self.moreFuliUrl = dictionary[kRootClassModelMoreFuliUrl];
    }
    if(![dictionary[kRootClassModelScore] isKindOfClass:[NSNull class]]){
        self.score = dictionary[kRootClassModelScore];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.areaList != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(AreaListModel * areaListElement in self.areaList){
            [dictionaryElements addObject:[areaListElement toDictionary]];
        }
        dictionary[kRootClassModelAreaList] = dictionaryElements;
    }
    if(self.banners != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(WelfareBannerModel * bannersElement in self.banners){
            [dictionaryElements addObject:[bannersElement toDictionary]];
        }
        dictionary[kRootClassModelBanners] = dictionaryElements;
    }
    if(self.exchangeRecordUrl != nil){
        dictionary[kRootClassModelExchangeRecordUrl] = self.exchangeRecordUrl;
    }
    if(self.fuliNodeId != nil){
        dictionary[kRootClassModelFuliNodeId] = self.fuliNodeId;
    }
    if(self.moreFuliUrl != nil){
        dictionary[kRootClassModelMoreFuliUrl] = self.moreFuliUrl;
    }
    if(self.score != nil){
        dictionary[kRootClassModelScore] = self.score;
    }
    return dictionary;
    
}

+ (NSDictionary*)objectClassInArray {
    return @{
             @"areaList":@"AreaListModel",
             @"banners":@"WelfareBannerModel",
             };
}

@end
