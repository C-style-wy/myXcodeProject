//
//  CommentListViewController.m
//  henews250
//
//  Created by 汪洋 on 2016/11/14.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "CommentListViewController.h"
#import "CommentListSectionView.h"
#import "CommentCell.h"

static NSString * const CommentListTag = @"CommentListTag";

@interface CommentListViewController ()

@end

@implementation CommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initPage {
    [super initPage];
    self.pageTitle.text = @"评论列表";
    self.headView.shareBtn.hidden = YES;
    
    [self setupRefresh];
}

#pragma mark - 网络返回
- (void)requestDidFinishLoading:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg{
    if ([tag isEqualToString:CommentListTag]) {
        self.commentList = [CommentListMode mj_objectWithKeyValues:returnJson];
        [self.tableView.mj_header endRefreshing];
        [self handleDataBack];
    }
}
// 缓存数据返回
- (void)requestDidCacheReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger) msg {
    
}

- (void)requestdidFailWithError:(NSError*)error tag:(NSString *)tag msg:(NSInteger)msg {
    
}

- (void)handleDataBack{
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    self.tableView.separatorColor = [UIColor colorWithHexColor:@"#c8c8c8"];
//    self.tableView.separatorInset = UIEdgeInsetsMake(0, 8, 0, 8);
    [self.tableShowAry removeAllObjects];
    NSMutableArray *ary = [self.commentList.commentList copy];
    [self.tableShowAry addObject:self.commentList.hotCommentList];
    [self.tableShowAry addObject:ary];
    [self.tableView reloadData];
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.headView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-self.headView.frame.size.height-30.5f)];
        _tableView.backgroundColor = LRClearColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)tableShowAry {
    if (!_tableShowAry) {
        _tableShowAry = [[NSMutableArray alloc]init];
    }
    return _tableShowAry;
}

#pragma mark - 上下拉刷新加载更多方法
- (void)setupRefresh {
    self.tableView.mj_header = [HenewsRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [self.tableView.mj_header beginRefreshing];
}

//下拉刷新
- (void)headerRereshing {
    if (self.url && ![self.url isEqualToString:@""]) {
        [NetworkManager postRequestJsonWithURL:self.url params:nil delegate:self tag:CommentListTag msg:0 useCache:YES update:YES showHUD:NO];
    }
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableShowAry.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CommentListSectionView *view = [CommentListSectionView loadFromNib];
    view.isHot = NO;
    if (0 == section) {
        view.isHot = YES;
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 43.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (0 == section) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithHexColor:@"#dcdcdc"];
        return view;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (0 == section) {
        return 4.0f;
    }else{
        return 0;
    }
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *ary = [self.tableShowAry objectAtIndex:section];
    return ary.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *ary = [[self.tableShowAry objectAtIndex:indexPath.section] copy];
    CommentMode *commentMode = [ary objectAtIndex:indexPath.row];
    
    CommentCell *cell = [CommentCell cellWithTableView:tableView];
    cell.commentMode = commentMode;
    if (0 == indexPath.section && indexPath.row == ary.count - 1) {
        cell.hideLine = YES;
    }
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100.0f;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 78.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
