//
//  NewsTitleCell.h
//  henews
//
//  Created by 汪洋 on 15/11/11.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsTitleCellData.h"

@interface NewsTitleCell : UITableViewCell

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *timeLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)loadTableCell:(NewsTitleCellData*)data;

@end
