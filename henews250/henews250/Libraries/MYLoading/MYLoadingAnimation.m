//
//  MYLoadingAnimation.m
//  henews250
//
//  Created by 汪洋 on 2016/10/20.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "MYLoadingAnimation.h"

#define Radius 12
#define DefalutColor [UIColor orangeColor]
static CGFloat const duration = 0.4f;

@implementation MYLoadingAnimation

- (void)willMoveToSuperview:(UIView *)newSuperview {
    self.backgroundColor = [UIColor clearColor];
    self.frame = newSuperview.frame;
    [self addThreeCir];
    [self timer];
}

- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3*duration target:self selector:@selector(firstAnimation) userInfo:nil repeats:YES];
        [_timer fire];
    }
    return _timer;
}

- (void)addThreeCir
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120.0f, 60.0f)];
    view.backgroundColor = [UIColor lightGrayColor];
    view.layer.cornerRadius = Radius * 0.5;
    view.layer.masksToBounds = YES;
    view.alpha = 0.9;
    [self addSubview:view];
    view.center = self.center;
    
    UIView * centerCir = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Radius, Radius)];
    centerCir.center = self.center;
    centerCir.layer.cornerRadius = Radius * 0.5;
    centerCir.layer.masksToBounds = YES;
    centerCir.backgroundColor = DefalutColor;
    [self addSubview:centerCir];
    self.centerCir = centerCir;
    
    CGPoint centerPoint = centerCir.center;
    
    UIView * leftCir = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Radius, Radius)];
    CGPoint leftCenter = leftCir.center;
    leftCenter.x = centerPoint.x - Radius;
    leftCenter.y = centerPoint.y;
    leftCir.center = leftCenter;
    leftCir.layer.cornerRadius = Radius * 0.5;
    leftCir.layer.masksToBounds = YES;
    leftCir.backgroundColor = DefalutColor;
    [self addSubview:leftCir];
    self.leftCir = leftCir;
    
    UIView * rightCir = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Radius, Radius)];
    CGPoint rightCenter = rightCir.center;
    rightCenter.x = centerPoint.x + Radius;
    rightCenter.y = centerPoint.y;
    rightCir.center = rightCenter;
    rightCir.layer.cornerRadius = Radius * 0.5;
    rightCir.layer.masksToBounds = YES;
    rightCir.backgroundColor = DefalutColor;
    [self addSubview:rightCir];
    self.rightCir = rightCir;
    
}

- (void)firstAnimation
{
    [UIView animateWithDuration:duration animations:^{
        
        self.leftCir.transform = CGAffineTransformMakeTranslation(-Radius, 0);
        self.leftCir.transform = CGAffineTransformScale(self.leftCir.transform, 0.75, 0.75);
        self.rightCir.transform = CGAffineTransformMakeTranslation(Radius, 0);
        self.rightCir.transform = CGAffineTransformScale(self.rightCir.transform, 0.75, 0.75);
        self.centerCir.transform = CGAffineTransformScale(self.centerCir.transform, 0.75, 0.75);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            self.leftCir.transform = CGAffineTransformIdentity;
            self.rightCir.transform = CGAffineTransformIdentity;
            self.centerCir.transform = CGAffineTransformIdentity;
            [self secondAnimation];
        }];}];
    
}

- (void)secondAnimation
{
    UIBezierPath * leftCirPath = [UIBezierPath bezierPath];
    [leftCirPath addArcWithCenter:self.center radius:Radius startAngle:M_PI endAngle:2 * M_PI + 2 * M_PI clockwise:NO];
    
    CAKeyframeAnimation * leftCirAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    leftCirAnimation.path = leftCirPath.CGPath;
    leftCirAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    leftCirAnimation.fillMode = kCAFillModeForwards;
    leftCirAnimation.removedOnCompletion = YES;
    leftCirAnimation.repeatCount = 2;
    leftCirAnimation.duration = duration;
    
    [self.leftCir.layer addAnimation:leftCirAnimation forKey:@"cc"];
    
    UIBezierPath * rightCirPath = [UIBezierPath bezierPath];
    [rightCirPath addArcWithCenter:self.center radius:Radius startAngle:0 endAngle:M_PI + 2 * M_PI clockwise:NO];
    CAKeyframeAnimation * rightCirAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    rightCirAnimation.path = rightCirPath.CGPath;
    rightCirAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rightCirAnimation.fillMode = kCAFillModeForwards;
    rightCirAnimation.removedOnCompletion = YES;
    rightCirAnimation.repeatCount = 2;
    rightCirAnimation.duration = duration;
    
    [self.rightCir.layer addAnimation:rightCirAnimation forKey:@"hh"];
}

@end
