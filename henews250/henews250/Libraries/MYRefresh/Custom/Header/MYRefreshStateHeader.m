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
@end
