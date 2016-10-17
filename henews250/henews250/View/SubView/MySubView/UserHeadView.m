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

@implementation UserHeadView

- (void)setController:(MyViewController *)controller {
    _controller = controller;
}

- (IBAction)loginBtnSelect:(id)sender {
//    LoaclUserInfoData *userInfo = [UserInfoHandle getUserInfoFromLocal];
//    if (userInfo && userInfo.isLogin) {
//        
//    }else{
        UserLoginController *login = [UserLoginController loadFromStoryboard];
        [self.controller presentViewController:login animated:YES completion:nil];
//    }
}

- (IBAction)signBtnSelect:(id)sender {
    
}

@end
