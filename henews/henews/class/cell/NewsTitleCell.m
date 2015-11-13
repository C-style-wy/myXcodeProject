//
//  NewsTitleCell.m
//  henews
//
//  Created by 汪洋 on 15/11/11.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "NewsTitleCell.h"
#import "APIStringMacros.h"
#import "UIImageView+AFNetworking.h"

@implementation NewsTitleCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"NewsTitleCell";
    // 1.缓存中取
    NewsTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[NewsTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UILabel *label1 = [[UILabel alloc]init];
        label1.font = NEWS_TITLE_SIZE;
        label1.textColor = [UIColor colorWithHue:0 saturation:0 brightness:0.2 alpha:1];
        label1.textAlignment = NSTextAlignmentLeft;
        label1.backgroundColor = [UIColor clearColor];
        label1.numberOfLines = 0;
        label1.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:label1];
        _titleLabel = label1;
        
        UILabel *label2 = [[UILabel alloc]init];
        label2.font = [UIFont systemFontOfSize:11.0f];
        label2.textColor = [UIColor colorWithHue:0 saturation:0 brightness:0.63 alpha:1];
        label2.textAlignment = NSTextAlignmentLeft;
        label2.backgroundColor = [UIColor clearColor];
        [self addSubview:label2];
        _timeLabel = label2;
        
    }
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    return self;
}

-(void)loadTableCell:(NewsTitleCellData*)data{
    _titleLabel.text = data.title;
    _titleLabel.frame = data.titleFrame;
    
    _timeLabel.text = data.sourceAndTime;
    _timeLabel.frame = data.timeFrame;
}

@end
