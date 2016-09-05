//
//  WeatherMode.h
//  henews250
//
//  Created by 汪洋 on 16/9/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "EnvironmentMode.h"
#import "YesterdayMode.h"
#import "ForecastMode.h"
#import "ZhishusMode.h"
#import "WeatherItemMode.h"

@interface WeatherMode : BaseMode

@property (nonatomic, copy)NSString *city;
@property (nonatomic, copy)NSString *updatetime;
@property (nonatomic, copy)NSString *wendu;
@property (nonatomic, copy)NSString *fengli;
@property (nonatomic, copy)NSString *shidu;
@property (nonatomic, copy)NSString *fengxiang;
@property (nonatomic, copy)NSString *sunrise_1;
@property (nonatomic, copy)NSString *sunset_1;
@property (nonatomic, copy)NSString *sunrise_2;
@property (nonatomic, copy)NSString *sunset_2;

@property (strong, nonatomic) EnvironmentMode *environment;
@property (strong, nonatomic) YesterdayMode *yesterday;
@property (strong, nonatomic) ForecastMode *forecast;
@property (strong, nonatomic) ZhishusMode *zhishus;

@end
