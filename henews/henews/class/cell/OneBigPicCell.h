//
//  OneBigPicCell.h
//  henews
//
//  Created by 汪洋 on 15/11/10.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellData.h"

@interface OneBigPicCell : UITableViewCell
@property (nonatomic, retain) UIImageView *cellPic;
@property (nonatomic, retain) UILabel *cellName;
@property (nonatomic, retain) UILabel *pubTime;
@property (nonatomic, retain) UILabel *pv;

@property (nonatomic, retain) UIImageView *busIcon;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)loadTableCell:(id)data;
@end
