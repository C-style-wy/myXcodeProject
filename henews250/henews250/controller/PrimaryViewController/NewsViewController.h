//
//  NewsViewController.h
//  henews250
//
//  Created by 汪洋 on 16/7/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseViewController.h"
#import "XNTabBarView.h"
#import "ClassInfoMode.h"
#import "InforMode.h"
#import "TierManageView.h"


@interface NewsViewController : BaseViewController<TabBarBtnDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, TierManageViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *classScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *addImage;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;


@property (nonatomic, retain) UITableView *firstTableView;
@property (nonatomic, retain) UITableView *middleTableView;
@property (nonatomic, retain) UITableView *lastTableView;

@property (nonatomic, assign) NSInteger curClass;
@property (nonatomic, retain) UILabel *preClassLabel;

//我的栏目
@property (nonatomic, retain) NSMutableArray *orderAry;

//栏目信息、位置、是否需要刷新等
@property (nonatomic, retain) NSMutableArray *classInfoAry;

@end
