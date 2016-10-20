//
//  MYLoadingAnimation.h
//  henews250
//
//  Created by 汪洋 on 2016/10/20.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYLoadingAnimation : UIView

@property(strong, nonatomic) UIView *centerCir;
@property(strong, nonatomic) UIView *leftCir;
@property(strong, nonatomic) UIView *rightCir;
@property(strong, nonatomic) NSTimer *timer;

@end
