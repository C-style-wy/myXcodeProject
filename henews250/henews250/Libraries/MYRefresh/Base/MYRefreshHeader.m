//
//  MYRefreshHeader.m
//  henews250
//
//  Created by 汪洋 on 16/10/8.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "MYRefreshHeader.h"

@interface MYRefreshHeader ()
@property (assign, nonatomic) CGFloat insetTDelta;
@end

@implementation MYRefreshHeader
#pragma mark - 构造方法
+ (instancetype)headerWithRefreshingBlock:(MYRefreshComponentRefreshingBlock)refreshingBlock {
    MYRefreshHeader *cmp = [[self alloc] init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    MYRefreshHeader *cmp = [[self alloc] init];
    [cmp setRefreshingTarget:target refreshingAction:action];
    return cmp;
}

#pragma mark - 覆盖父类的方法
- (void)prepare {
    [super prepare];
    
    // 设置key
    self.lastUpdatedTimeKey = MYRefreshHeaderLastUpdatedTimeKey;
    
    // 设置高度
    self.my_h = MYRefreshHeaderHeight;
}

- (void)placeSubviews {
    [super placeSubviews];
    
    // 设置y值(当自己的高度发生改变了，肯定要重新调整Y值，所以放在placeSubviews方法中设置y值)
    self.my_y = - self.my_h - self.ignoredScrollViewContentInsetTop;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    // 在刷新的refreshing状态
    if (self.state == MYRefreshStateRefreshing) {
        if (self.window == nil) return;
        
        // sectionheader停留解决
        CGFloat insetT = - self.scrollView.my_offsetY > _scrollViewOriginalInset.top ?
        - self.scrollView.my_offsetY : _scrollViewOriginalInset.top;
        insetT = insetT > self.my_h + _scrollViewOriginalInset.top ? self.my_h + _scrollViewOriginalInset.top : insetT;
        self.scrollView.my_insetT = insetT;
        
        self.insetTDelta = _scrollViewOriginalInset.top - insetT;
        return;
    }
    
    // 跳转到下一个控制器时，contentInset可能会变
    _scrollViewOriginalInset = self.scrollView.contentInset;
    
    // 当前的contentOffset
    CGFloat offsetY = self.scrollView.my_offsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    
    // 如果是向上滚动到看不见头部控件，直接返回
    // >= -> >
    if (offsetY > happenOffsetY) return;
    // 普通和即将刷新的临界点
    CGFloat normal2pullingOffsetY = happenOffsetY - self.my_h;
    CGFloat pullingPercent = (happenOffsetY - offsetY) / self.my_h;
    
    if (self.scrollView.isDragging) { // 如果正在拖拽
        self.pullingPercent = pullingPercent;
        if (self.state == MYRefreshStateIdle && offsetY < normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = MYRefreshStatePulling;
        }else if (self.state == MYRefreshStatePulling && offsetY >= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = MYRefreshStateIdle;
        }
    } else if (self.state == MYRefreshStatePulling) { // 即将刷新 && 手松开
        // 开始刷新
        [self beginRefreshing];
    } else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
}

- (void)setState:(MYRefreshState)state {
    MYRefreshCheckState
    
    // 根据状态做事情
    if (state == MYRefreshStateIdle) {
        if (oldState != MYRefreshStateRefreshing) return;
        
        // 保存刷新时间
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 恢复inset和offset
        [UIView animateWithDuration:MYRefreshSlowAnimationDuration animations:^{
            self.scrollView.my_insetT += self.insetTDelta;
            
            // 自动调整透明度
            if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.pullingPercent = 0.0;
            if (self.endRefreshingCompletionBlock) {
                self.endRefreshingCompletionBlock();
            }
        }];
    } else if (state == MYRefreshStateRefreshing) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:MYRefreshFastAnimationDuration animations:^{
                CGFloat top = self.scrollViewOriginalInset.top + self.my_h;
                // 增加滚动区域top
                self.scrollView.my_insetT = top;
                // 设置滚动位置
                [self.scrollView setContentOffset:CGPointMake(0, -top) animated:NO];
            } completion:^(BOOL finished) {
                [self executeRefreshingCallback];
            }];
        });
    }
}

#pragma mark - 公共方法
- (void)endRefreshing {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.state = MYRefreshStateIdle;
    });
}

- (NSDate *)lastUpdatedTime {
    return [[NSUserDefaults standardUserDefaults] objectForKey:self.lastUpdatedTimeKey];
}
@end
