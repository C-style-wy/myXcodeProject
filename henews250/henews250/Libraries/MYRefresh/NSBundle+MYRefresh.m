//
//  NSBundle+MYRefresh.m
//  henews250
//
//  Created by 汪洋 on 16/10/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NSBundle+MYRefresh.h"
#import "MYRefreshComponent.h"

@implementation NSBundle (MYRefresh)
+ (instancetype)my_refreshBundle {
    static NSBundle *refreshBundle = nil;
    if (refreshBundle == nil) {
        refreshBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[MYRefreshComponent class]]pathForResource:@"MYRefresh" ofType:@"bundle"]];
    }
    return refreshBundle;
}
+ (UIImage *)my_arrowImage {
    static UIImage *arrowImage = nil;
    if (arrowImage == nil) {
        arrowImage = [[UIImage imageWithContentsOfFile:[[self my_refreshBundle]pathForResource:@"arrow@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return arrowImage;
}
+ (NSString *)my_localizedStringForKey:(NSString *)key value:(NSString *)value {
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language hasPrefix:@"en"]) {
            language = @"en";
        }else if ([language hasPrefix:@"zh"]) {
            if ([language rangeOfString:@"Hans"].location != NSNotFound) {
                language = @"zh-Hans";// 简体中文
            } else {
                language = @"zh-Hant"; // 繁體中文
            }
        } else {
            language = @"en";
        }
        
        bundle = [NSBundle bundleWithPath:[[NSBundle my_refreshBundle] pathForResource:language ofType:@"lproj"]];
    }
    value = [bundle localizedStringForKey:key value:value table:nil];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}
+ (NSString *)my_localizedStringForKey:(NSString *)key {
    return [self my_localizedStringForKey:key value:nil];
}


@end
