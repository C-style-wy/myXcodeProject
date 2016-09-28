//
//  MyViewController.h
//  henews250
//
//  Created by 汪洋 on 16/7/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseViewController.h"
#import "UserHeadView.h"
#import "MyListView.h"

@interface MyViewController : BaseViewController<UIScrollViewDelegate>

@property (nonatomic, retain) UserHeadView *userHeadView;

@end
