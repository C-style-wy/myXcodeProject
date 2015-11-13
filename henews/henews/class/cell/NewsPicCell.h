//
//  NewsPicCell.h
//  henews
//
//  Created by 汪洋 on 15/11/11.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsPicCellData.h"

@interface NewsPicCell : UITableViewCell

@property (nonatomic, retain) UIImageView *pic;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)loadTableCell:(NewsPicCellData*)data;

@end
