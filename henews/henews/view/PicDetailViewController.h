//
//  PicDetailViewController.h
//  henews
//
//  Created by 汪洋 on 15/11/30.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Request.h"
#import "APIStringMacros.h"
#import "picDetailData.h"
#import "UIImageView+AFNetworking.h"

@interface PicDetailViewController : UIViewController<detailViewDelege>

@property (nonatomic, retain) NSMutableArray *imagesAry;
@property (nonatomic, retain) UIScrollView *imagesScrollView;

@property (nonatomic, retain) UIActivityIndicatorView *loading;
@end
