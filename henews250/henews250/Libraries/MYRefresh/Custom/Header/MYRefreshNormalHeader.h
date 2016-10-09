//
//  MYRefreshNormalHeader.h
//  henews250
//
//  Created by 汪洋 on 2016/10/9.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "MYRefreshStateHeader.h"

@interface MYRefreshNormalHeader : MYRefreshStateHeader
@property (weak, nonatomic, readonly) UIImageView *arrowView;
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
@end
