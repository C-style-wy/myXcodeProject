//
//  SharefriendViewController.m
//  henews250
//
//  Created by 汪洋 on 2016/11/14.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SharefriendViewController.h"

@interface SharefriendViewController ()

@end

@implementation SharefriendViewController

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
    self.pageTitle.text = @"邀请好友";
    self.pageShareBtn.hidden = YES;
}

@end
