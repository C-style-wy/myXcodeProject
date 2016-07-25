//
//  HomeController.m
//  henews250
//
//  Created by 汪洋 on 16/7/7.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "HomeController.h"
#import "NodeMode.h"
#import "NewsCellFactory.h"
#import "BannerMode.h"

@interface HomeController ()

@end

@implementation HomeController    

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init
- (void)initPage {
    UIImageView *setImage = [[UIImageView alloc] initWithFrame:CGRectMake(50-29, 5.5, 22, 22)];
    setImage.image = [UIImage imageNamed:@"channel_set_icon"];
    [self.setBtn addSubview:setImage];
    
    UIImageView *cityImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 5.5, 22, 22)];
    cityImage.image = [UIImage imageNamed:@"home_city_icon"];
    [self.cityBtn addSubview:cityImage];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 53, SCREEN_WIDTH, SCREEN_HEIGHT-53-40)];
    self.tableView.backgroundColor = LRClearColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self setupRefresh];
}

#pragma mark - 上下拉刷新加载更多方法
- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [self.tableView.mj_header beginRefreshing];
}

//下拉刷新
- (void)headerRereshing
{
    NSString *addHead = [SERVER_URL stringByAppendingString:HOME_URL];
    NSString *url = [addHead stringByAppendingString:@"合肥"];
    [Request requestPostForJSON:@"homeData" url:url delegate:self paras:nil msg:0 useCache:YES update:YES];
}

#pragma mark - 网络返回
-(void)requestDidReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg isCacheReturn:(BOOL)flag{
    if (!flag) {
        [self.tableView.mj_header endRefreshing];
    }
    if (returnJson) {
        self.homeMode = [HomeMode mj_objectWithKeyValues:returnJson];
        [self dealData];
    }
}

- (void)dealData {
    if (!_tableViewData) {
        _tableViewData = [[NSMutableArray alloc]init];
    }
    [_tableViewData removeAllObjects];
    if (_homeMode.banners && _homeMode.banners.count > 0) {
        NSMutableArray *bannersAry = [_homeMode.banners copy];
        [_tableViewData addObject:bannersAry];
    }
    [_tableViewData addObjectsFromArray:_homeMode.nodes];
    
    [self.tableView reloadData];
}

#pragma mark - btn action
- (IBAction)cityBtnSelect:(id)sender {
    NSLog(@"cityBtnSelect====");
}

- (IBAction)setBtnSelect:(id)sender {
    NSLog(@"setBtnSelect====");
}

#pragma mark - TabBarBtnDelegate
- (void)tabBarBtnSelectAgain {
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
//    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
//    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _tableViewData.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([[_tableViewData objectAtIndex:section] isKindOfClass:[NodeMode class]]) {
        NodeMode *modul = [_tableViewData objectAtIndex:section];
        SectionView *view = [[SectionView loadFromNib] initWithData:modul section:section];
        view.delegate = self;
        return view;
    }else{
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([[_tableViewData objectAtIndex:section] isKindOfClass:[NodeMode class]]) {
        return 26.5f;
    }else{
        return 0;
    }
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[_tableViewData objectAtIndex:section] isKindOfClass:[NodeMode class]]) {
        NodeMode *modul = [_tableViewData objectAtIndex:section];
        if (modul.newsList && modul.newsList.count > 0) {
            return modul.newsList.count;
        }else{
            return 0;
        }
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[_tableViewData objectAtIndex:indexPath.section] isKindOfClass:[NodeMode class]]) {
        NodeMode *modul = [_tableViewData objectAtIndex:indexPath.section];
        BOOL hiddenLine = NO;
        if (modul.newsList.count == indexPath.row + 1) {
            hiddenLine = YES;
        }
        return  [NewsCellFactory getCell:[modul.newsList objectAtIndex:indexPath.row] tableView:tableView hiddenLine:hiddenLine isShortLine:YES];
    }else{
        NSMutableArray *banners = [_tableViewData objectAtIndex:indexPath.section];
        BannerCell *cell = [BannerCell cellWithTableView:tableView];
        [cell setNews:banners hiddenLine:YES];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[_tableViewData objectAtIndex:indexPath.section] isKindOfClass:[NodeMode class]]) {
        NodeMode *modul = [_tableViewData objectAtIndex:indexPath.section];
        return [NewsCellFactory getHeightForRow:[modul.newsList objectAtIndex:indexPath.row]];
    }else{
        return SCREEN_WIDTH*197.0f/320.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
@end
