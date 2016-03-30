//
//  BaseViewController.m
//  henews
//
//  Created by 汪洋 on 16/3/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = VIEWBACKGROUND_COLOR;
    
    PageHead *head = [[PageHead alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 53)];
    head.delegate = self;
    [self.view addSubview:head];
    self.head = head;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
