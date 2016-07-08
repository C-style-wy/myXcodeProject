//
//  BaseViewController.m
//  henews250
//
//  Created by 汪洋 on 16/7/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - viewDiaLoad,viewWillAppear,viewDidAppear,viewWillDisappear,viewDidDisappear
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - menory warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - return iPhone type
- (iPhoneType)returnIphoneType{
    if (isIPhone4) {
        return iPhone4;
    }else if (isIPhone5){
        return iPhone5;
    }else if (isIPhone6){
        return iPhone6;
    }else if (isIPhone6p){
        return iPhone6p;
    }else{
        return iPhone5;
    }
}

#pragma mark - get and set NSUserDefaults key-value
- (NSString*)getUserData:(NSString*)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults stringForKey:key]){
        return [userDefaults stringForKey:key];
    }
    return false;
}

- (void)setUserData:(NSString*)key value:(NSString*)value {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
