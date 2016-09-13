//
//  UIView+SetAllSubViewHidden.m
//  henews250
//
//  Created by 汪洋 on 16/7/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "UIView+SetAllSubViewHidden.h"

@implementation UIView (SetAllSubViewHidden)

- (void)setAllHidden:(BOOL)hidden{
    [self setHidden:hidden];
    for (UIView *view in [self subviews]) {
        [view setAllHidden:hidden];
    }
}

- (void)removeAllSubView {
//    [self removeAllSubViewHidden];
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
}

@end
