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
#import "CityViewController.h"

#import "NetworkUrl.h"
#import "objc/runtime.h"

@interface HomeController ()

@end

@implementation HomeController {
    TierManageView *tierManageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPage];
    
    //test
//    static char overviewKey;
//    NSArray *array = [[NSArray alloc] initWithObjects:@"One", @"Two", @"Three", nil];
//    NSString *overview = [[NSString alloc] initWithFormat:@"%@", @"First three numbers"];
//    objc_setAssociatedObject(array, &overviewKey, overview, OBJC_ASSOCIATION_RETAIN);
//    
//    NSString *associatedObject = (NSString*)objc_getAssociatedObject(array, &overviewKey);
//    NSLog(@"associatedObject===%@", associatedObject);
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.cityName.text = [[CityManager shareInstance]getCity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
- (void)headerRereshing {
    NSString *homeUrl = [DEF_GetHomepage stringByAppendingString:[[CityManager shareInstance] getCity]];
    [NetworkManager postReqeustJsonWithURL:homeUrl params:nil delegate:self tag:@"homeData" msg:0 useCache:YES update:YES showHUD:NO];
}

#pragma mark - 网络返回
- (void)requestDidFinishLoading:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg isCacheReturn:(BOOL)flag{
    if ([tag isEqualToString:@"homeData"]) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.separatorColor = [UIColor colorWithHexColor:@"#c8c8c8"];
        //    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 8);
        if (!flag) {
            [self.tableView.mj_header endRefreshing];
        }
        if (returnJson) {
            NSArray *newsAry = [returnJson objectForKey:@"nodes"];
            [TierManageMode compareAndSave:newsAry key:Home];
            
            self.homeMode = [HomeMode mj_objectWithKeyValues:returnJson];
            [self dealData];
        }
        
    }else if ([tag isEqualToString:@"changeData"]){
        if (returnJson) {
            self.changeData = [ChangeDataMode mj_objectWithKeyValues:returnJson];
            NodeMode *node = [_tableViewData objectAtIndex:msg];
            node.changeUrl = _changeData.changeUrl;
            node.newsList = _changeData.newsList;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:msg];
            [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        }
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
//    [_tableViewData addObjectsFromArray:_homeMode.nodes];
    for (int i = 0; i < _homeMode.nodes.count; i++) {
        NodeMode *mudel = [_homeMode.nodes objectAtIndex:i];
        if (mudel.nodeName && ![mudel.nodeName isEqualToString:@""]) {
            if (([mudel.displayType intValue] == EditorRecommend && mudel.newsList && mudel.newsList.count > 0) || [mudel.displayType intValue] != EditorRecommend) {
                [_tableViewData addObject:mudel];
            }
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - btn action
- (IBAction)cityBtnSelect:(id)sender {
    CityViewController *city = [CityViewController loadFromStoryboard];
    __weak typeof(&*self)weakSelf = self;
    city.changeCityBlock = ^(void){
        [weakSelf tabBarBtnSelectAgain];
    };
    [self.navigationController pushViewController:city animated:YES];
}

- (IBAction)setBtnSelect:(id)sender {
    if (tierManageView == nil) {
        tierManageView = [[TierManageView loadFromNib] initWithName:Home];
        tierManageView.frame = CGRectMake(0, 53, SCREEN_WIDTH, SCREEN_HEIGHT-53);
        tierManageView.delegate = self;
    }
    [self.view addSubview:tierManageView];
    [tierManageView openTierManage:0 clickBtn:sender];
}

#pragma mark - TabBarBtnDelegate
- (void)tabBarBtnSelectAgain {
    if (_tableView.contentOffset.y == 0) {
        [self.tableView.mj_header beginRefreshing];
    }else{
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}


#pragma mark - SectionDelegate
- (void)requestSectionChange:(NSString*)url section:(NSInteger)section {
    [NetworkManager postReqeustJsonWithURL:url params:nil delegate:self tag:@"changeData" msg:section useCache:NO update:YES showHUD:NO];
}
- (void)jumpToMore:(NodeMode*)node {
    NSLog(@"jumpToMore====");
}

#pragma mark - TierManageViewDelegate
- (void)whenOpenOrCloseTierManage:(BOOL)isOpen{
    XNTabBarView *tabBarViewController = (XNTabBarView*)self.tabBarController;
    if (isOpen) {
        [tabBarViewController closeMenu];
    }else{
        [tabBarViewController openMenu];
    }
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
//        if (modul.newsList && modul.newsList.count > 0) {
//            return modul.newsList.count;
//        }else{
//            return 0;
//        }
        return [NewsCellFactory getNumberOfRowsInSection:modul];
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
//        return  [NewsCellFactory getCell:[modul.newsList objectAtIndex:indexPath.row] modulData:modul tableView:tableView hiddenLine:hiddenLine isShortLine:YES];
        
        return [NewsCellFactory getCell:modul row:indexPath.row tableView:tableView hiddenLine:YES isShortLine:YES];
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
//        return [NewsCellFactory getHeightForRow:[modul.newsList objectAtIndex:indexPath.row] modulData:modul];
        return [NewsCellFactory getHeightForRow:modul row:indexPath.row];
    }else{
        return SCREEN_WIDTH*197.0f/320.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//setContentOffset:CGPointMake(0, 0) animated:YES动画结束回调函数
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self.tableView.mj_header beginRefreshing];
}
@end
