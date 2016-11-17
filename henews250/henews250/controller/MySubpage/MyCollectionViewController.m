//
//  MyCollectionViewController.m
//  henews250
//
//  Created by 汪洋 on 2016/11/14.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "MyCollectionViewController.h"

@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

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
    self.pageTitle.text = @"我的收藏";
    self.pageShareBtn.hidden = YES;
    [NetworkManager postRequestJsonWithURL:DEF_GetMyCollectionUrl params:nil cacheBlock:^(NSDictionary *returnJson) {
        
    } successBlock:^(NSDictionary *returnJson) {
        
    } failureBlock:^(NSError *error) {
        
    } showHUD:YES];
}

@end
