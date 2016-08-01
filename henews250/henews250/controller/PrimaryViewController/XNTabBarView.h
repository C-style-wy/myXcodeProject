//
//  XNTabBarView.h
//  henews250
//
//  Created by 汪洋 on 16/7/7.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MacroDefinition.h"
#import "XNTabBarButton.h"

@protocol TabBarBtnDelegate <NSObject>

@optional
- (void)tabBarBtnSelectAgain;

@end

@interface XNTabBarView : UITabBarController

@property(nonatomic, retain) XNTabBarButton *homeBtn;
@property(nonatomic, retain) XNTabBarButton *newsBtn;
@property(nonatomic, retain) XNTabBarButton *viewPointBtn;
@property(nonatomic, retain) XNTabBarButton *welfareBtn;

@property(nonatomic, assign) id<TabBarBtnDelegate> homeDelegate;
@property(nonatomic, assign) id<TabBarBtnDelegate> newsDelegate;
@property(nonatomic, assign) id<TabBarBtnDelegate> viewPointDelegate;
@property(nonatomic, assign) id<TabBarBtnDelegate> welfareDelegate;

@property(nonatomic, retain) UIView *tabBarView;

- (void)closeMenu;
- (void)openMenu;
@end
