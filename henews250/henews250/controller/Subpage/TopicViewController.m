//
//  TopicViewController.m
//  henews250
//
//  Created by 汪洋 on 16/9/19.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TopicViewController.h"

@interface TopicViewController ()

@end

@implementation TopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initPage {
    [super initPage];
    NSString *str = @"和新闻 · 专题";
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:str];
    [text addAttribute:NSForegroundColorAttributeName value:MainColor range:NSMakeRange(5, 3)];
    self.pageTitle.attributedText = text;
}

@end
