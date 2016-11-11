//
//  DetailShareCell.h
//  henews250
//
//  Created by 汪洋 on 2016/11/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailShareMode.h"

@interface DetailShareCell : UITableViewCell

@property (nonatomic, retain) DetailShareMode *shareMode;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
