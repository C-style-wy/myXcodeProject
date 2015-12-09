//
//  ViewPointViewController.h
//  henews
//
//  Created by 汪洋 on 15/10/23.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIStringMacros.h"
#import "Request.h"
#import "MJRefresh.h"
#import "ClassDataStru.h"
#import "CellData.h"
#import "BannersData.h"
#import "BannersCell.h"
#import "ChannelManageView.h"

@interface ViewPointViewController : UIViewController<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, ChannelManageViewDelegate, BannersDelegate>

@property (nonatomic, retain) UIScrollView *scrollView;

@property (nonatomic, retain) NSMutableArray *columAry;

@property (nonatomic, retain) UIScrollView *mainScrollView;

@property (nonatomic, retain) UIView *mainView;
@property (nonatomic, retain) UILabel *preClassLabel;

@property (nonatomic, assign) NSInteger curClass;

@property (nonatomic, retain) UITableView *firstTableView;
@property (nonatomic, retain) UITableView *middleTableView;
@property (nonatomic, retain) UITableView *lastTableView;

//栏目管理view
@property (nonatomic, retain) ChannelManageView *channelView;
@property (nonatomic, retain) UIImageView *addChannelImage;

@property (nonatomic, retain) NSMutableArray *classAry;

@property (nonatomic, retain)id<detailViewDelege> delegate;

@end

