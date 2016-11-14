//
//  DetailPicAndContentCell.h
//  henews250
//
//  Created by 汪洋 on 2016/11/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseCell.h"
#import "DetailPicAndContentFrame.h"
#import "SHLUILabel.h"

@interface DetailPicAndContentCell : BaseCell

@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) SHLUILabel *contentText;

@property (nonatomic, retain) DetailPicAndContentFrame *detailPicAndContentFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (instancetype)cellWithTableView:(UITableView *)tableView indexpath:(NSIndexPath*)indexPath;

@end
