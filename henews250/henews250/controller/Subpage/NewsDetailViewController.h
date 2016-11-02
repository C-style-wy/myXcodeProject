//
//  NewsDetailViewController.h
//  henews250
//
//  Created by 汪洋 on 16/9/7.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SubBaseViewController.h"
#import "NewsDetailMode.h"

@interface NewsDetailViewController : SubBaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NewsDetailMode *newsDetailData;
@property (nonatomic, retain) NSMutableArray *pageData;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *caoTieLabel;

@property (nonatomic, retain) UITableView *tableView;

@end
