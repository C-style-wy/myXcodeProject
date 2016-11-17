//
//  SpotMode.m
//  henews250
//
//  Created by 汪洋 on 2016/11/4.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SpotMode.h"

@implementation SpotMode

- (id)init {
    self = [super init];
    if (self) {
        self.goodTimes = @"0";
        self.badTimes = @"0";
        self.contentVoteUrl = @"";
    }
    return self;
}

@end
