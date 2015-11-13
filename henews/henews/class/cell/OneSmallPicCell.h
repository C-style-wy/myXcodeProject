//
//  OneSmallPicCell.h
//  henews
//
//  Created by 汪洋 on 15/11/2.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellData.h"

@interface OneSmallPicCell : UITableViewCell

@property (nonatomic, weak) UIImageView *cellPic;
@property (nonatomic, weak) UILabel *cellName;
@property (nonatomic, weak) UILabel *pubTime;
@property (nonatomic, weak) UILabel *pv;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)loadTableCell:(id)data;
@end
