//
//  NewsViewController.m
//  henews
//
//  Created by 汪洋 on 15/10/23.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "NewsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "columStruct.h"

#import "OneSmallPicCell.h"
#import "OnlyTitleCell.h"
#import "OneBigPicCell.h"
#import "EveryOneCell.h"
#import "ThreePicCell.h"

#import "DetailViewController.h"
#import "PlayViewController.h"

#import "ProgramaStructure.h"

@interface NewsViewController ()
{
    CGFloat _beginScrollX;
}
@end

@implementation NewsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    //读取本地栏目数据，如果本地没有，则发送网络请求
    [self readLocalProDataOrRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - view初始化
-(void)initUI{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 58)];
    headView.backgroundColor = [UIColor whiteColor];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 38)];
    
    UIImageView *line = [[UIImageView alloc]init];
    line.frame = CGRectMake(0, 37.5f, SCREEN_WIDTH, 0.5f);
    line.image = [UIImage imageNamed:@"menuFenge.png"];
    [titleView addSubview:line];
    [headView addSubview:titleView];
    [self.view addSubview:headView];
    
    UIScrollView *colomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH - 53, 38)];
    colomScrollView.delegate = self;
    colomScrollView.backgroundColor = [UIColor clearColor];
    colomScrollView.showsHorizontalScrollIndicator = NO;
    colomScrollView.showsVerticalScrollIndicator = NO;
    [titleView addSubview:colomScrollView];
    self.scrollView = colomScrollView;
    
    UIImageView *classLine = [[UIImageView alloc]init];
    classLine.frame = CGRectMake(SCREEN_WIDTH - 45, 10, 1, 18.0f);
    classLine.image = [UIImage imageNamed:@"class_line.png"];
    [titleView addSubview:classLine];
    
    UIButton *channelBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 44, 0, 44, 38)];
    [channelBtn addTarget:self action:@selector(channelManage:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *addImg = [[UIImageView alloc]initWithFrame:CGRectMake(13, 10, 18, 18)];
    addImg.image = [UIImage imageNamed:@"class_add.png"];
    [channelBtn addSubview:addImg];
    [titleView addSubview:channelBtn];
    
    self.mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 58, SCREEN_WIDTH, SCREEN_HEIGHT-101)];
    [self.view addSubview:self.mainView];
    
    _firstTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _mainView.frame.size.width, _mainView.frame.size.height)];
    _middleTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, _mainView.frame.size.width, _mainView.frame.size.height)];
    _lastTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, _mainView.frame.size.width, _mainView.frame.size.height)];
    
    _firstTableView.delegate = self;
    _middleTableView.delegate = self;
    _lastTableView.delegate = self;
    
    _firstTableView.dataSource = self;
    _middleTableView.dataSource = self;
    _lastTableView.dataSource = self;
    
    _firstTableView.tag = 0;
    _middleTableView.tag = 1;
    _lastTableView.tag = 2;
    
    _firstTableView.backgroundColor = VIEWBACKGROUND_COLOR;
    _middleTableView.backgroundColor = VIEWBACKGROUND_COLOR;
    _lastTableView.backgroundColor = VIEWBACKGROUND_COLOR;
    
    _firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _middleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _lastTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_firstTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [_firstTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    [_middleTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [_middleTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    [_lastTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [_lastTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _mainView.frame.size.width, _mainView.frame.size.height)];
    [_mainView addSubview:_mainScrollView];
    _mainScrollView.delegate = self;
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.pagingEnabled = YES;
    
    _curClass = 0;
    _beginScrollX = 0;
}

#pragma mark - 网络请求返回
-(void)requestDidReturn:(NSString*)tag returnStr:(NSString*)returnStr returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg;{
    if ([tag isEqual:@"newsData"]) {
        NSArray *newsAry = [returnJson objectForKey:@"nodes"];
        ProgramaStructure *stru = [[ProgramaStructure alloc]init];
        [stru compareAndSave:newsAry];
        
        _columAry = [stru readLocadPrograma:@"newsOrder"];
        //如果_classAry没有alloc，则alloc
        if (!_classAry) {
            _classAry = [[NSMutableArray alloc]init];
        }
        for (int i=0; i < _columAry.count; i++) {
            ClassDataStru *oneClass = [[ClassDataStru alloc]init];
            columStruct *node = [_columAry objectAtIndex:i];
            oneClass.reflushUrl = node.url;
            [_classAry addObject:oneClass];
        }
        [self columScrollViewShowData];
        if (![[[_classAry objectAtIndex:_curClass] reflushUrl] isEqual:@""]) {
            [_firstTableView headerBeginRefreshing];
        }
    }else if ([tag isEqual:@"mainNewsData"]){
//        NSLog(@"=====1======");
        NSMutableArray *tempAry = (NSMutableArray*)[[_classAry objectAtIndex:msg] data];
        [tempAry removeAllObjects];
        NSArray *newsList = [returnJson objectForKey:@"newsList"];
        for (int i = 0; i < newsList.count; i++) {
            CellData *data = [[CellData alloc]init];
            [data initWithData:[newsList objectAtIndex:i]];
            if (![data.newsTitle isEqual:@""]) {
                [tempAry addObject:data];
            }
        }
        if (_firstTableView.tag == msg) {
            [_firstTableView reloadData];
            [_firstTableView headerEndRefreshing];
        }else if (_middleTableView.tag == msg){
            [_middleTableView reloadData];
            [_middleTableView headerEndRefreshing];
        }else if (_lastTableView.tag == msg){
            [_lastTableView reloadData];
            [_lastTableView headerEndRefreshing];
        }
        //把是否需要主动刷新标志设为false
        ClassDataStru *cds = [_classAry objectAtIndex:msg];
        cds.needReflush = NO;
        cds.loadingMoreUrl = [returnJson objectForKey:@"nextUrl"];
    }else if ([tag isEqual:@"addNewsData"]){
        NSMutableArray *tempAry = (NSMutableArray*)[[_classAry objectAtIndex:msg] data];
        NSArray *newsList = [returnJson objectForKey:@"newsList"];
        for (int i = 0; i < newsList.count; i++) {
            CellData *data = [[CellData alloc]init];
            [data initWithData:[newsList objectAtIndex:i]];
            if (![data.newsTitle isEqual:@""]) {
                [tempAry addObject:data];
            }
        }
        
        if (_firstTableView.tag == msg) {
            [_firstTableView reloadData];
            [_firstTableView footerEndRefreshing];
        }else if (_middleTableView.tag == msg){
            [_middleTableView reloadData];
            [_middleTableView footerEndRefreshing];
        }else if (_lastTableView.tag == msg){
            [_lastTableView reloadData];
            [_lastTableView footerEndRefreshing];
        }
        //把是否需要主动刷新标志设为false
        ClassDataStru *cds = [_classAry objectAtIndex:msg];
        cds.loadingMoreUrl = [returnJson objectForKey:@"nextUrl"];
    }
}

#pragma mark - 读取本地栏目数据或者发送请求
-(void)readLocalProDataOrRequest{
    ProgramaStructure *proStru = [[ProgramaStructure alloc]init];
    if ([proStru readLocadPrograma:@"newsOrder"]) {
        _columAry = [proStru readLocadPrograma:@"newsOrder"];
        //如果_classAry没有alloc，则alloc
        if (!_classAry) {
            _classAry = [[NSMutableArray alloc]init];
        }
        for (int i=0; i < _columAry.count; i++) {
            ClassDataStru *oneClass = [[ClassDataStru alloc]init];
            columStruct *node = [_columAry objectAtIndex:i];
            oneClass.reflushUrl = node.url;
            [_classAry addObject:oneClass];
        }
        [self columScrollViewShowData];
        if (![[[_classAry objectAtIndex:_curClass] reflushUrl] isEqual:@""]) {
            [_firstTableView headerBeginRefreshing];
        }
    }else{
        NSString *url = [GET_SERVER stringByAppendingString:GET_NEWS_URL];
        [Request requestPostForJSON:@"newsData" url:url delegate:self paras:nil msg:0];
    }
}

#pragma mark - 给colum ScrollView加载数据
-(void)columScrollViewShowData{
    if (self.columAry.count > 0) {
        //每个栏目的起始位置x
        CGFloat labelX = 0;
        //每个栏目的宽度
        CGFloat labelW = 0;
        for (int i = 0; i<_columAry.count; i++) {
            UIButton *button = [[UIButton alloc]init];
            
            UIFont *fnt = [UIFont systemFontOfSize:17.0f];
            NSDictionary *attribute = @{NSFontAttributeName: fnt};
            CGFloat textSize = TEXTWIDTH([[_columAry objectAtIndex:i] nodeName], attribute, 38);
            
            labelW = textSize + 25;
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, labelW, 38)];
            label.tag = 1001;
            button.frame = CGRectMake(labelX, 0, labelW, 38);
            [button addSubview:label];
            labelX += labelW;
            label.font = fnt;
            label.text = [[_columAry objectAtIndex:i] nodeName];
            label.textColor = [UIColor blackColor];
            if (i == _curClass) {
                label.textColor = ROSERED;
                _preClassLabel = label;
            }
            button.tag = i;
            [button addTarget:self action:@selector(classBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:button];
        }
        self.scrollView.contentSize = CGSizeMake(labelX, 0);
    }
    if (_columAry.count == 1) {
        _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 0);
        [_mainScrollView addSubview:_firstTableView];
    }else if (_columAry.count == 2){
        _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, 0);
        [_mainScrollView addSubview:_firstTableView];
        [_mainScrollView addSubview:_middleTableView];
    }else{
        _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, 0);
        [_mainScrollView addSubview:_firstTableView];
        [_mainScrollView addSubview:_middleTableView];
        [_mainScrollView addSubview:_lastTableView];
    }
}

- (void)classBtnClick:(UIButton *)button {
    NSLog(@"栏目按钮");
    _preClassLabel.textColor = [UIColor blackColor];
    UILabel *label = (UILabel *)[button viewWithTag:1001];
    label.textColor = ROSERED;
    _preClassLabel = label;
    //是要实现动画效果
//    if (button.tag > _curClass) {
//        [_mainScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*2, 0) animated:YES];
//    }else{
//        [_mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    }
    _curClass = button.tag;
    //scrollView的偏移量
    CGFloat offsetX = _scrollView.contentOffset.x;
    //该button的起始位置x
    CGFloat btnX = button.frame.origin.x;
    //该button的宽度
    CGFloat btnW = button.frame.size.width;
    //_scrollView的宽度
    CGFloat scroW = _scrollView.frame.size.width;
//    NSLog(@"offsetX=%f", offsetX);
//    NSLog(@"btnX=%f", btnX);
//    NSLog(@"btnW=%f", btnW);
//    NSLog(@"scroW=%f", scroW);
    if (_curClass == 0) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else{
        if (btnW + btnX - offsetX > scroW) {
            CGFloat setW = btnW + btnX  - scroW;
//            NSLog(@"setW=%f", setW);
            [_scrollView setContentOffset:CGPointMake(setW, 0) animated:YES];
        }else if (btnX - offsetX < 0){
            CGFloat setW = btnX;
            [_scrollView setContentOffset:CGPointMake(setW, 0) animated:YES];
        }
    }
    [self reloadScrollView];
}

- (void)channelManage:(UIButton *)button {
    NSLog(@"频道管理");
}

#pragma mark - 下拉、上拉刷新
//下拉刷新
- (void)headerRereshing
{
    NSString *url = [[_classAry objectAtIndex:_curClass] reflushUrl];
    [Request requestPostForJSON:@"mainNewsData" url:url delegate:self paras:nil msg:_curClass];
}

//上拉加载
- (void)footerRereshing
{
    NSString *url = [[_classAry objectAtIndex:_curClass] loadingMoreUrl];
    [Request requestPostForJSON:@"addNewsData" url:url delegate:self paras:nil msg:_curClass];
}

#pragma mark - scrollView
//scrollView开始滑动
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _mainScrollView) {
//        _beginScrollX = _mainScrollView.contentOffset.x;
    }
}
//scrollView停止滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //得到当前页数
    if (scrollView == _mainScrollView) {
        float x = _mainScrollView.contentOffset.x;
        if (x > _beginScrollX) {
            _curClass ++;
//            [self reloadScrollView];
            UIButton *btn = (UIButton *)[_scrollView viewWithTag:_curClass];
            [self classBtnClick:btn];
        }else if(x < _beginScrollX){
            _curClass --;
//            [self reloadScrollView];
            UIButton *btn = (UIButton *)[_scrollView viewWithTag:_curClass];
            [self classBtnClick:btn];
        }
    }
//    NSLog(@"_curClass=end=%li", (long)_curClass);
    //滑动TableView时记录滚动的位置
    if (scrollView == _firstTableView || scrollView == _middleTableView || scrollView  == _lastTableView) {
        float y = scrollView.contentOffset.y;
//        NSLog(@"table==y==%f", y);
        if (y < 0) {
            y = 0;
        }
        int index = (int)scrollView.tag;
        ClassDataStru *stru = [_classAry objectAtIndex:index];
        stru.curPosition = y;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //滑动TableView时记录滚动的位置
    if (scrollView == _firstTableView || scrollView == _middleTableView || scrollView  == _lastTableView) {
        float y = scrollView.contentOffset.y;
        if (y < 0) {
            y = 0;
        }
        int index = (int)scrollView.tag;
        ClassDataStru *stru = [_classAry objectAtIndex:index];
        stru.curPosition = y;
    }
}

-(void)reloadScrollView{
    if (_curClass == 0) {
        _firstTableView.tag = 0;
        _middleTableView.tag = 1;
        _lastTableView.tag = 2;
        _mainScrollView.contentOffset = CGPointMake(0, 0);
        _beginScrollX = 0.0f;
    }else if (_curClass == [_classAry count] - 1){
        _firstTableView.tag = _curClass-2;
        _middleTableView.tag = _curClass-1;
        _lastTableView.tag = _curClass;
        _mainScrollView.contentOffset = CGPointMake(SCREEN_WIDTH*2, 0);
        _beginScrollX = SCREEN_WIDTH*2;
    }else{
        _firstTableView.tag = _curClass-1;
        _middleTableView.tag = _curClass;
        _lastTableView.tag = _curClass+1;
        _mainScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        _beginScrollX = SCREEN_WIDTH;
    }
    [self reloadTableViewData];
}
-(void)reloadTableViewData{
    int index1 = (int)_firstTableView.tag;
    int index2 = (int)_middleTableView.tag;
    int index3 = (int)_lastTableView.tag;
    [_firstTableView reloadData];
    [_middleTableView reloadData];
    [_lastTableView reloadData];
    if ([[_classAry objectAtIndex:index1] needReflush]) {
        if (_curClass == 0) {
            [_firstTableView headerBeginRefreshing];
        }
    }else{
        _firstTableView.contentOffset = CGPointMake(0, [[_classAry objectAtIndex:index1] curPosition]);
    }
    
    if ([[_classAry objectAtIndex:index2] needReflush]) {
        [_middleTableView headerBeginRefreshing];
    }else{
        _middleTableView.contentOffset = CGPointMake(0, [[_classAry objectAtIndex:index2] curPosition]);
    }
    
    if ([[_classAry objectAtIndex:index3] needReflush]) {
        if (_curClass == [_classAry count] - 1) {
            [_lastTableView headerBeginRefreshing];
        }
    }else{
        _lastTableView.contentOffset = CGPointMake(0, [[_classAry objectAtIndex:index3] curPosition]);
    }
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"table=numberOfRowsInSection==");
    return [(NSMutableArray*)[[_classAry objectAtIndex:tableView.tag] data] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"table=cellForRowAtIndexPath==%li", tableView.tag);
    NSMutableArray *tempAry = (NSMutableArray*)[[_classAry objectAtIndex:tableView.tag] data];
    CellData *oneCell = [tempAry objectAtIndex:indexPath.row];
    if ([oneCell.displayType isEqual:ONE_SMALL_PIC]) {   //一张小图
        OneSmallPicCell *cell = [OneSmallPicCell cellWithTableView:tableView];
        [cell loadTableCell:oneCell];
        return cell;
    }else if ([oneCell.displayType isEqual:ONE_BIG_PIC] || [oneCell.displayType isEqual:NEWS_EARLY_BUS]){                        //一张大图和新闻早班车
        OneBigPicCell *cell = [OneBigPicCell cellWithTableView:tableView];
        [cell loadTableCell:oneCell];
        return cell;
    }else if ([oneCell.displayType isEqual:EVERY_ONE] || [oneCell.displayType isEqual:EVERY_ONE_G]){                                 //大家和感性
        EveryOneCell *cell = [EveryOneCell cellWithTableView:tableView];
        [cell loadTableCell:oneCell];
        return cell;
    }else if ([oneCell.displayType isEqual:THREE_SMALL_PIC]){  //三张小图
        ThreePicCell *cell = [ThreePicCell cellWithTableView:tableView];
        [cell loadTableCell:oneCell];
        return cell;
    }
    else{                          //无图
        OnlyTitleCell *cell = [OnlyTitleCell cellWithTableView:tableView];
        [cell loadTableCell:oneCell];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"table=heightForRowAtIndexPath==%li", tableView.tag);
    NSMutableArray *tempAry = (NSMutableArray*)[[_classAry objectAtIndex:tableView.tag] data];
    CellData *data = [tempAry objectAtIndex:indexPath.row];
    return data.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ClassDataStru *stru = [_classAry objectAtIndex:tableView.tag];
    NSMutableArray *ary = stru.data;
    CellData *cell = [ary objectAtIndex:indexPath.row];
    NSString *url = cell.url;
    
    if ([cell.newsType isEqual:@"1"]) {
        PlayViewController *play = [[PlayViewController alloc] init];
        self.delegate = play;
        [self.delegate getUrl:url];
        
        [self.navigationController pushViewController:play animated:YES];
    }else{
        DetailViewController *detail = [[DetailViewController alloc] init];
        self.delegate = detail;
        [self.delegate getUrl:url];

        [self.navigationController pushViewController:detail animated:YES];
    }
}

#pragma mark - reflushDelegate
-(void)reflushTableView{
    NSLog(@"刷新列表===");
}

@end
