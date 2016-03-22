//
//  NewsVoteCell.h
//  henews
//
//  Created by 汪洋 on 16/3/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsVoteCellMode.h"
#import "APIStringMacros.h"
#import "Request.h"

@interface NewsVoteCell : UITableViewCell

@property (nonatomic, retain)UILabel *zanNumLabel;
@property (nonatomic, retain)UILabel *caiNumLabel;
@property (nonatomic, retain)NewsVoteCellMode *data;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)loadTableCell:(NewsVoteCellMode*)data;

@end
