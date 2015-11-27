//
//  LoadingView.m
//  henews
//
//  Created by 汪洋 on 15/11/27.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView


-(id)initWithParent:(UIViewController*)parent{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        UIImageView *loadingImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-35)/2, (SCREEN_HEIGHT-35)/2, 35, 35)];
        loadingImage.image = [UIImage imageNamed:@"loading.png"];
        [self addSubview:loadingImage];
        _loadingImage = loadingImage;
        _parent = parent;
    }
    return self;
}

-(void)loadingShow{
    [_parent.view addSubview:self];
    [self addAnimation];
}

-(void)addAnimation{
    //加按钮的旋转动画
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    theAnimation.duration=0.8f;
    theAnimation.removedOnCompletion = NO;
    theAnimation.delegate = self;
    theAnimation.fromValue = [NSNumber numberWithFloat:0];
    theAnimation.toValue = [NSNumber numberWithFloat:2*PI];
    [_loadingImage.layer addAnimation:theAnimation forKey:@"animateTransform"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self addAnimation];
}

@end
