//
//  NewsDetailMode.m
//  henews250
//
//  Created by 汪洋 on 2016/11/1.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NewsDetailMode.h"

@implementation NewsDetailMode

+ (NSDictionary*)objectClassInArray {
    return @{
             @"relateConts":@"NewsMode",
             @"readContentArray":@"ReadContentArrayMode",
             };
}

@end