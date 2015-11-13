//
//  BannersCell.h
//  henews
//
//  Created by 汪洋 on 15/11/3.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannersCell : UITableViewCell

@property (nonatomic, weak) UIScrollView *bannersScrollView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)loadTableCell:(id)data;
@end
