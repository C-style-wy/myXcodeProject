//
//  ChannelManageView.m
//  henews
//
//  Created by 汪洋 on 15/11/19.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "ChannelManageView.h"

@implementation ChannelManageView

//重写initWithFrame
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 0)];
        _mainView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.98f];
        [self addSubview:_mainView];
        
//        UIView *testView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _mainView.frame.size.width, frame.size.height)];
//        
//        testView.backgroundColor = [UIColor yellowColor];
//        [_mainView addSubview:testView];
    }
    return self;
}

- (void)openChannel{
    [UIView animateWithDuration:0.5f animations:^{
        [_mainView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }];
}

-(void)closeChannel{
    [UIView animateWithDuration:0.5f animations:^{
        [_mainView setFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
    }];
}

@end
