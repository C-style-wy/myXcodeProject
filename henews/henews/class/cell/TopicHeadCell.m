//
//  TopicHeadCell.m
//  henews
//
//  Created by 汪洋 on 16/3/30.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TopicHeadCell.h"
#import "SHLUILabel.h"
#import "UIImageView+AFNetworking.h"

@implementation TopicHeadCell{
    UIImageView *_image;
    SHLUILabel *_introduction;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"TopicHeadCell";
    // 1.缓存中取
    TopicHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[TopicHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //默认图
        UIView *defaultView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 146)];
        defaultView.backgroundColor = DEFAULTCOLOR;
        UIImageView *defaultImage = [[UIImageView alloc]init];
        defaultImage.frame = CGRectMake((defaultView.frame.size.width-45)/2, (defaultView.frame.size.height - 45)/2, 45, 45);
        [defaultImage setImage:[UIImage imageNamed:@"newsBigBg.png"]];
        [defaultView addSubview:defaultImage];
        [self addSubview:defaultView];
        
        _image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 146)];
        _image.contentMode = UIViewContentModeScaleAspectFill;
        [_image setContentScaleFactor:[[UIScreen mainScreen]scale]];
        _image.clipsToBounds = YES;
        [self addSubview:_image];
        
        _introduction = [[SHLUILabel alloc] init];
        _introduction.font = [UIFont systemFontOfSize:13.5f];
        //设置字体颜色
        _introduction.textColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1.00];
        _introduction.lineBreakMode = NSLineBreakByWordWrapping;
        _introduction.numberOfLines = 0;
        [self addSubview:_introduction];

    }
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    return self;
}

-(void)loadTableCell:(topicHeadData *)data{
    if (![data.images isEqual:@""]) {
        [_image setImageWithURL:[NSURL URLWithString:data.images]];
    }
    if (![data.topicIntro isEqual:@""]) {
        _introduction.text = data.topicIntro;
        _introduction.frame = data.introFrame;
    }
}

@end
