//
//  PlayLoading.m
//  henews
//
//  Created by 汪洋 on 16/3/29.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "PlayLoading.h"

@implementation PlayLoading

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = frame;
        
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loadingIcon.png"]];
        image.frame = CGRectMake(0, 0, 20, 20);
        [self addSubview:image];
        
        image.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = 0.8;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 9999999;
        [image.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
        self.tag = 135;
    }
    return self;
}

+ (void)loadingShow:(UIView *)supView{
    [supView addSubview:[[[self class] alloc]initWithFrame:supView.bounds]];
}

+ (void)loadingShow:(UIView *)supView below:(UIView *)view{
//    [supView addSubview:[[[self class] alloc]initWithFrame:supView.bounds] ];
    [supView insertSubview:[[[self class] alloc]initWithFrame:supView.bounds] belowSubview:view];
}

+ (void)loadingHide:(UIView *)supView{
    UIView *loading = (UIView *)[supView viewWithTag:135];
    if (loading) {
        [loading removeFromSuperview];
    }
}

+ (BOOL)loadingIsShow:(UIView *)supView{
    UIView *loading = (UIView *)[supView viewWithTag:135];
    if (loading) {
        return YES;
    }
    return NO;
}

@end
