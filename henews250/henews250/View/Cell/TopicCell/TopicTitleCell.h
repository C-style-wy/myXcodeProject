//
//  TopicTitleCell.h
//  henews250
//
//  Created by 汪洋 on 2016/11/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseCell.h"
#import "TopicTitleFrame.h"

@interface TopicTitleCell : BaseCell

@property (nonatomic, retain) UIImageView *topicImage;
@property (nonatomic, retain) SHLUILabel *topicIntro;

@property (nonatomic, retain) TopicTitleFrame *topicTitleFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
