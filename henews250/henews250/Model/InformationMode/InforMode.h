//
//  InforMode.h
//  henews250
//
//  Created by 汪洋 on 16/9/27.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "BannerMode.h"
#import "NewsMode.h"

@interface InforMode : BaseMode
@property (nonatomic, copy)NSString *isFirstPage;
@property (nonatomic, copy)NSString *isLastPage;
@property (nonatomic, copy)NSString *preUrl;
@property (nonatomic, copy)NSString *nextUrl;
@property (nonatomic, copy)NSString *maxTime;
@property (nonatomic, copy)NSString *newsMsgNum;
@property (nonatomic, copy)NSString *contIds;

@property (nonatomic, strong)NSArray *banners;
@property (nonatomic, strong)NSArray *newsList;
@end
