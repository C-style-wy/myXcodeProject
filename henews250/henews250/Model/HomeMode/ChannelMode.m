//
//  ChannelMode.m
//  henews250
//
//  Created by 汪洋 on 16/7/25.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "ChannelMode.h"

@implementation ChannelMode

MJCodingImplementation

+ (NSDictionary*)objectClassInArray {
    return @{
             @"banners":@"BannerMode",
             @"newsList":@"NewsMode",
             };
}

@end
