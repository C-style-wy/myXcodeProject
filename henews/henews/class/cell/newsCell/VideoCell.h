//
//  VideoCell.h
//  henews
//
//  Created by 汪洋 on 16/3/24.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellData.h"

@interface VideoCell : UITableViewCell
@property (nonatomic, retain) UIImageView *cellPic;
@property (nonatomic, retain) UILabel *cellName;
@property (nonatomic, retain) UILabel *pubTime;
@property (nonatomic, retain) UILabel *pv;

@property (nonatomic, retain) UIImageView *busIcon;

@property (nonatomic, retain) UIImageView *line;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)loadTableCell:(CellData*)data isShortLine:(BOOL)isShort isWhiteBg:(BOOL)isWhite isHideLine:(BOOL)hide;
@end
