//
//  TierManageMode.m
//  henews250
//
//  Created by 汪洋 on 16/7/26.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TierManageMode.h"

@implementation TierManageMode

+ (void)compareAndSave:(NSArray*)serverData key:(NSString*)key {
    LocalTierMode *tiers = [[LocalTierMode alloc]init];
    for (int i = 0; i < serverData.count; i++) {
        TierMode *mode = [[TierMode alloc] initWithData:[serverData objectAtIndex:i]];
        if (![mode.isMore isEqualToString:@""]) {
            if ([mode.isMore isEqualToString:@"1"]) {
                [tiers.notOrderTier addObject:mode];
            }else{
                [tiers.orderTier addObject:mode];
            }
        }
    }
    [[self class]saveData:tiers Key:key];
}

+ (LocalTierMode*)readLocadTier:(NSString*)key {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:key];
    LocalTierMode *mode = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return mode;
}

+ (void)saveData:(LocalTierMode*)mode Key:(NSString*)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //变为NSData类型
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mode];
    [userDefaults setObject:data forKey:key];
    [userDefaults synchronize];
}


@end
