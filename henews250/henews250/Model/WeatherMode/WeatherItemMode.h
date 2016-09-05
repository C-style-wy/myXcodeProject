//
//  WeatherItemMode.h
//  henews250
//
//  Created by 汪洋 on 16/9/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "DayMode.h"

@interface WeatherItemMode : BaseMode

@property (nonatomic, copy)NSString *date;
@property (nonatomic, copy)NSString *high;
@property (nonatomic, copy)NSString *low;


@property (strong, nonatomic) DayMode *day;
@property (strong, nonatomic) DayMode *night;
@end
