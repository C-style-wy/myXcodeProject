//
//  SubBaseViewController.m
//  henews250
//
//  Created by 汪洋 on 16/8/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SubBaseViewController.h"

@interface SubBaseViewController ()

@end

@implementation SubBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headView = [SubPageHeadView loadFromNib];
    _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 53);
    _headView.delegate = self;
    self.pageTitle = self.headView.title;
    self.pageShareBtn = self.headView.shareBtn;
    [self.view addSubview:_headView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initPage {}

- (void)pageBackBtnSelect {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)pageShareBtnSelect {
    
}

@end
