//
//  ChangeDataMode.m
//  henews250
//
//  Created by 汪洋 on 16/7/25.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "ChangeDataMode.h"

@implementation ChangeDataMode

MJCodingImplementation


+ (NSDictionary*)objectClassInArray {
    return @{
             @"banners":@"BannerMode",
             @"newsList":@"NewsMode",
             @"channelNav":@"ChannelMode",
             };
}
@end
