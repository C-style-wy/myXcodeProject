//
//  TopicSubViewController.m
//  henews250
//
//  Created by 汪洋 on 2016/11/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TopicSubViewController.h"

@interface TopicSubViewController ()

@end

@implementation TopicSubViewController

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
    if (self.subTopicTitle) {
        self.pageTitle.text = self.subTopicTitle;
    }
}

@end
