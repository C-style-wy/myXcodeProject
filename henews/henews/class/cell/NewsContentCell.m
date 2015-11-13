//
//  NewsContentCell.m
//  henews
//
//  Created by 汪洋 on 15/11/11.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "NewsContentCell.h"
#import "APIStringMacros.h"

@implementation NewsContentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"NewsContentCell";
    // 1.缓存中取
    NewsContentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[NewsContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *label1 = [[UILabel alloc]init];
        label1.font = NEWS_CONTENT_SIZE;
        label1.textColor = [UIColor colorWithHue:0 saturation:0 brightness:0.2 alpha:1];
        label1.textAlignment = NSTextAlignmentJustified;
        label1.backgroundColor = [UIColor clearColor];
        label1.numberOfLines = 0;
        label1.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:label1];
        _content = label1;
    }
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    return self;
}

-(void)loadTableCell:(NewsContentCellData*)data{
    _content.text = data.content;
    _content.frame = data.contentFrame;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:data.content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:NEWS_CONTENT_DIS];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [data.content length])];
    _content.attributedText = attributedString;

    [_content sizeToFit];
}

@end
