//
//  NewsNumberTip.m
//  henews
//
//  Created by 汪洋 on 16/4/2.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NewsNumberTip.h"
#import "APIStringMacros.h"

@implementation NewsNumberTip{
    NSTimer *_timer;
}

+ (void)showWithTipDesc:(NSString *)desc superView:(UIView*)view showX:(float)x showY:(float)y{
    NewsNumberTip *tip = [[self alloc]initWithFrame:CGRectMake(x, y, SCREEN_WIDTH, 22.0f)];
    tip.backgroundColor = [ROSERED colorWithAlphaComponent:0.8];
    tip.clipsToBounds = YES;
    [view addSubview:tip];
    [tip contentViewWithDesc:desc];
}

- (void)contentViewWithDesc:(NSString*)desc{
    UILabel *descLabel = [[UILabel alloc]initWithFrame:self.bounds];
    descLabel.textColor = [UIColor whiteColor];
    descLabel.font = [UIFont systemFontOfSize:13.0f];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.text = desc;
    [self addSubview:descLabel];
    
    self.alpha = 0;
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeGo) userInfo:nil repeats:NO];
    }];
}

- (void)timeGo{
    [self closeView];
    if (_timer) {
        [_timer invalidate];
        _timer=nil;
    }
}

-(void)closeView{
    [UIView animateWithDuration:0.4f animations:^{
        self.alpha = 0;
//        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
