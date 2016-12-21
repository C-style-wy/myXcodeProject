//
//  CommentListViewController.h
//  henews250
//
//  Created by 汪洋 on 2016/11/14.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SubBaseViewController.h"
#import "CommentListMode.h"

@interface CommentListViewController : SubBaseViewController

@property (nonatomic, retain) NSString *commentUrl;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) CommentListMode *commentList;

@end
