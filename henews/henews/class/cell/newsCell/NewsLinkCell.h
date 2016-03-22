//
//  NewsLinkCell.h
//  henews
//
//  Created by 汪洋 on 16/3/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsLinkCellData.h"

@interface NewsLinkCell : UITableViewCell

@property (nonatomic, retain) NewsLinkCellData *data;
@property (nonatomic, retain) UIViewController *controller;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)loadTableCell:(NewsLinkCellData*)data controller:(UIViewController *)view;

@end
