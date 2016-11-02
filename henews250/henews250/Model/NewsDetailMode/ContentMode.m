//
//  ContentMode.m
//  henews250
//
//  Created by 汪洋 on 2016/11/1.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "ContentMode.h"

@implementation ContentMode

+ (NSDictionary*)objectClassInArray {
    return @{
             @"content":@"SubContentMode",
             @"videos":@"VideosMode",
             @"images":@"ImagesMode",
             };
}

@end
