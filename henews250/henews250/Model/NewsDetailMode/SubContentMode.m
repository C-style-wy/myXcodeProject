//
//  SubContentMode.m
//  henews250
//
//  Created by 汪洋 on 2016/11/1.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SubContentMode.h"

@implementation SubContentMode

+ (NSDictionary*)objectClassInArray {
    return @{
             @"imageInfoList":@"ImageInfoMode",
             };
}

- (void)handleContent {
    if (self.content && ![self.content isEqualToString:@""]) {
        self.content = [self.content stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        self.content = [self.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
//        self.content = [self.content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//        self.content = [self.content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
}

@end
