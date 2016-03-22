//
//  NewsLinkCell.m
//  henews
//
//  Created by 汪洋 on 16/3/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NewsLinkCell.h"
#import "LinkViewController.h"

@implementation NewsLinkCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"NewsLinkCell";
    // 1.缓存中取
    NewsLinkCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[NewsLinkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 38-4)];
        [button addTarget:self action:@selector(linkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 38-4)];
        label1.font = [UIFont systemFontOfSize:13.0f];
        label1.textColor = [UIColor colorWithRed:0.71 green:0.71 blue:0.71 alpha:1];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.backgroundColor = [UIColor clearColor];
        label1.numberOfLines = 1;
        label1.text = @"已自动优化阅读，点击查看原文";
        [self addSubview:label1];
        
        
    }
    return self;
}

- (void)linkBtnClick:(UIButton *)button{
//    button.backgroundColor = [UIColor clearColor];
    LinkViewController *linkPage = [[LinkViewController alloc] init];
    linkPage.linkUrl = self.data.linkUrl;
    linkPage.showShareButton = NO;
    [self.controller.navigationController pushViewController:linkPage animated:YES];
}

-(void)loadTableCell:(NewsLinkCellData*)data controller:(UIViewController *)view{
    self.data = data;
    self.controller = view;
}

@end
