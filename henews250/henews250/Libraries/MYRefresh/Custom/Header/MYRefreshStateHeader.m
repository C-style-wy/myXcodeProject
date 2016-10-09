//
//  MYRefreshStateHeader.m
//  henews250
//
//  Created by 汪洋 on 16/10/8.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "MYRefreshStateHeader.h"

@interface MYRefreshStateHeader()
{
    /** 显示上一次刷新时间的label */
    __unsafe_unretained UILabel *_lastUpdatedTimeLabel;
    /** 显示刷新状态的label */
    __unsafe_unretained UILabel *_stateLabel;
}
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@end

@implementation MYRefreshStateHeader
#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles {
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel my_label]];
    }
    return _stateLabel;
}

- (UILabel *)lastUpdatedTimeLabel {
    if (!_lastUpdatedTimeLabel) {
        [self addSubview:_lastUpdatedTimeLabel = [UILabel my_label]];
    }
    return _lastUpdatedTimeLabel;
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(MYRefreshState)state {
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

#pragma mark - 日历获取在9.x之后的系统使用currentCalendar会出异常。在8.0之后使用系统新API。
- (NSCalendar *)currentCalendar {
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return [NSCalendar currentCalendar];
}

#pragma mark key的处理
- (void)setLastUpdatedTimeKey:(NSString *)lastUpdatedTimeKey {
    [super setLastUpdatedTimeKey:lastUpdatedTimeKey];
    
    //如果label隐藏了，就不用再处理
    if (self.lastUpdatedTimeLabel.hidden) return;
    
    NSDate *lastUpdatedTime = [[NSUserDefaults standardUserDefaults] objectForKey:lastUpdatedTimeKey];
    
    //如果有block
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
        BOOL isToday = NO;
        if ([cmp1 day] == [cmp2 day]) { // 今天
            formatter.dateFormat = @" HH:mm";
            isToday = YES;
        } else if ([cmp1 year] == [cmp2 year]) { // 今年
            formatter.dateFormat = @"MM-dd HH:mm";
        } else {
            formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        }
        NSString *time = [formatter stringFromDate:lastUpdatedTime];
        
        // 3.显示日期
        self.lastUpdatedTimeLabel.text = [NSString stringWithFormat:@"%@%@%@",
                                          [NSBundle my_localizedStringForKey:MYRefreshHeaderLastTimeText],
                                          isToday ? [NSBundle my_localizedStringForKey:MYRefreshHeaderDateTodayText] : @"",
                                          time];
    } else {
        self.lastUpdatedTimeLabel.text = [NSString stringWithFormat:@"%@%@",
                                          [NSBundle my_localizedStringForKey:MYRefreshHeaderLastTimeText],
                                          [NSBundle my_localizedStringForKey:MYRefreshHeaderNoneLastDateText]];
    }
}

#pragma mark - 覆盖父类的方法
- (void)prepare {
    [super prepare];
    
    // 初始化间距
    self.labelLeftInset = MYRefreshLabelLeftInset;
    
    // 初始化文字
    [self setTitle:[NSBundle my_localizedStringForKey:MYRefreshHeaderIdleText] forState:MYRefreshStateIdle];
    [self setTitle:[NSBundle my_localizedStringForKey:MYRefreshHeaderPullingText] forState:MYRefreshStatePulling];
    [self setTitle:[NSBundle my_localizedStringForKey:MYRefreshHeaderRefreshingText] forState:MYRefreshStateRefreshing];
}

- (void)placeSubviews {
    [super placeSubviews];
    
    if (self.stateLabel.hidden) return;
    
    BOOL noConstrainsOnStatusLabel = self.stateLabel.constraints.count == 0;
    
    if (self.lastUpdatedTimeLabel.hidden) {
        // 状态
        if (noConstrainsOnStatusLabel) self.stateLabel.frame = self.bounds;
    } else {
        CGFloat stateLabelH = self.my_h * 0.5;
        //状态
        if (noConstrainsOnStatusLabel) {
            self.stateLabel.my_x = 0;
            self.stateLabel.my_y = 0;
            self.stateLabel.my_w = self.my_w;
            self.stateLabel.my_h = stateLabelH;
        }
        
        //更新时间
        if (self.lastUpdatedTimeLabel.constraints.count == 0) {
            self.lastUpdatedTimeLabel.my_x = 0;
            self.lastUpdatedTimeLabel.my_y = stateLabelH;
            self.lastUpdatedTimeLabel.my_w = self.my_w;
            self.lastUpdatedTimeLabel.my_h = self.my_h - self.lastUpdatedTimeLabel.my_y;
        }
    }
}

- (void)setState:(MYRefreshState)state {
    MYRefreshCheckState
    
    // 设置状态文字
    self.stateLabel.text = self.stateTitles[@(state)];
    
    // 重新设置key（重新显示时间）
    self.lastUpdatedTimeKey = self.lastUpdatedTimeKey;
}
@end










