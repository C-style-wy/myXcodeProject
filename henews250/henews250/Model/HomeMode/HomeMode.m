//
//  HomeMode.m
//  henews250
//
//  Created by 汪洋 on 16/7/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "HomeMode.h"

@implementation HomeMode

MJCodingImplementation

+ (NSDictionary*)objectClassInArray {
    return @{
             @"banners":@"BannerMode",
             @"nodes":@"NodeMode",
             };
}
@end
