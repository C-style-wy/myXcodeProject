//
//  UIScrollView+MYExtension.h
//  henews250
//
//  Created by 汪洋 on 16/10/8.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (MYExtension)
@property (assign, nonatomic) CGFloat my_insetT;
@property (assign, nonatomic) CGFloat my_insetB;
@property (assign, nonatomic) CGFloat my_insetL;
@property (assign, nonatomic) CGFloat my_insetR;

@property (assign, nonatomic) CGFloat my_offsetX;
@property (assign, nonatomic) CGFloat my_offsetY;

@property (assign, nonatomic) CGFloat my_contentW;
@property (assign, nonatomic) CGFloat my_contentH;
@end
