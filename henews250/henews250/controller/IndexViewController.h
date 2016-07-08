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

@interface IndexViewController : BaseViewController<EnterAppDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *launchImage;
@property (weak, nonatomic) IBOutlet UIView *scrollBgView;
@property (weak, nonatomic) IBOutlet UIScrollView *guideScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *guiPageControl;

@end
