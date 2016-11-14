//
//  MyMsgViewController.m
//  henews250
//
//  Created by 汪洋 on 2016/11/14.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "MyMsgViewController.h"

@interface MyMsgViewController ()

@end

@implementation MyMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initPage {
    [super initPage];
    self.pageTitle.text = @"我的消息";
    self.pageShareBtn.hidden = YES;
}

@end
