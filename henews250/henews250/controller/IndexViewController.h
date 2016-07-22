//
//  IndexViewController.h
//  henews250
//
//  Created by 汪洋 on 16/7/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "GuidePage3.h"
#import "LoadingMode.h"

@interface IndexViewController : BaseViewController<EnterAppDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *launchImage;
@property (weak, nonatomic) IBOutlet UIView *scrollBgView;
@property (weak, nonatomic) IBOutlet UIScrollView *guideScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *guiPageControl;
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet UIImageView *adImage;
@property (weak, nonatomic) IBOutlet UILabel *secLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adImageDistanceBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secBgWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *jumpLabelTop;

@property (strong, nonatomic) LoadingMode *loadingMode;
@end
