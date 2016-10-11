//
//  WelfareMode.h
//  henews250
//
//  Created by 汪洋 on 2016/10/11.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "AreaListModel.h"
#import "WelfareBannerModel.h"

@interface WelfareMode : BaseMode

@property (nonatomic, strong) NSArray * areaList;
@property (nonatomic, strong) NSArray * banners;
@property (nonatomic, strong) NSString * exchangeRecordUrl;
@property (nonatomic, strong) NSString * fuliNodeId;
@property (nonatomic, strong) NSString * moreFuliUrl;
@property (nonatomic, strong) NSString * score;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
