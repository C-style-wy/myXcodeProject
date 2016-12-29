//
//  CommentCell.h
//  henews250
//
//  Created by 汪洋 on 2016/12/26.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
#import "CommentMode.h"

@interface CommentCell : BaseCell
@property (weak, nonatomic) IBOutlet UIImageView *userHeader;
@property (weak, nonatomic) IBOutlet UIImageView *line;


@property (nonatomic, retain) CommentMode *commentMode;
@property (nonatomic, assign) BOOL hideLine;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
