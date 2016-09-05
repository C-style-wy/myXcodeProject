//
//  YesterdayMode.h
//  henews250
//
//  Created by 汪洋 on 16/9/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "YesterdayDayMode.h"

@interface YesterdayMode : BaseMode

@property (nonatomic, copy)NSString *date_1;
@property (nonatomic, copy)NSString *high_1;
@property (nonatomic, copy)NSString *low_1;


@property (strong, nonatomic) YesterdayDayMode *day_1;
@property (strong, nonatomic) YesterdayDayMode *night_1;

@end
