//
//  AreaListModel.h
//  henews250
//
//  Created by 汪洋 on 2016/10/11.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "GoodsListModel.h"

@interface AreaListModel : BaseMode

@property (nonatomic, strong) NSString * contentType;
@property (nonatomic, strong) NSArray * goodsList;
@property (nonatomic, strong) NSString * linkType;
@property (nonatomic, strong) NSString * moreUrl;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * showType;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
