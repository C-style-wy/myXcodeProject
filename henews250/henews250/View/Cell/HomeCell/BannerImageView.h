//
//  BannerImageView.h
//  henews250
//
//  Created by 汪洋 on 16/7/22.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LoadFromNib.h"
#import "BannerMode.h"
#import "UIImageView+LoadFromWeb.h"

@interface BannerImageView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *image;

- (id)initWithData:(BannerMode *)banner;

@end
