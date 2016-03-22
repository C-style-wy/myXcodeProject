//
//  HeadInDetail.h
//  henews
//
//  Created by 汪洋 on 16/3/15.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeadInDetail;

@protocol HeadInDetailDelegate <NSObject>

@optional
- (void)headInDetail:(HeadInDetail*)head backButton:(UIButton *)button;

- (void)headInDetail:(HeadInDetail*)head collectionButton:(UIButton *)button;

- (void)headInDetail:(HeadInDetail*)head modeButton:(UIButton *)button isNight:(BOOL) night;

@end

@interface HeadInDetail : UIView

@property (nonatomic, assign) id<HeadInDetailDelegate>delegate;
@property (nonatomic, retain) UIButton *collectionBtn;

@end
