//
//  NewsTitleCell.h
//  henews250
//
//  Created by 汪洋 on 2016/11/7.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsTitleFrame.h"

@interface NewsTitleCell : UITableViewCell

@property (nonatomic, retain) SHLUILabel *title;
@property (nonatomic, retain) UILabel *source;
@property (nonatomic, retain) UILabel *time;

@property (nonatomic, strong) NewsTitleFrame *newsTitleFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
