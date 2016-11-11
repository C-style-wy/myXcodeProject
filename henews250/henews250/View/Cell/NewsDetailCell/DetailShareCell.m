//
//  DetailShareCell.m
//  henews250
//
//  Created by 汪洋 on 2016/11/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "DetailShareCell.h"

@implementation DetailShareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifer = @"DetailShareCell";
    DetailShareCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailShareCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setShareMode:(DetailShareMode *)shareMode {
    _shareMode = shareMode;
}
@end
