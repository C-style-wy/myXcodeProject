//
//  SettingViewController.m
//  henews250
//
//  Created by 汪洋 on 2016/11/14.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SettingViewController.h"
#import "SHLUILabel.h"

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
    

    
    SHLUILabel *label2 = [[SHLUILabel alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 300)];
    label2.textColor = [UIColor blackColor];
    [self.view addSubview:label2];
    label2.text = @"<B>本文共计3166字|建议阅读时间10分钟</B>\n<B>很多人在了解跟科学发展相关的历史时</B>，总有一个错误的观念：科学的进步是一下子出现的——在某个历史节点上，一个先知般的人物瞬间获得了“完全正确的”认识，而其他人仍处在一种昏昏沉沉的迷惘状态之中。\n然而，任何发展的过程都是连续的，所有青史留名的成就都是<B>“站在巨人肩膀上”</B>获得的，这就注定了极少会出现“众人皆醉我独醒”的人物。在审视历史的过程中，我们极难量化一个人的思想——这其中到底有多少对的成分？";
    //    label2.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
    label2.font = [UIFont fontWithName:@"KaiTi_GB2312" size:17.0f];
    label2.font = [UIFont boldSystemFontOfSize:17.0f];
    
    
    
}

@end
