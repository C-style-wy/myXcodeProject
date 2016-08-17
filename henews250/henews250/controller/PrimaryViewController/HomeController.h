//
//  HomeController.h
//  henews250
//
//  Created by 汪洋 on 16/7/7.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "HomeMode.h"
#import "SectionView.h"
#import "XNTabBarView.h"
#import "ChangeDataMode.h"
#import "TierManageView.h"

@interface HomeController : BaseViewController<UITableViewDelegate, UITableViewDataSource, SectionDelegate, TabBarBtnDelegate, TierManageViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;

@property (weak, nonatomic) IBOutlet UIButton *setBtn;
@property (weak, nonatomic) IBOutlet UILabel *cityName;

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *tableViewData;

@property (strong, nonatomic) HomeMode *homeMode;
@property (strong, nonatomic) ChangeDataMode *changeData;

@property (nonatomic, retain) NSString *city;
@end
