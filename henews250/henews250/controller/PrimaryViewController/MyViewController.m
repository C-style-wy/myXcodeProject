//
//  MyViewController.m
//  henews250
//
//  Created by 汪洋 on 16/7/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initPage {
    self.userHeadView = [UserHeadView loadFromNib];
    self.userHeadView.controller = self;
    self.userHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (164.0*SCREEN_WIDTH)/320.0);
    [self.view addSubview:self.userHeadView];
    
    UIScrollView *uiScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.userHeadView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-40-self.userHeadView.frame.size.height)];
    uiScrollView.showsVerticalScrollIndicator = NO;
    uiScrollView.showsHorizontalScrollIndicator = NO;
    uiScrollView.clipsToBounds = NO;
    uiScrollView.delegate = self;
    uiScrollView.alwaysBounceVertical = YES;
    [self.view addSubview:uiScrollView];
    
    MyListView *myListView = [MyListView loadFromNib];
    myListView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (293.0*SCREEN_WIDTH)/320.0);
    [uiScrollView addSubview:myListView];
    uiScrollView.contentSize = CGSizeMake(0, uiScrollView.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float y = scrollView.contentOffset.y;
    if (y < 0) {
        self.userHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (164.0*SCREEN_WIDTH)/320.0 - y);
    }else if (y > 0 && y < 40){
        self.userHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (164.0*SCREEN_WIDTH)/320.0 - y);
    }else{
        self.userHeadView.frame = CGRectMake(0, -y+40, SCREEN_WIDTH, self.userHeadView.frame.size.height);
    }
    [self.userHeadView layoutIfNeeded];
}

//scrollView停止滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.userHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (164.0*SCREEN_WIDTH)/320.0);
    [self.userHeadView layoutIfNeeded];
}

@end
