//
//  NewsShareCell.m
//  henews
//
//  Created by 汪洋 on 15/11/11.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "NewsShareCell.h"

@implementation NewsShareCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"NewsShareCell";
    // 1.缓存中取
    NewsShareCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[NewsShareCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        float btnX = 8.0f;
        float btnW = (SCREEN_WIDTH - 46)/5;
        float btnH = 30;
        for (int i = 0; i < 5; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(btnX, (48-btnH)/2, btnW, btnH)];
            btnX = btnX+btnW+7.5f;
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, btnW, btnH)];
            if (0 == i) {
                img.image = [UIImage imageNamed:@"shareWeixin.jpg"];
            }else if (1 == i){
                img.image = [UIImage imageNamed:@"shareFriend.jpg"];
            }else if (2 == i){
                img.image = [UIImage imageNamed:@"shareWeibo.jpg"];
            }else if (3 == i){
                img.image = [UIImage imageNamed:@"shareQQ.jpg"];
            }else if (4 == i){
                img.image = [UIImage imageNamed:@"shareMore.jpg"];
            }
            [button addSubview:img];
            [self addSubview:button];
        }
    }
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    return self;
}

@end
