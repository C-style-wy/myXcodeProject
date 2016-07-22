//
//  NewsMode.m
//  henews250
//
//  Created by 汪洋 on 16/7/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NewsMode.h"

@implementation NewsMode

MJCodingImplementation

+ (NSDictionary*)objectClassInArray {
    return @{
             @"images":@"ImageMode",
             @"newsTags":@"TagMode",
             };
}

@end
