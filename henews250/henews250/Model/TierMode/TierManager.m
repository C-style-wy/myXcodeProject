//
//  TierManager.m
//  henews250
//
//  Created by 汪洋 on 16/9/20.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TierManager.h"
#import "MD5.h"

@implementation TierManager

+ (TierManager*)shareInstance {
    static TierManager *tierManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tierManager = [[self alloc] init];
    });
    return tierManager;
}

- (void)compareAndSave:(NSArray*)serverData key:(NSString*)key {
    LocalTierMode *tiers = [self readLocadTier:key];
    if (tiers) {
        for (int i = 0; i < serverData.count; i++) {
            TierMode *mode = [[TierMode alloc] initWithData:[serverData objectAtIndex:i]];
            if ([self tierInLocal:mode localTiers:tiers]) {
                tiers = [self replaceItem:mode localTiers:tiers];
            }else{
                if (mode.nodeName && ![mode.nodeName isEqualToString:@""]) {
                    if (![mode.isMore isEqualToString:@""]) {
                        if ([mode.isMore isEqualToString:@"1"]) {
                            [tiers.notOrderTier addObject:mode];
                        }else{
                            [tiers.orderTier addObject:mode];
                        }
                    }
                }
            }
        }
    }else{
        tiers = [[LocalTierMode alloc]init];
        for (int i = 0; i < serverData.count; i++) {
            TierMode *mode = [[TierMode alloc] initWithData:[serverData objectAtIndex:i]];
            if (mode.nodeName && ![mode.nodeName isEqualToString:@""]) {
                if (![mode.isMore isEqualToString:@""]) {
                    if ([mode.isMore isEqualToString:@"1"]) {
                        [tiers.notOrderTier addObject:mode];
                    }else{
                        [tiers.orderTier addObject:mode];
                    }
                }
            }
        }
    }
    [self saveData:tiers Key:key];
}

- (LocalTierMode*)readLocadTier:(NSString*)key {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:[self encodeKey:key]];
    LocalTierMode *mode = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return mode;
}

- (void)saveData:(LocalTierMode*)mode Key:(NSString*)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //变为NSData类型
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mode];
    [userDefaults setObject:data forKey:[self encodeKey:key]];
    [userDefaults synchronize];
}

//读取订阅栏目
- (NSMutableArray*)getOrderTierFromLocal:(NSString*)key {
    LocalTierMode *localTierMode = [self readLocadTier:key];
    return localTierMode.orderTier;
}

//读取非订阅栏目
- (NSMutableArray*)getNotOrderTierFromLocal:(NSString*)key {
    LocalTierMode *localTierMode = [self readLocadTier:key];
    return localTierMode.notOrderTier;
}

//保存订阅栏目到本地
- (void)saveOrderTierToLocal:(NSMutableArray*)orderTier Key:(NSString*)key {
    LocalTierMode *localTierMode = [self readLocadTier:key];
    localTierMode.orderTier = orderTier;
    [self saveData:localTierMode Key:key];
}

//保存非订阅栏目到本地
- (void)saveNotOrderTierToLocal:(NSMutableArray*)notOrderTier Key:(NSString*)key {
    LocalTierMode *localTierMode = [self readLocadTier:key];
    localTierMode.notOrderTier = notOrderTier;
    [self saveData:localTierMode Key:key];
}

//保存订阅和非订阅栏目到本地
- (void)saveOrderTierToLocal:(NSMutableArray*)orderTier notOrderTier:(NSMutableArray*)notOrderTier Key:(NSString*)key {
    LocalTierMode *localTierMode = [[LocalTierMode alloc] init];
    localTierMode.orderTier = orderTier;
    localTierMode.notOrderTier = notOrderTier;
    [self saveData:localTierMode Key:key];
}

- (NSString*)encodeKey:(NSString*)keyStr {
    return [MD5 encoding:[keyStr stringByAppendingString:[[CityManager shareInstance] getCity]]];
}

- (BOOL)tierInLocal:(TierMode*)tier localTiers:(LocalTierMode*)localTiers {
    BOOL have = NO;
    NSMutableArray *orders = localTiers.orderTier;
    for (TierMode *orderTier in orders) {
        if ([orderTier.nodeId isEqualToString:tier.nodeId]) {
            have = YES;
            return have;
        }
    }
    if (!have) {
        NSMutableArray *notOrders = localTiers.notOrderTier;
        for (TierMode *notOrderTier in notOrders) {
            if ([notOrderTier.nodeId isEqualToString:tier.nodeId]) {
                have = YES;
                return have;
            }
        }
    }
    return have;
}

- (BOOL)tierInLocal:(TierMode*)tier key:(NSString*)key{
    BOOL have = NO;
    LocalTierMode *localTiers = [self readLocadTier:key];
    NSMutableArray *orders = localTiers.orderTier;
    for (TierMode *orderTier in orders) {
        if ([orderTier.nodeId isEqualToString:tier.nodeId]) {
            have = YES;
            return have;
        }
    }
    if (!have) {
        NSMutableArray *notOrders = localTiers.notOrderTier;
        for (TierMode *notOrderTier in notOrders) {
            if ([notOrderTier.nodeId isEqualToString:tier.nodeId]) {
                have = YES;
                return have;
            }
        }
    }
    return have;
}

- (LocalTierMode*)replaceItem:(TierMode*)tier localTiers:(LocalTierMode*)localTiers {
    BOOL notHaveReplace = true;
    for (int i = 0; i < localTiers.orderTier.count; i++) {
        TierMode *orderTier = [localTiers.orderTier objectAtIndex:i];
        if ([orderTier.nodeId isEqualToString:tier.nodeId]) {
            [localTiers.orderTier replaceObjectAtIndex:i withObject:tier];
            notHaveReplace = false;
            return localTiers;
        }
    }
    if (notHaveReplace) {
        for (int i = 0; i < localTiers.notOrderTier.count; i++) {
            TierMode *notOrderTier = [localTiers.notOrderTier objectAtIndex:i];
            if ([notOrderTier.nodeId isEqualToString:tier.nodeId]) {
                [localTiers.notOrderTier replaceObjectAtIndex:i withObject:tier];
                notHaveReplace = false;
                return localTiers;
            }
        }
    }
    return localTiers;
}

@end
