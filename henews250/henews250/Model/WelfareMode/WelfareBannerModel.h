//
//  WelfareBannerModel.h
//  henews250
//
//  Created by 汪洋 on 2016/10/11.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"

@interface WelfareBannerModel : BaseMode

@property (nonatomic, strong) NSString * contentType;
@property (nonatomic, strong) NSString * imageUrl;
@property (nonatomic, strong) NSString * isGoods;
@property (nonatomic, strong) NSString * linkType;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * url;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
