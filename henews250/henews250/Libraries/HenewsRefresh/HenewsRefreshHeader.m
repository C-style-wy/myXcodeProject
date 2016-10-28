//
//  HenewsRefreshHeader.m
//  henews250
//
//  Created by 汪洋 on 2016/10/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "HenewsRefreshHeader.h"
#import "UIColor+hexColor.h"

@interface HenewsRefreshHeader () {
    __unsafe_unretained UIImageView *_arrowView;
}
@property (weak, nonatomic) UIImageView *loadingView;
@end

@implementation HenewsRefreshHeader

#pragma mark - 懒加载
- (UIImageView *)arrowView {
    if (!_arrowView) {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refreshArrow"]];
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}

- (UIImageView *)loadingView {
    if (!_loadingView) {
        UIImageView *loadingView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 4)];
        NSMutableArray *idleImages = [NSMutableArray array];
        for (NSUInteger i = 1; i<=3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refreshAnimationImage%zd", i]];
            [idleImages addObject:image];
        }
        loadingView.animationImages = idleImages;
        loadingView.animationDuration = 0.5;
        [self addSubview:_loadingView = loadingView];
        
    }
    return _loadingView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc]init];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.font = [UIFont systemFontOfSize:13.5f];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.backgroundColor = [UIColor colorWithHexColor:@"#e20776"];
        _tipLabel.alpha = 1.0f;
        [self addSubview:_tipLabel];
    }
    return _tipLabel;
}
#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    // 初始化文字
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    
    self.lastUpdatedTimeLabel.font = [UIFont boldSystemFontOfSize:11];
    self.lastUpdatedTimeLabel.textColor = [UIColor colorWithHexColor:@"#969696"];
    self.stateLabel.font = [UIFont boldSystemFontOfSize:11];
    self.stateLabel.textColor = [UIColor colorWithHexColor:@"#969696"];
}

- (void)placeSubviews
{
    [super placeSubviews];
    self.stateLabel.center = self.lastUpdatedTimeLabel.center;
    
//    self.lastUpdatedTimeLabel.hidden = YES;
    // 箭头的中心点
    CGFloat arrowCenterX = self.mj_w * 0.5;
    CGFloat arrowCenterY = (self.mj_h - self.lastUpdatedTimeLabel.mj_h + 10) * 0.5;
    
    
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 箭头
    if (self.arrowView.constraints.count == 0) {
        self.arrowView.mj_size = self.arrowView.image.size;
        self.arrowView.center = arrowCenter;
    }
    
    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = CGPointMake(arrowCenterX, arrowCenterY+3);
    }
    
    self.arrowView.tintColor = self.stateLabel.textColor;
    
    self.tipLabel.frame = CGRectMake(0, MJRefreshHeaderHeight-MJRefreshTipHeight, self.frame.size.width, MJRefreshTipHeight);
    self.tipLabel.hidden = YES;
//    self.tipLabel.transform = CGAffineTransformMakeScale(0.5, 0.5);
}

- (void)tipAction {
    [super tipAction];
    self.tipLabel.hidden = NO;
    self.tipLabel.alpha = 0;
    self.tipLabel.text = self.refreshTip;

    [UIView animateWithDuration:0.2f animations:^{
//        self.tipLabel.transform = CGAffineTransformMakeScale(0.99, 0.99);
        self.tipLabel.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0f animations:^{
            self.tipLabel.alpha = 0.99f;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2f animations:^{
                self.scrollView.mj_insetT += -MJRefreshTipHeight;
            } completion:^(BOOL finished) {
                self.tipLabel.alpha = 0;
                self.refreshTip = @"";
            }];
        }];
    }];
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            self.arrowView.transform = CGAffineTransformIdentity;
            
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                self.arrowView.hidden = NO;
            }];
        } else {
            [self.loadingView stopAnimating];
            self.arrowView.hidden = NO;
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformIdentity;
            }];
        }
        //
        self.stateLabel.alpha = 1.0;
        self.lastUpdatedTimeLabel.alpha = 0.0;
    } else if (state == MJRefreshStatePulling) {
        [self.loadingView stopAnimating];
        self.arrowView.hidden = NO;
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
        //
        self.stateLabel.alpha = 1.0;
        self.lastUpdatedTimeLabel.alpha = 0.0;
    } else if (state == MJRefreshStateRefreshing) {
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.loadingView startAnimating];
        self.arrowView.hidden = YES;
        //
        self.stateLabel.alpha = 0.0;
        self.lastUpdatedTimeLabel.alpha = 1.0;
    }
}
#pragma mark - 日历获取在9.x之后的系统使用currentCalendar会出异常。在8.0之后使用系统新API。
- (NSCalendar *)currentCalendar {
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return [NSCalendar currentCalendar];
}

#pragma mark key的处理
- (void)setLastUpdatedTimeKey:(NSString *)lastUpdatedTimeKey
{
    [super setLastUpdatedTimeKey:lastUpdatedTimeKey];
    
    // 如果label隐藏了，就不用再处理
    if (self.lastUpdatedTimeLabel.hidden) return;
    
    NSDate *lastUpdatedTime = [[NSUserDefaults standardUserDefaults] objectForKey:lastUpdatedTimeKey];
    
    // 如果有block
    if (self.lastUpdatedTimeText) {
        self.lastUpdatedTimeLabel.text = self.lastUpdatedTimeText(lastUpdatedTime);
        return;
    }
    
    if (lastUpdatedTime) {
        // 1.获得年月日
        NSCalendar *calendar = [self currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
        NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:lastUpdatedTime];
        NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        
        // 2.格式化日期
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSString *showUpdatedString;
        if ([cmp1 month] == [cmp2 month]) {
            if ([cmp1 day] == [cmp2 day]) {
                if ([cmp1 hour] == [cmp2 hour]) {
                    if ([cmp2 minute] - [cmp1 minute] > 2) {
                        showUpdatedString = [[NSString stringWithFormat:@"%d", (int)([cmp2 minute] - [cmp1 minute])] stringByAppendingString:@"分钟前更新"];
                    }else {
                        showUpdatedString = @"刚刚";
                    }
                }else{
                    showUpdatedString = [[NSString stringWithFormat: @"%d", (int)([cmp2 hour] - [cmp1 hour])] stringByAppendingString:@"小时前更新"];
                }
            }else{
                showUpdatedString = [[NSString stringWithFormat: @"%d", (int)([cmp2 day] - [cmp1 day])] stringByAppendingString:@"天前更新"];
            }
            
        } else {
            formatter.dateFormat = @"yyyy-MM-dd";
            showUpdatedString = [[formatter stringFromDate:lastUpdatedTime] stringByAppendingString:@"更新"];
        }
        // 3.显示日期
        self.lastUpdatedTimeLabel.text = showUpdatedString;
    } else {
        self.lastUpdatedTimeLabel.text = @"正在刷新";
    }
}
@end
