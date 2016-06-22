//
//  PageHead.m
//  henews
//
//  Created by 汪洋 on 16/3/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "PageHead.h"
#import "APIStringMacros.h"

@implementation PageHead

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, frame.size.width, 33)];
        [self addSubview:view];
        
        UIImageView *line = [[UIImageView alloc]init];
        line.frame = CGRectMake(0, view.frame.size.height-0.5f, view.frame.size.width, 0.5f);
        line.image = [UIImage imageNamed:@"menuFenge.png"];
        [view addSubview:line];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        [view addSubview:label];
        self.pageTitle = label;
        label.textColor = VIEWTITLECOLOR;
        label.font = VIEWTITLEFONT;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"和新闻";
        //返回按钮
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, view.frame.size.height)];
        [backBtn addTarget:self action:@selector(handleBtnSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:backBtn];
        [backBtn setImage:[UIImage imageNamed:@"new_back.png"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"new_back_sel.png"] forState:UIControlStateHighlighted];
        [backBtn setImageEdgeInsets:UIEdgeInsetsMake(5.0f, 8.0f, 5.0f, 29)];
        
        //夜间模式按钮
        UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(view.frame.size.width-31, 0, 31, view.frame.size.height)];
        shareBtn.tag = 0;
        [shareBtn addTarget:self action:@selector(handleShareBtnSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:shareBtn];
        [shareBtn setImage:[UIImage imageNamed:@"detail_share_icon.png"] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:@"newShare_s.png"] forState:UIControlStateHighlighted];
        [shareBtn setImageEdgeInsets:UIEdgeInsetsMake(5.0f, 0.0f, 5.0f, 8)];
        self.shareButton = shareBtn;
    }
    return self;
}


- (void)handleBtnSelectAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(pageHead:backButton:)]) {
        [self.delegate pageHead:self backButton:button];
    }
}

- (void)handleShareBtnSelectAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(pageHead:shareButton:)]) {
        [self.delegate pageHead:self shareButton:button];
    }
}


@end
