//
//  UIScrollView+MYExtension.m
//  henews250
//
//  Created by 汪洋 on 16/10/8.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "UIScrollView+MYExtension.h"

@implementation UIScrollView (MYExtension)

- (void)setMy_insetT:(CGFloat)my_insetT {
    UIEdgeInsets inset = self.contentInset;
    inset.top = my_insetT;
    self.contentInset = inset;
}

- (CGFloat)my_insetT {
    return self.contentInset.top;
}

- (void)setMy_insetB:(CGFloat)my_insetB {
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = my_insetB;
    self.contentInset = inset;
}

- (CGFloat)my_insetB {
    return self.contentInset.bottom;
}

- (void)setMy_insetL:(CGFloat)my_insetL {
    UIEdgeInsets inset = self.contentInset;
    inset.left = my_insetL;
    self.contentInset = inset;
}

- (CGFloat)my_insetL {
    return self.contentInset.left;
}

- (void)setMy_insetR:(CGFloat)my_insetR {
    UIEdgeInsets inset = self.contentInset;
    inset.right = my_insetR;
    self.contentInset = inset;
}

- (CGFloat)my_insetR {
    return self.contentInset.right;
}

- (void)setMy_offsetX:(CGFloat)my_offsetX {
    CGPoint offset = self.contentOffset;
    offset.x = my_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)my_offsetX {
    return self.contentOffset.x;
}

- (void)setMy_offsetY:(CGFloat)my_offsetY {
    CGPoint offset = self.contentOffset;
    offset.y = my_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)my_offsetY {
    return self.contentOffset.y;
}

- (void)setMy_contentW:(CGFloat)my_contentW {
    CGSize size = self.contentSize;
    size.width = my_contentW;
    self.contentSize = size;
}

- (CGFloat)my_contentW {
    return self.contentSize.width;
}

- (void)setMy_contentH:(CGFloat)my_contentH {
    CGSize size = self.contentSize;
    size.height = my_contentH;
    self.contentSize = size;
}

- (CGFloat)my_contentH {
    return self.contentSize.height;
}
@end
