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
    // Do any additional setup after loading the view.
//    NSLog(@"home===viewDidLoad=====");
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    [self initUi];
    
//    [self.tableView headerBeginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 按钮响应函数
- (void)channelBntSelect:(id)sender{
    //    NSLog(@"频道选择");
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
    
    //    for (int i = 0; i < 5; i++) {
    //        [self.tableViewData addObject:[NSString stringWithFormat:@"这是第%d条",i + 1]];
    //    }
    
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
        //        NSLog(@"returnJson======%@", returnJson);
        [_tableViewData removeAllObjects];
        [_tableCellHeightArray removeAllObjects];
        
        [_tableViewData addObject:[returnJson objectForKey:@"banners"]];
        
        NSArray *newsList = [returnJson objectForKey:@"newsList"];
        for (int i = 0; i < newsList.count; i++) {
            if ([[[newsList objectAtIndex:i] objectForKey:@"displayType"] isEqual:@"11"] || [[[newsList objectAtIndex:i] objectForKey:@"displayType"] isEqual:@"0"]) {
                [_tableViewData addObject:[newsList objectAtIndex:i]];
            }
        }
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        self.nextUrl = [returnJson objectForKey:@"nextUrl"];
    }else if ([tag isEqual:@"addHomeData"]){
        NSArray *newsList = [returnJson objectForKey:@"newsList"];
        for (int i = 0; i < newsList.count; i++) {
            if ([[[newsList objectAtIndex:i] objectForKey:@"displayType"] isEqual:@"11"] || [[[newsList objectAtIndex:i] objectForKey:@"displayType"] isEqual:@"0"]) {
                [_tableViewData addObject:[newsList objectAtIndex:i]];
            }
        }
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
        self.nextUrl = [returnJson objectForKey:@"nextUrl"];
    }
}

#pragma mark - 上下拉刷新加载更多方法
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

//下拉刷新
- (void)headerRereshing
{
    //    NSLog(@"headerRereshing======");
//    NSString *url = @"http://wap.cmread.com/clt/publish/clt/resource/portal/v1/contentList.jsp?n=26391&city=合肥";
//    [Request requestPostForJSON:@"homeData" url:url delegate:self paras:nil msg:0];
}

//上拉加载
- (void)footerRereshing
{
//    NSString *url = self.nextUrl;
//    [Request requestPostForJSON:@"addHomeData" url:url delegate:self paras:nil msg:0];
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    NSLog(@"tableView==count===%lu", [_tableViewData count]);
    return [_tableViewData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"return==cell====%@", _tableViewData);
    //    if ([_tableViewData objectAtIndex:indexPath.row] && [[_tableViewData objectAtIndex:indexPath.row]objectForKey:@"banners"]) {
    //        NSLog(@"return==have==banners==");
    //        OnlyTitleCell *cell = [OnlyTitleCell cellWithTableView:tableView];
    //        return cell;
    //    }
    if (0 == indexPath.row) {
        //        NSLog(@"return==have==banners==");
        BannersCell *cell = [BannersCell cellWithTableView:tableView];
        [cell loadTableCell:[_tableViewData objectAtIndex:indexPath.row]];
        return cell;
    }
    if ([[[_tableViewData objectAtIndex:indexPath.row] objectForKey:@"displayType"] isEqual:@"11"]) {
        OneSmallPicCell *cell = [OneSmallPicCell cellWithTableView:tableView];
        [cell loadTableCell:[_tableViewData objectAtIndex:indexPath.row]];
        return cell;
    }else{
        OnlyTitleCell *cell = [OnlyTitleCell cellWithTableView:tableView];
        [cell loadTableCell:[_tableViewData objectAtIndex:indexPath.row]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSLog(@"return==cellHeight====");
    //    if ([_tableViewData objectAtIndex:indexPath.row] && [[_tableViewData objectAtIndex:indexPath.row]objectForKey:@"banners"]) {
    //        return 180.0f;
    //    }
    if (0 == indexPath.row) {
        return 185.0f;
    }
    if ([[[_tableViewData objectAtIndex:indexPath.row] objectForKey:@"displayType"] isEqual:@"11"]) {
        return 88.0f;
    }else{
        return 80.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *detail = [[DetailViewController alloc] init];
    self.delegate = detail;
    [self.delegate getUrl:[[_tableViewData objectAtIndex:indexPath.row] objectForKey:@"url"]];
    
    [self.navigationController pushViewController:detail animated:YES];
}

@end
