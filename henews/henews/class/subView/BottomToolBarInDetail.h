//
//  BottomToolBarInDetail.h
//  henews
//
//  Created by 汪洋 on 16/3/15.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIStringMacros.h"

@class BottomToolBarInDetail;

@protocol BottomToolBarInDetailDelegate <NSObject>

@optional
- (void)toolBar:(BottomToolBarInDetail*)tool commentButton:(UIButton *)button;

- (void)toolBar:(BottomToolBarInDetail*)tool commentNumButton:(UIButton *)button;

- (void)toolBar:(BottomToolBarInDetail*)tool fontSizeButton:(UIButton *)button;

- (void)toolBar:(BottomToolBarInDetail*)tool shareButton:(UIButton *)button;

@end

@interface BottomToolBarInDetail : UIView

@property (nonatomic, assign) id<BottomToolBarInDetailDelegate>delegate;

- (void)openToolBar;

- (void)closeToolBar;

- (void)moveDownToolBar:(CGFloat) distance;

- (void)moveUpToolBar:(CGFloat) distance;

@end
