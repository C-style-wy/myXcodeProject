//
//  PlayLoading.h
//  henews
//
//  Created by 汪洋 on 16/3/29.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayLoading : UIView

+ (void)loadingShow:(UIView *)supView;

+ (void)loadingShow:(UIView *)supView below:(UIView *)view;

+ (void)loadingHide:(UIView *)supView;

+ (BOOL)loadingIsShow:(UIView *)supView;

- (instancetype)initWithFrame:(CGRect)frame;

@end
