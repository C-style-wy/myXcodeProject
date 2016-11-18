//
//  TopicViewController.m
//  henews250
//
//  Created by 汪洋 on 16/9/19.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TopicViewController.h"
#import "TopicSubViewController.h"

static NSString * const TopicRequestKey = @"topicRequestKey";

@interface TopicViewController ()

@end

@implementation TopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initPage {
    [super initPage];
    NSString *str = @"和新闻 · 专题";
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:str];
    [text addAttribute:NSForegroundColorAttributeName value:MainColor range:NSMakeRange(5, 3)];
    self.pageTitle.attributedText = text;
    
    [self setupRefresh];
}

#pragma mark - 懒加载
- (NSMutableArray *)pageData {
    if (!_pageData) {
        _pageData = [[NSMutableArray alloc]init];
    }
    return _pageData;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.headView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-self.headView.frame.size.height)];
        _tableView.backgroundColor = LRClearColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - 上下拉刷新加载更多方法
- (void)setupRefresh {
    self.tableView.mj_header = [HenewsRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [self.tableView.mj_header beginRefreshing];
}

//下拉刷新
- (void)headerRereshing {
    if (self.url && ![self.url isEqualToString:@""]) {
        [NetworkManager postRequestJsonWithURL:self.url params:nil delegate:self tag:TopicRequestKey msg:0 useCache:YES update:YES showHUD:NO];
    }
}

#pragma mark - 网络返回
- (void)requestDidFinishLoading:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg{
    if ([tag isEqualToString:TopicRequestKey]) {
        [self.tableView.mj_header endRefreshing];
        [self handleRequestBack:returnJson];
    }
}

//缓存数据返回
- (void)requestDidCacheReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger) msg {
    if ([tag isEqualToString:TopicRequestKey]) {
        [self handleRequestBack:returnJson];
    }
}

- (void)requestdidFailWithError:(NSError*)error tag:(NSString *)tag msg:(NSInteger)msg {
    if ([tag isEqualToString:TopicRequestKey]) {
        [self.tableView.mj_header endRefreshing];
    }
}

- (void)handleRequestBack:(NSDictionary*)data {
    if (data) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.separatorColor = [UIColor colorWithHexColor:@"#c8c8c8"];
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 8, 0, 8);
        
        self.topicModel = [TopicModel mj_objectWithKeyValues:data];
        [self.pageData removeAllObjects];
        TopicTitleModel *topicTitle = [[TopicTitleModel alloc]initWithData:self.topicModel];
        [self.pageData addObject:topicTitle];
        for (int i = 0; i < self.topicModel.specialNodeList.count; i++) {
            SpecialNodeListModel *specialNode = [self.topicModel.specialNodeList objectAtIndex:i];
            [self.pageData addObject:specialNode];
        }
        [self.tableView reloadData];
    }
}

#pragma mark - TopicSectionViewDelegate
- (void)sectionBtnAction:(NSString*)url name:(NSString *)name {
    TopicSubViewController *topicSubViewController = [[TopicSubViewController alloc]init];
    topicSubViewController.url = url;
    topicSubViewController.subTopicTitle = name;
    [self.navigationController pushViewController:topicSubViewController animated:YES];
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.pageData.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([[self.pageData objectAtIndex:section] isKindOfClass:[SpecialNodeListModel class]]) {
        SpecialNodeListModel *specialNodeListModel = [self.pageData objectAtIndex:section];
        TopicSectionView *view = [TopicSectionView loadFromNib];
        view.delegate = self;
        view.specialNodeListModel = specialNodeListModel;
        return view;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([[self.pageData objectAtIndex:section] isKindOfClass:[SpecialNodeListModel class]]) {
        return 27.0f;
    }else{
        return 0;
    }
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[self.pageData objectAtIndex:section] isKindOfClass:[SpecialNodeListModel class]]) {
        SpecialNodeListModel *specialNodeListModel = [self.pageData objectAtIndex:section];
        return specialNodeListModel.newsList.count;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[self.pageData objectAtIndex:indexPath.section] isKindOfClass:[SpecialNodeListModel class]]) {
        SpecialNodeListModel *specialNodeListModel = [self.pageData objectAtIndex:indexPath.section];
        NewsMode *news = [specialNodeListModel.newsList objectAtIndex:indexPath.row];
        return [[NewsCellFactory shareInstance] getCell:news tableView:tableView hiddenLine:YES isShortLine:YES];
    }else{
        TopicTitleModel *title = [self.pageData objectAtIndex:indexPath.section];
        TopicTitleCell *cell = [TopicTitleCell cellWithTableView:tableView];
        TopicTitleFrame *frame = [[TopicTitleFrame alloc]init];
        frame.topicTitleModel = title;
        cell.topicTitleFrame = frame;
        return cell;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100.0f;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[self.pageData objectAtIndex:indexPath.section] isKindOfClass:[SpecialNodeListModel class]]) {
        SpecialNodeListModel *specialNodeListModel = [self.pageData objectAtIndex:indexPath.section];
        NewsMode *news = [specialNodeListModel.newsList objectAtIndex:indexPath.row];
        return [[NewsCellFactory shareInstance] getHeightForRow:news];
    }else{
        TopicTitleModel *title = [self.pageData objectAtIndex:indexPath.section];
        TopicTitleFrame *frame = [[TopicTitleFrame alloc]init];
        frame.topicTitleModel = title;
        return frame.cellHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([[self.pageData objectAtIndex:indexPath.section] isKindOfClass:[SpecialNodeListModel class]]) {
        SpecialNodeListModel *specialNodeListModel = [self.pageData objectAtIndex:indexPath.section];
        NewsMode *news = [specialNodeListModel.newsList objectAtIndex:indexPath.row];
        
        [[NewsCellFactory shareInstance]didSelectRowAtIndexPath:indexPath news:news tableView:tableView navigation:self.navigationController];
        [self.tableView reloadData];
    }
}
@end
