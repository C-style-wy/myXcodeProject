//
//  LoadingView.h
//  henews
//
//  Created by 汪洋 on 15/11/27.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIStringMacros.h"

@interface LoadingView : UIView


@property (nonatomic, retain) UIViewController* parent;
@property (nonatomic, retain) UIImageView *loadingImage;

-(id)initWithParent:(UIViewController*)parent;

-(void)loadingShow;

@end
