//
//  SubBaseViewController.h
//  henews250
//
//  Created by 汪洋 on 16/8/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseViewController.h"
#import "SubPageHeadView.h"

@interface SubBaseViewController : BaseViewController<SubPageHeadViewDelegate>

@property (nonatomic, retain) SubPageHeadView *headView;

@property (nonatomic, retain) UILabel *pageTitle;
@property (nonatomic, retain) UIButton *pageShareBtn;
@end
