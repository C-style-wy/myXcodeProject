//
//  UserLoginController.m
//  henews250
//
//  Created by 汪洋 on 2016/10/13.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "UserLoginController.h"

@interface UserLoginController ()

@end

@implementation UserLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headView.title.text = @"登陆";
    self.headView.shareBtn.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pageBackBtnSelect {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
