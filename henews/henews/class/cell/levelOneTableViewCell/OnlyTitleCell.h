//
//  OnlyTitleCell.h
//  henews
//
//  Created by 汪洋 on 15/11/3.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellData.h"

@interface OnlyTitleCell : UITableViewCell

@property (nonatomic, weak) UILabel *cellName;
@property (nonatomic, weak) UILabel *cellSummary;
@property (nonatomic, weak) UILabel *pubTime;
@property (nonatomic, weak) UILabel *pv;

@property (nonatomic, retain) UIImageView *line;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)loadTableCell:(CellData*)data isShortLine:(BOOL)isShort isWhiteBg:(BOOL)isWhite isHideLine:(BOOL)hide;
@end
