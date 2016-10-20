//
//  MYLoading.h
//  henews250
//
//  Created by 汪洋 on 2016/10/20.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYLoading : UIView

@property (nonatomic, strong) UIControl *overlayView;
//返回单例
+ (MYLoading *)sharedInstance;
+ (void)show;

+ (void)dismiss;
@end
