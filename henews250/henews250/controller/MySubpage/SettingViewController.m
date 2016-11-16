//
//  SettingViewController.m
//  henews250
//
//  Created by 汪洋 on 2016/11/14.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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
    self.pageTitle.text = @"设置";
    self.headView.shareBtn.hidden = YES;
    self.headView.line.hidden = YES;
    
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 20)];
//    label2.font = [UIFont systemFontOfSize:17.0f];
    label2.textColor = [UIColor blackColor];
    [self.view addSubview:label2];
    label2.text = @"段落的风格（设置首行，行间距，对齐方式什么的";
//    label2.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
    label2.font = [UIFont fontWithName:@"KaiTi_GB2312" size:17.0f];
    label2.font = [UIFont boldSystemFontOfSize:17.0f];
    
}

@end
