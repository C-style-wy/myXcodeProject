//
//  HeadInPicDetail.h
//  henews
//
//  Created by 汪洋 on 16/3/22.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIStringMacros.h"

@class HeadInPicDetail;

@protocol HeadInPicDetailDelegate <NSObject>

@optional

- (void)headInPicDetail:(HeadInPicDetail*)head backButton:(UIButton *)button;

- (void)headInPicDetail:(HeadInPicDetail*)head commentNumButton:(UIButton *)button;

- (void)headInPicDetail:(HeadInPicDetail*)head moreButton:(UIButton *)button;

@end

@interface HeadInPicDetail : UIView

@property (nonatomic, assign) id<HeadInPicDetailDelegate>delegate;

@end
