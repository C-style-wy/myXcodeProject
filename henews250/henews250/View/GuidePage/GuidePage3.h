//
//  GuidePage3.h
//  henews250
//
//  Created by 汪洋 on 16/7/7.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LoadFromNib.h"

@protocol EnterAppDelegate <NSObject>

@required
- (void)enterAppBtnSelect;

@end

@interface GuidePage3 : UIView
@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@property (nonatomic, assign) id<EnterAppDelegate>delegate;
@end
