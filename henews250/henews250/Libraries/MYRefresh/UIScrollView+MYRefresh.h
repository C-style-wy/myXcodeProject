//
//  UIScrollView+MYRefresh.h
//  henews250
//
//  Created by 汪洋 on 16/10/8.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYRefreshConst.h"

@class MYRefreshHeader, MYRefreshFooter;

@interface UIScrollView (MYRefresh)
/** 下拉刷新控件 */
@property (strong, nonatomic) MYRefreshHeader *my_header;
@property (strong, nonatomic) MYRefreshHeader *header MYRefreshDeprecated("使用my_header");

/** 上拉刷新控件 */
@property (strong, nonatomic) MYRefreshFooter *my_footer;
@property (strong, nonatomic) MYRefreshFooter *footer MYRefreshDeprecated("使用my_footer");

#pragma mark - other
- (NSInteger)my_totalDataCount;
@property (copy, nonatomic) void (^my_reloadDataBlock)(NSInteger totalDataCount);
@end
