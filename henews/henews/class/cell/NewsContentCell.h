//
//  NewsContentCell.h
//  henews
//
//  Created by 汪洋 on 15/11/11.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsContentCellData.h"
#import "SHLUILabel.h"

@interface NewsContentCell : UITableViewCell

@property (nonatomic, retain) SHLUILabel *content;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)loadTableCell:(NewsContentCellData*)data;

@end
