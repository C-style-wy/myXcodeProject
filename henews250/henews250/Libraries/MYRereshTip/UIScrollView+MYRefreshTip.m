//
//  UIScrollView+MYRefreshTip.m
//  henews250
//
//  Created by 汪洋 on 2016/10/23.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "UIScrollView+MYRefreshTip.h"
#import <objc/runtime.h>

@implementation UIScrollView (MYRefreshTip)

#pragma mark - tip
static const char MYRefreshTipKey = '\0';
- (void)setMy_tip:(MYRefreshTip *)my_tip {
    if (my_tip != self.my_tip) {
        // 删除旧的，添加新的
        [self.my_tip removeFromSuperview];
        [self insertSubview:my_tip atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"my_tip"];
        objc_setAssociatedObject(self, &MYRefreshTipKey, my_tip, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"my_tip"];
    }
}

- (MYRefreshTip *)my_tip {
    return objc_getAssociatedObject(self, &MYRefreshTipKey);
}

@end
