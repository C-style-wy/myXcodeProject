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

#import "IndexViewController.h"
#import "PicViewController.h"

static NSString * const requestHomeDataTag = @"homeData";
static NSString * const requestChangeDataTag = @"changeData";

@interface HomeController ()

@end

@implementation HomeController {
    TierManageView *tierManageView;
    //置顶时是否刷新
    BOOL canReflush;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPage];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.cityName.text = [[CityManager shareInstance]getCity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 懒加载
- (UITableView*)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 53, SCREEN_WIDTH, SCREEN_HEIGHT-53-40)];
        _tableView.backgroundColor = LRClearColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSString *)contIdStrTabel {
    if (!_contIdStrTabel) {
        _contIdStrTabel = [[NSString alloc]init];
    }
    return _contIdStrTabel;
}

#pragma mark - init
- (void)initPage {
    canReflush = YES;
    //*******
    [self.tableView reloadData];
    UIImageView *setImage = [[UIImageView alloc] initWithFrame:CGRectMake(50-29, 5.5, 22, 22)];
    setImage.image = [UIImage imageNamed:@"channel_set_icon"];
    [self.setBtn addSubview:setImage];
    
    UIImageView *cityImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 5.5, 22, 22)];
    cityImage.image = [UIImage imageNamed:@"home_city_icon"];
    [self.cityBtn addSubview:cityImage];
    [self setupRefresh];
}

#pragma mark - 上下拉刷新加载更多方法
- (void)setupRefresh {
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.tableView.mj_header = [HenewsRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    // 设置刷新显示的时间的key
    self.tableView.mj_header.lastUpdatedTimeKey = NSStringFromClass([self class]);
    [self.tableView.mj_header beginRefreshing];
}

//下拉刷新
- (void)headerRereshing {
    NSString *homeUrl = [DEF_GetHomepage stringByAppendingString:[[CityManager shareInstance] getCity]];
    [NetworkManager postRequestJsonWithURL:homeUrl params:nil delegate:self tag:requestHomeDataTag msg:0 useCache:YES update:YES showHUD:NO];
}

#pragma mark - 网络返回
- (void)requestDidFinishLoading:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg{
    if ([tag isEqualToString:requestHomeDataTag]) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.separatorColor = [UIColor colorWithHexColor:@"#c8c8c8"];
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 8, 0, 8);
        
        if (returnJson) {
            [[TierManager shareInstance] compareAndSave:[returnJson objectForKey:@"nodes"] key:Home];
            self.homeMode = [HomeMode mj_objectWithKeyValues:returnJson];
            
            NSString *tipStr = @"已为您推荐了新的内容";
            if ([self.homeMode.contIdStr isEqualToString:self.contIdStrTabel]) {
                tipStr = @"暂无新内容，休息一会儿";
            }else{
                self.contIdStrTabel = self.homeMode.contIdStr;
            }
            [self.tableView.mj_header endRefreshingWithTip:tipStr];
            
            self.orderAry = [[TierManager shareInstance] getOrderTierFromLocal:Home];
            [self dealData];
        }else{
            [self.tableView.mj_header endRefreshingWithTip:@"数据出错，正在紧急处理"];
        }
        
    }else if ([tag isEqualToString:requestChangeDataTag]){
        if (returnJson) {
            self.changeData = [ChangeDataMode mj_objectWithKeyValues:returnJson];
            NodeMode *node = [self.tableViewData objectAtIndex:msg];
            node.changeUrl = _changeData.changeUrl;
            node.newsList = _changeData.newsList;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:msg];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView reloadData];
        }
    }
}

//缓存数据返回
- (void)requestDidCacheReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger) msg {
    if ([tag isEqualToString:requestHomeDataTag]) {
        if (returnJson) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            self.tableView.separatorColor = [UIColor colorWithHexColor:@"#c8c8c8"];
            self.tableView.separatorInset = UIEdgeInsetsMake(0, 8, 0, 8);
            self.orderAry = [[TierManager shareInstance]getOrderTierFromLocal:Home];
            self.homeMode = [HomeMode mj_objectWithKeyValues:returnJson];
            [self dealData];
        }
        
    }else if ([tag isEqualToString:requestChangeDataTag]){
        if (returnJson) {
            self.changeData = [ChangeDataMode mj_objectWithKeyValues:returnJson];
            NodeMode *node = [self.tableViewData objectAtIndex:msg];
            node.changeUrl = _changeData.changeUrl;
            node.newsList = _changeData.newsList;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:msg];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

- (void)requestdidFailWithError:(NSError*)error tag:(NSString *)tag msg:(NSInteger)msg {
    if ([tag isEqualToString:requestHomeDataTag]) {
        [self.tableView.mj_header endRefreshingWithTip:@"请求超时"];
    }else if ([tag isEqualToString:requestChangeDataTag]){
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:msg];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }
}


- (void)dealData {
    if (!self.tableViewData) {
        self.tableViewData = [[NSMutableArray alloc]init];
    }
    [self.tableViewData removeAllObjects];
    if (_homeMode.banners && _homeMode.banners.count > 0) {
        NSMutableArray *bannersAry = [_homeMode.banners copy];
        [self.tableViewData addObject:bannersAry];
    }
    for (int i = 0; i < self.orderAry.count; i++) {
        TierMode *tier = [self.orderAry objectAtIndex:i];
        for (int j = 0; j < self.homeMode.nodes.count; j++) {
            NodeMode *mudel = [_homeMode.nodes objectAtIndex:j];
            if ([tier.nodeId isEqualToString:mudel.nodeId]) {
                if (mudel.nodeName && ![mudel.nodeName isEqualToString:@""]) {
                    if (([mudel.displayType intValue] == EditorRecommend && mudel.newsList && mudel.newsList.count > 0) || [mudel.displayType intValue] != EditorRecommend) {
                        [self.tableViewData addObject:mudel];
                    }
                }
            }
        }
    }
    //******
    [NetworkCache saveHttpCache:self.tableViewData forKey:NSStringFromClass([self class])];
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
        [self.view addSubview:tierManageView];
    }
    [tierManageView openTierManage:0 clickBtn:sender addImage:nil];
}

#pragma mark - TabBarBtnDelegate
- (void)tabBarBtnSelectAgain {
    if (self.tableView.contentOffset.y == 0) {
        [self.tableView.mj_header beginRefreshing];
    }else{
        canReflush = YES;
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}


#pragma mark - SectionDelegate
- (void)requestSectionChange:(NSString*)url section:(NSInteger)section {
    [NetworkManager postRequestJsonWithURL:url params:nil delegate:self tag:requestChangeDataTag msg:section useCache:NO update:YES showHUD:NO];
}
- (void)jumpToMore:(NodeMode*)node {
    NSLog(@"jumpToMore====");
}

#pragma mark - TierManageViewDelegate
- (void)whenOpenOrCloseTierManage:(BOOL)open orderTiers:(NSMutableArray*)orderTiers nodeId:(TierMode*)nodeId curClass:(NSInteger)curClass{
    XNTabBarView *tabBarViewController = (XNTabBarView*)self.tabBarController;
    if (open) {
        [tabBarViewController closeMenu];
    }else{
        [tabBarViewController openMenu];
        if (orderTiers != nil) {
            self.orderAry = orderTiers;
            [self dealData];
        }
        if (nodeId != nil) {
            canReflush = NO;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:[self inTableSectionWithTier:nodeId]];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }
}

- (NSInteger)inTableSectionWithTier:(TierMode*)tier {
    NSInteger section = 0;
    for (int i =  0; i < self.tableViewData.count; i++) {
        if ([[self.tableViewData objectAtIndex:i] isKindOfClass:[NodeMode class]]) {
            NodeMode *modul = [self.tableViewData objectAtIndex:i];
            if ([modul.nodeId isEqualToString:tier.nodeId]) {
                section = i;
                return section;
            }
        }
    }
    return section;
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableViewData.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([[self.tableViewData objectAtIndex:section] isKindOfClass:[NodeMode class]]) {
        NodeMode *modul = [self.tableViewData objectAtIndex:section];
        SectionView *view = [[SectionView loadFromNib] initWithData:modul section:section];
        view.delegate = self;
        return view;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([[self.tableViewData objectAtIndex:section] isKindOfClass:[NodeMode class]]) {
        return 26.5f;
    }else{
        return 0;
    }
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[self.tableViewData objectAtIndex:section] isKindOfClass:[NodeMode class]]) {
        NodeMode *modul = [self.tableViewData objectAtIndex:section];
        return [[NewsCellFactory shareInstance]getNumberOfRowsInSection:modul];
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[self.tableViewData objectAtIndex:indexPath.section] isKindOfClass:[NodeMode class]]) {
        NodeMode *modul = [self.tableViewData objectAtIndex:indexPath.section];
        BOOL hiddenLine = NO;
        if (modul.newsList.count == indexPath.row + 1) {
            hiddenLine = YES;
        }
        return [[NewsCellFactory shareInstance] getCell:modul row:indexPath.row tableView:tableView hiddenLine:YES isShortLine:YES];
    }else{
        NSMutableArray *banners = [self.tableViewData objectAtIndex:indexPath.section];
        BannerCell *cell = [BannerCell cellWithTableView:tableView];
        [cell setNews:banners hiddenLine:YES];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[self.tableViewData objectAtIndex:indexPath.section] isKindOfClass:[NodeMode class]]) {
        NodeMode *modul = [self.tableViewData objectAtIndex:indexPath.section];
        return [[NewsCellFactory shareInstance]getHeightForRow:modul row:indexPath.row];
    }else{
        return SCREEN_WIDTH*197.0f/320.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([[self.tableViewData objectAtIndex:indexPath.section] isKindOfClass:[NodeMode class]]) {
        NodeMode *modul = [self.tableViewData objectAtIndex:indexPath.section];
        [[NewsCellFactory shareInstance]didSelectRowAtIndexPath:modul row:indexPath.row navigation:self.navigationController];
    }
}

//setContentOffset:CGPointMake(0, 0) animated:YES动画结束回调函数
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (canReflush) {
        [self.tableView.mj_header beginRefreshing];
    }
}
@end
