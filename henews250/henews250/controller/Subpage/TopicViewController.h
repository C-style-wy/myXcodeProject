//
//  TopicViewController.h
//  henews250
//
//  Created by 汪洋 on 16/9/19.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SubBaseViewController.h"
#import "TopicModel.h"
#import "TopicTitleModel.h"
#import "TopicTitleCell.h"
#import "TopicSectionView.h"
#import "NewsCellFactory.h"

@interface TopicViewController : SubBaseViewController<UITableViewDelegate, UITableViewDataSource, TopicSectionViewDelegate>

@property (nonatomic, retain) NSMutableArray *pageData;
@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) TopicModel *topicModel;

@end
