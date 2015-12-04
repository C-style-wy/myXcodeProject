//
//  AdviceData.m
//  henews
//
//  Created by 汪洋 on 15/12/2.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "AdviceData.h"

@implementation AdviceData

-(id)init{
    self = [super init];
    if (self) {
        _pic = @"";
        _startTime = @"";
        _endTime = @"";
        _displayTime = @"";
    }
    return self;
}

-(void)initWithData:(NSString*)pic start:(NSString*)sTime end:(NSString*)eTime showTime:(NSString*)time{
    _pic = pic;
    _startTime = sTime;
    _endTime = eTime;
    _displayTime = time;
}


@end
