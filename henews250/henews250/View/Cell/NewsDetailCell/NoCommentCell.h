//
//  NoCommentCell.h
//  henews250
//
//  Created by 汪洋 on 2016/11/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseCell.h"

@interface NoCommentCell : BaseCell

@property (nonatomic, retain) UILabel *noCommentLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
