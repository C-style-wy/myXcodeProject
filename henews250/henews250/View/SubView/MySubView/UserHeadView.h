//
//  UserHeadView.h
//  henews250
//
//  Created by 汪洋 on 16/9/28.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LoadFromNib.h"
@class MyViewController;

@interface UserHeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (nonatomic, weak) MyViewController *controller;

@end
