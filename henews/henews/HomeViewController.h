//
//  HomeViewController.h
//  henews
//
//  Created by 汪洋 on 15/10/19.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIStringMacros.h"
#import "ModulData.h"
#import "OneSmallPicCell.h"
#import "OnlyTitleCell.h"
#import "OneBigPicCell.h"
#import "EveryOneCell.h"
#import "ThreePicCell.h"

@interface HomeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *tableViewData;

@property (nonatomic, retain)id<detailViewDelege> delegate;
@end
