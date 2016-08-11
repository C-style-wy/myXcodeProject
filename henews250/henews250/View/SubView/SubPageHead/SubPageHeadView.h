//
//  SubPageHeadView.h
//  henews250
//
//  Created by 汪洋 on 16/8/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LoadFromNib.h"

@protocol SubPageHeadViewDelegate <NSObject>

@optional
- (void)pageBackBtnSelect;
- (void)pageShareBtnSelect;

@end

@interface SubPageHeadView : UIView
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (nonatomic, assign) id<SubPageHeadViewDelegate> delegate;
@end
