//
//  BaseViewController.m
//  henews250
//
//  Created by 汪洋 on 16/7/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseViewController.h"

#import "NewsDetailViewController.h"

#import "IndexViewController.h"
#import "XNTabBarView.h"

#import "HomeController.h"
#import "PicViewController.h"
static NSString * const pushNotificationKey = @"pushNotificationKey";

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - viewDiaLoad,viewWillAppear,viewDidAppear,viewWillDisappear,viewDidDisappear
- (void)viewDidLoad {
    [super viewDidLoad];
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(pushNotification:) name:pushNotificationKey object:nil];
    
    //添加监听方法，监听应用从后台切换到前台
    [center addObserver:self selector:@selector(appEnterForeground) name:UIApplicationDidBecomeActiveNotification object:nil];
    if ([self isKindOfClass:[HomeController class]]) {
        AppDelegate *myDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        if (myDelegate.pushData && ![self isKindOfClass:[IndexViewController class]] && ![self isKindOfClass:[XNTabBarView class]]) {
            PicViewController *pic = [PicViewController loadFromStoryboard];
            [self.navigationController pushViewController:pic animated:YES];
            myDelegate.pushData = nil;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.isViewVisable = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.isViewVisable = NO;
}



- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden{
    //    return !showToolBarAndText; //返回NO表示要显示，返回YES将hiden
    return NO;
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

- (NSString*)getCurSysTimeWithFormat:(NSString*)format {
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:currentDate];
}

- (BOOL)earlierCurTimeWithTimeStr:(NSString*)timeStr {
    NSDate *curDate = [NSDate date];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *inputDate = [inputFormatter dateFromString:timeStr];
    
    NSComparisonResult result = [inputDate compare:curDate];
    if (result == NSOrderedDescending) {
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)laterCurTimeWithTimeStr:(NSString*)timeStr {
    NSDate *curDate = [NSDate date];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *inputDate = [inputFormatter dateFromString:timeStr];
    
    NSComparisonResult result = [inputDate compare:curDate];
    if (result == NSOrderedDescending) {
        return YES;
    }else{
        return NO;
    }
}

-(void)pushNotification:(id)sender{
    if (self.isViewVisable && ![self isKindOfClass:[IndexViewController class]] && ![self isKindOfClass:[XNTabBarView class]]) {
        
        [Dialog showWithTipText:@"提示" descText:@"推送" LeftText:@"确定" rightText:@"取消" LeftBlock:^{
            NewsDetailViewController *news = [NewsDetailViewController loadFromStoryboard];
            [self.navigationController pushViewController:news animated:YES];
        } RightBlock:^{
            
        }];
    }
    
}

- (void)appEnterForeground {
    AppDelegate *myDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (self.isViewVisable && myDelegate.pushData && ![self isKindOfClass:[IndexViewController class]] && ![self isKindOfClass:[XNTabBarView class]]) {
        NTLog(@"appEnterForeground====%@",myDelegate.pushData);
        NewsDetailViewController *news = [NewsDetailViewController loadFromStoryboard];
        [self.navigationController pushViewController:news animated:YES];
        myDelegate.pushData = nil;
    }
}
@end
