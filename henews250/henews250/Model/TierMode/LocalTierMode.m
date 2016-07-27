//
//  LocalTierMode.m
//  henews250
//
//  Created by 汪洋 on 16/7/26.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "LocalTierMode.h"

@implementation LocalTierMode

- (id)init {
    self = [super init];
    if (self) {
        self.orderTier = [[NSMutableArray alloc]init];
        [self.orderTier removeAllObjects];
        self.notOrderTier = [[NSMutableArray alloc]init];
        [self.notOrderTier removeAllObjects];
    }
    return self;
}

@end
