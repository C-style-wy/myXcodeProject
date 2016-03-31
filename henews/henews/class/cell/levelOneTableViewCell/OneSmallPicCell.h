//
//  OneSmallPicCell.h
//  henews
//
//  Created by 汪洋 on 15/11/2.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CellData;

@interface OneSmallPicCell : UITableViewCell

@property (nonatomic, retain) UIImageView *cellPic;
@property (nonatomic, retain) UILabel *cellName;
@property (nonatomic, retain) UILabel *summary;

@property (nonatomic, retain) UILabel *pubTime;
@property (nonatomic, retain) UILabel *pv;
@property (nonatomic, retain) UIImageView *line;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)loadTableCell:(CellData*)data isShortLine:(BOOL)isShort isWhiteBg:(BOOL)isWhite isHideLine:(BOOL)hide;
@end
