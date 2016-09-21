//
//  NewsViewController.h
//  henews250
//
//  Created by 汪洋 on 16/7/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseViewController.h"
#import "XNTabBarView.h"


@interface NewsViewController : BaseViewController<TabBarBtnDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *classScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *addImage;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;


@property (nonatomic, retain) UITableView *firstTableView;
@property (nonatomic, retain) UITableView *middleTableView;
@property (nonatomic, retain) UITableView *lastTableView;

@property (nonatomic, assign) NSInteger curClass;

@end
