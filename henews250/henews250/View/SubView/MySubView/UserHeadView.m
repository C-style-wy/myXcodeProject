//
//  UserHeadView.m
//  henews250
//
//  Created by 汪洋 on 16/9/28.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "UserHeadView.h"
#import "UserLoginController.h"
#import "MyViewController.h"
#import "UserInfoHandle.h"
#import "UserCenterController.h"

@implementation UserHeadView

- (void)setController:(MyViewController *)controller {
    _controller = controller;
}

- (IBAction)loginBtnSelect:(id)sender {
    if ([UserInfoHandle isLogin]) {
        UserCenterController *userCenter = [[UserCenterController alloc]init];
//        [self.controller presentViewController:userCenter animated:YES completion:nil];
        [self.controller.navigationController pushViewController:userCenter animated:YES];
    }else{
        UserLoginController *login = [UserLoginController loadFromStoryboard];
//        [self.controller presentViewController:login animated:YES completion:nil];
        [self.controller.navigationController pushViewController:login animated:YES];
    }
}

- (IBAction)signBtnSelect:(id)sender {
    
}

@end
