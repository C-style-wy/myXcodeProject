//
//  PageHead.h
//  henews
//
//  Created by 汪洋 on 16/3/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PageHead;

@protocol PageHeadDelegate <NSObject>

@optional
- (void)pageHead:(PageHead*)head backButton:(UIButton *)button;

- (void)pageHead:(PageHead*)head shareButton:(UIButton *)button;

@end

@interface PageHead : UIView

@property (nonatomic, assign) id<PageHeadDelegate>delegate;
@property (nonatomic, retain) UILabel *pageTitle;
@property (nonatomic, retain) UIButton *shareButton;

@end
