//
//  NewsVoteCellMode.m
//  henews
//
//  Created by 汪洋 on 16/3/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NewsVoteCellMode.h"

@implementation NewsVoteCellMode

- (id)init{
    self = [super init];
    if (self) {
        self.voteUrl = @"";
        self.goodTimes = @"";
        self.badTimes = @"";
        self.height = 92.0f;
    }
    return self;
}

- (void)initWithData:(NSString*)url goodTimes:(NSString *)good badTimes:(NSString *)bad{
    self.voteUrl = url;
    self.goodTimes = good;
    self.badTimes = bad;
}

@end
