//
//  DetailViewController.h
//  henews
//
//  Created by 汪洋 on 15/10/19.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "APIStringMacros.h"
#import "NewsTitleCellData.h"
#import "NewsTitleCell.h"

#import "NewsShareCell.h"
#import "NewsShareCellData.h"

#import "NewsContentCell.h"
#import "NewsContentCellData.h"

#import "NewsPicCell.h"
#import "NewsPicCellData.h"

#import "NewsLinkCell.h"
#import "NewsLinkCellData.h"

#import "NewsVoteCellMode.h"
#import "NewsVoteCell.h"

#import "relateNewsCell.h"

#import "CellData.h"
#import "OneSmallPicCell.h"
#import "OnlyTitleCell.h"

#import "HeadInDetail.h"
#import "BottomToolBarInDetail.h"
#import "ShareMode.h"

@interface DetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, HeadInDetailDelegate, BottomToolBarInDetailDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIActivityIndicatorView *loading;
@property (nonatomic, retain) BottomToolBarInDetail *toolBar;

@property (nonatomic, retain) NSMutableArray *tableViewData;
@property (nonatomic, retain) NSString *detailUrl;

@end
