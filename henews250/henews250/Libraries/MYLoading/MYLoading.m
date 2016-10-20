//
//  MYLoading.m
//  henews250
//
//  Created by 汪洋 on 2016/10/20.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "MYLoading.h"
#import "MYLoadingAnimation.h"

@implementation MYLoading

+ (MYLoading *)sharedInstance {
    static MYLoading *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[MYLoading alloc] init];
        MYLoadingAnimation *animation = [[MYLoadingAnimation alloc]init];
        [handler.overlayView addSubview:animation];
        [handler.overlayView setUserInteractionEnabled:NO];
    });
    return handler;
}

+ (void)show {
    [[self sharedInstance] showLoading];
}

+ (void)dismiss {
    [[self sharedInstance] dismissLoading];
}

- (void)showLoading {
    [self.overlayView removeFromSuperview];
    [[self lastWindow] addSubview:self.overlayView];
    self.overlayView.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.overlayView.alpha = 1;
    }];
}

- (void)dismissLoading {
    [self.overlayView removeFromSuperview];
}

- (UIControl*)overlayView {
    if(!_overlayView) {
        _overlayView = [[UIControl alloc] init];
        _overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayView.backgroundColor = [UIColor clearColor];
    }
    // Update frame
    _overlayView.frame = [self lastWindow].bounds;
    return _overlayView;
}

- (UIWindow *)lastWindow {
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal && window.windowLevel <= UIWindowLevelNormal);
        
        if(windowOnMainScreen && windowIsVisible && windowLevelSupported) {
            return window;
        }
    }
    
    return [UIApplication sharedApplication].keyWindow;
}

@end
