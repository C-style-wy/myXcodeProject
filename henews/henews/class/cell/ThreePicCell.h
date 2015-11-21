//
//  ThreePicCell.h
//  henews
//
//  Created by 汪洋 on 15/11/10.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellData.h"

@interface ThreePicCell : UITableViewCell

@property (nonatomic, retain) UIImageView *cellPic1;
@property (nonatomic, retain) UIImageView *cellPic2;
@property (nonatomic, retain) UIImageView *cellPic3;
@property (nonatomic, retain) UILabel *cellName;
@property (nonatomic, retain) UILabel *pubTime;
@property (nonatomic, retain) UILabel *pv;

@property (nonatomic, retain) UIImageView *line;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)loadTableCell:(CellData*)data isShortLine:(BOOL)isShort isWhiteBg:(BOOL)isWhite isHideLine:(BOOL)hide;

@end
