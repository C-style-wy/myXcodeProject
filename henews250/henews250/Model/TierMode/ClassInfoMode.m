//
//  ClassInfoMode.m
//  henews250
//
//  Created by 汪洋 on 16/9/27.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "ClassInfoMode.h"

@implementation ClassInfoMode

- (id)init {
    self = [super init];
    if (self) {
        self.tier = [[TierMode alloc]init];
        self.curPosition = 0.0f;
        self.loadData = [[NSMutableArray alloc]init];
        self.loadingMoreUrl = @"";
        self.needReflush = YES;
        self.isLastPage = YES;
    }
    return self;
}

@end
