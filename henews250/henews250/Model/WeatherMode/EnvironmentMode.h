//
//  EnvironmentMode.h
//  henews250
//
//  Created by 汪洋 on 16/9/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"

@interface EnvironmentMode : BaseMode

@property (nonatomic, copy)NSString *aqi;
@property (nonatomic, copy)NSString *pm25;
@property (nonatomic, copy)NSString *suggest;
@property (nonatomic, copy)NSString *quality;
@property (nonatomic, copy)NSString *MajorPollutants;
@property (nonatomic, copy)NSString *o3;
@property (nonatomic, copy)NSString *co;
@property (nonatomic, copy)NSString *pm10;
@property (nonatomic, copy)NSString *so2;
@property (nonatomic, copy)NSString *no2;
@property (nonatomic, copy)NSString *time;

@end
