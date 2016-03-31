//
//  TopicHeadCell.h
//  henews
//
//  Created by 汪洋 on 16/3/30.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "topicHeadData.h"

@interface TopicHeadCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)loadTableCell:(topicHeadData *)data;

@end
