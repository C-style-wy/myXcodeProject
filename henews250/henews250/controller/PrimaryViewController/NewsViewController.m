//
//  NewsViewController.m
//  henews250
//
//  Created by 汪洋 on 16/7/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController () {
    CGFloat _beginScrollX;
    NSTimer *_timer;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPage];
}

- (void)initPage {
    [self.view layoutIfNeeded];
    self.classScrollView.delegate = self;
    self.mainScrollView.delegate = self;
    
    self.firstTableView = [[UITableView alloc]initWithFrame:self.mainScrollView.bounds];
    self.middleTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, self.mainScrollView.frame.size.width, self.mainScrollView.frame.size.height)];
    self.lastTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, self.mainScrollView.frame.size.width, self.mainScrollView.frame.size.height)];
    self.firstTableView.delegate = self;
    self.firstTableView.dataSource = self;
    self.middleTableView.delegate = self;
    self.middleTableView.dataSource = self;
    self.lastTableView.delegate = self;
    self.lastTableView.dataSource = self;
    
    self.firstTableView.tag = 0;
    self.middleTableView.tag = 1;
    self.lastTableView.tag = 2;
    
    self.firstTableView.backgroundColor = LRClearColor;
    self.middleTableView.backgroundColor = LRClearColor;
    self.lastTableView.backgroundColor = LRClearColor;
    
    self.firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.middleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.lastTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.firstTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.firstTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    self.middleTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.middleTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    self.lastTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.lastTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
//    
//    [self.mainScrollView addSubview:_firstTableView];
//    [self.mainScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, 0)];
    
    self.curClass = 0;
    _beginScrollX = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TabBarBtnDelegate
- (void)tabBarBtnSelectAgain {
    NSLog(@"news===tabBarBtnSelectAgain=====");
}
- (IBAction)classAddBtnSelect:(id)sender {
}

//下拉刷新
- (void)headerRereshing{
    
}

//上拉加载下一页
- (void)footerRereshing {
    
}


#pragma mark - scrollView
//scrollView停止滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
