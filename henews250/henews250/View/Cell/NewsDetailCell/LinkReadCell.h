//
//  LinkReadCell.h
//  henews250
//
//  Created by 汪洋 on 2016/11/16.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseCell.h"

@interface LinkReadCell : BaseCell

@property (nonatomic, retain) UILabel *linkReadLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
