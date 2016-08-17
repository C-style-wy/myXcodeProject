//
//  CityManager.m
//  henews250
//
//  Created by 汪洋 on 16/8/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "CityManager.h"

#define CityKey (@"city")
@implementation CityManager

+ (id)shareInstance{
    static id helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults objectForKey:CityKey]) {
            helper = [userDefaults objectForKey:CityKey];
            helper = [NSKeyedUnarchiver unarchiveObjectWithData:helper];
        }else {
            helper = [[CityMode alloc]init];
        }
    });
    return helper;
}

@end
