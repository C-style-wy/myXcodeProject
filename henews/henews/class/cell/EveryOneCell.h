//
//  EveryOneCell.h
//  henews
//
//  Created by 汪洋 on 15/11/10.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellData.h"

@interface EveryOneCell : UITableViewCell

@property (nonatomic, retain) UIImageView *cellPic;
@property (nonatomic, retain) UILabel *cellName;
@property (nonatomic, retain) UILabel *cellSummary;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)loadTableCell:(id)data;

@end
