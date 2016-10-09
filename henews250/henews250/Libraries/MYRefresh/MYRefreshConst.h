//
//  MYRefreshConst.h
//  henews250
//
//  Created by 汪洋 on 16/10/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/message.h>

// 弱引用
#define MYWeakSelf __weak typeof(self) weakSelf = self;

// 日志输出
#ifdef DEBUG
#define MYRefreshLog(...) NSLog(__VA_ARGS__)
#else
#define MYRefreshLog(...)
#endif

// 过期提醒
#define MYRefreshDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// 运行时objc_msgSend
#define MYRefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define MYRefreshMsgTarget(target) (__bridge void *)(target)

// RGB颜色
#define MYRefreshColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 文字颜色
#define MYRefreshLabelTextColor MYRefreshColor(90, 90, 90)

// 字体大小
#define MYRefreshLabelFont [UIFont boldSystemFontOfSize:14]

// 常量
UIKIT_EXTERN const CGFloat MYRefreshLabelLeftInset;
UIKIT_EXTERN const CGFloat MYRefreshHeaderHeight;
UIKIT_EXTERN const CGFloat MYRefreshFooterHeight;
UIKIT_EXTERN const CGFloat MYRefreshFastAnimationDuration;
UIKIT_EXTERN const CGFloat MYRefreshSlowAnimationDuration;

UIKIT_EXTERN NSString *const MYRefreshKeyPathContentOffset;
UIKIT_EXTERN NSString *const MYRefreshKeyPathContentInset;
UIKIT_EXTERN NSString *const MYRefreshKeyPathContentSize;
UIKIT_EXTERN NSString *const MYRefreshKeyPathPanState;

UIKIT_EXTERN NSString *const MYRefreshHeaderLastUpdatedTimeKey;

// 检查状态
#define MYRefreshCheckState \
MYRefreshState oldState = self.state; \
if (state == oldState) return; \
[super setState:state];



