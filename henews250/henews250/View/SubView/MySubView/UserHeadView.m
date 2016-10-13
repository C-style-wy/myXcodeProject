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

@implementation UserHeadView

- (void)setController:(MyViewController *)controller {
    _controller = controller;
}

- (IBAction)loginBtnSelect:(id)sender {
    UserLoginController *login = [UserLoginController loadFromStoryboard];
//    [self.controller.navigationController pushViewController:login animated:YES];
    [self.controller presentViewController:login animated:YES completion:nil];
}

- (IBAction)signBtnSelect:(id)sender {
    
}

@end
