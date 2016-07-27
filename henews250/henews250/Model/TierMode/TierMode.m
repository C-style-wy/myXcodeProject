//
//  TierMode.m
//  henews250
//
//  Created by 汪洋 on 16/7/26.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TierMode.h"

@implementation TierMode

-(void)setData:(id)data {
    _nodeId = [data objectForKey:@"nodeId"];
    _nodeName = [data objectForKey:@"nodeName"];
    _isMore = [data objectForKey:@"isMore"];
    _flag = [data objectForKey:@"flag"];
    _isHot = [data objectForKey:@"isHot"];
    _isCity = [data objectForKey:@"isCity"];
    _showAllTime = [data objectForKey:@"showAllTime"];
    _url = [data objectForKey:@"url"];
}

- (id)initWithData:(id)data {
    self = [super init];
    if (self) {
        [self setData:data];
    }
    return self;
}
@end
