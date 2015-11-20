//
//  HomeViewController.m
//  henews
//
//  Created by 汪洋 on 15/10/19.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "HomeViewController.h"
#import "DetailViewController.h"
#import "MJRefresh.h"
#import "Request.h"
#import "OneSmallPicCell.h"
#import "OnlyTitleCell.h"
#import "BannersCell.h"
#import "UIImageView+AFNetworking.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    [self initUi];
    
    [self.tableView headerBeginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 按钮响应函数
- (void)channelBntSelect:(id)sender{
    DetailViewController *detail = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - 页面初始化
- (void)initUi {
    int screenW = [[UIScreen mainScreen] bounds].size.width;
    int screenH = [[UIScreen mainScreen] bounds].size.height;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 59)];
    topView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *line = [[UIImageView alloc]init];
    line.frame = CGRectMake(0, 58.5f, screenW, 0.5f);
    line.image = [UIImage imageNamed:@"menuFenge.png"];
    [topView addSubview:line];
    
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake((screenW-69)/2, 28, 69, 23)];
    logoImage.image = [UIImage imageNamed:@"home_icon.png"];
    [topView addSubview:logoImage];
    
    UIButton *setBnt = [[UIButton alloc] initWithFrame:CGRectMake(screenW-50, 20, 50, 39)];
    UIImageView *setImage = [[UIImageView alloc] initWithFrame:CGRectMake(50-29, 9, 22, 22)];
    setImage.image = [UIImage imageNamed:@"channel_set_icon.png"];
    
    [setBnt addSubview:setImage];
    [setBnt addTarget:self action:@selector(channelBntSelect:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:setBnt];
    
    UIButton *cityBnt = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 50, 39)];
    UIImageView *cityImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 22, 22)];
    cityImage.image = [UIImage imageNamed:@"home_dw_icon.png"];
    
    [cityBnt addSubview:cityImage];
    [cityBnt addTarget:self action:@selector(channelBntSelect:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cityBnt];
    
    UILabel *cityName = [[UILabel alloc] initWithFrame:CGRectMake(38, 20, 100, 39)];
    cityName.text = @"合肥";
    cityName.font = [UIFont systemFontOfSize:14];
    [topView addSubview:cityName];
    
    [self.view addSubview:topView];
    
    self.tableViewData = [[NSMutableArray alloc]init];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.frame = CGRectMake(0, 59, screenW, screenH-102);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    [self setupRefresh];
}

#pragma mark - 网络请求返回
-(void)requestDidReturn:(NSString*)tag returnStr:(NSString*)returnStr returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg;{
    if ([tag isEqual:@"homeData"]) {
        NSLog(@"returnJson===%@", returnJson);
        [self.tableView headerEndRefreshing];
        [_tableView reloadData];
    }
}

#pragma mark - 上下拉刷新加载更多方法
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
//    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

//下拉刷新
- (void)headerRereshing
{
    NSString *addHead = [GET_SERVER stringByAppendingString:GET_HOME_URL];
    NSString *url = [addHead stringByAppendingString:@"合肥"];
    [Request requestPostForJSON:@"homeData" url:url delegate:self paras:nil msg:0];
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

//返回没个分区的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"测试";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionHead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 100)];
    sectionHead.backgroundColor = ROSERED;
    return sectionHead;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OnlyTitleCell *cell = [OnlyTitleCell cellWithTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
