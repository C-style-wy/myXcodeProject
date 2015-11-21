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
@property (nonatomic, retain) UIImageView *line;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)loadTableCell:(CellData*)data isShortLine:(BOOL)isShort isWhiteBg:(BOOL)isWhite isHideLine:(BOOL)hide;

@end
