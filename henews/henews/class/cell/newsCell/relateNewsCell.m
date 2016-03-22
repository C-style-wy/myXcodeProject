//
//  relateNewsCell.m
//  henews
//
//  Created by 汪洋 on 16/3/21.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "relateNewsCell.h"

@implementation relateNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"relateNewsCell";
    // 1.缓存中取
    relateNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[relateNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *line = [[UIImageView alloc]init];
        line.frame = CGRectMake(0, 43.5f, SCREEN_WIDTH, 0.5f);
        line.image = [UIImage imageNamed:@"menuFenge.png"];
        [self addSubview:line];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(9.0f, (44.0f - 15.0f)/2, 17.5f, 15.0f)];
        image.image = [UIImage imageNamed:@"detail_news.png"];
        [self addSubview:image];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(36.0f, 0, SCREEN_WIDTH - 36.0f, 44.0f)];
        label.text = @"推荐新闻";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor colorWithRed:0.12 green:0.12 blue:0.12 alpha:1];
        [self addSubview:label];
    }
    return self;
}

@end
