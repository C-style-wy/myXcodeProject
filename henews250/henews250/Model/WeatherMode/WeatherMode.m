//
//  WeatherMode.m
//  henews250
//
//  Created by 汪洋 on 16/9/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "WeatherMode.h"

@implementation WeatherMode

+ (NSDictionary*)objectClassInArray {
    return @{
             @"forecast":@"WeatherItemMode",
             @"zhishus":@"ZhishuMode",
             };
}

@end
