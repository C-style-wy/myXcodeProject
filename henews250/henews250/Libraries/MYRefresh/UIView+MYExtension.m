//
//  UIView+MYExtension.m
//  henews250
//
//  Created by 汪洋 on 16/10/8.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "UIView+MYExtension.h"

@implementation UIView (MYExtension)
- (void)setMy_x:(CGFloat)my_x {
    CGRect frame = self.frame;
    frame.origin.x = my_x;
    self.frame = frame;
}

- (CGFloat)my_x {
    return self.frame.origin.x;
}

- (void)setMy_y:(CGFloat)my_y {
    CGRect frame = self.frame;
    frame.origin.y = my_y;
    self.frame = frame;
}

- (CGFloat)my_y {
    return self.frame.origin.y;
}

- (void)setMy_w:(CGFloat)my_w{
    CGRect frame = self.frame;
    frame.size.width = my_w;
    self.frame = frame;
}

- (CGFloat)my_w {
    return self.frame.size.width;
}

- (void)setMy_h:(CGFloat)my_h {
    CGRect frame = self.frame;
    frame.size.height = my_h;
    self.frame = frame;
}

- (CGFloat)my_h {
    return self.frame.size.height;
}

- (void)setMy_size:(CGSize)my_size {
    CGRect frame = self.frame;
    frame.size = my_size;
    self.frame = frame;
}

- (CGSize)my_size {
    return self.frame.size;
}

- (void)setMy_origin:(CGPoint)my_origin {
    CGRect frame = self.frame;
    frame.origin = my_origin;
    self.frame = frame;
}

- (CGPoint)my_origin {
    return self.frame.origin;
}

@end
