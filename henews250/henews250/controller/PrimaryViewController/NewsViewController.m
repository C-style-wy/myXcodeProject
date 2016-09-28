//
//  NewsViewController.m
//  henews250
//
//  Created by 汪洋 on 16/7/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCellFactory.h"

static NSString * const keyOrderAry = @"orderAry";
static NSString * const keyCurClass = @"curClass";
@interface NewsViewController () {
    CGFloat _beginScrollX;
    NSTimer *_timer;
    
    TierManageView *tierManageView;
    //置顶时是否刷新
    BOOL canReflush;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
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
//    self.firstTableView.mj_footer.automaticallyHidden = YES;
    
    self.middleTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.middleTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
//    self.middleTableView.mj_footer.automaticallyHidden = YES;
    
    self.lastTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.lastTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
//    self.lastTableView.mj_footer.automaticallyHidden = YES;
    
    self.curClass = 0;
    _beginScrollX = 0;
    self.orderAry = [[NSMutableArray alloc]init];
    [self addObserver:self forKeyPath:keyOrderAry options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:keyCurClass options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    //读取本地栏目数据，如果本地没有，则发送网络请求
    [self readLocalOrderTiersDataOrRequest];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:keyOrderAry]) {
        NSMutableArray *newArray = [change objectForKey:NSKeyValueChangeNewKey];
        NSMutableArray *oldArray = [change objectForKey:NSKeyValueChangeOldKey];
        if (![self compareArray:newArray to:oldArray]) {
            [self compareClassInfoAryWithOrderAry];
        }
    }
    if ([keyPath isEqualToString:keyCurClass]) {
//        NSInteger newValue = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
//        NSInteger oldValue = [[change objectForKey:NSKeyValueChangeOldKey] integerValue];
//        if (newValue != oldValue) {
            [self handleCurClassChange];
        
//        }
    }
}

- (void)readLocalOrderTiersDataOrRequest{
    NSMutableArray *orderArray = [[TierManager shareInstance] getOrderTierFromLocal:News];
    if (orderArray && orderArray.count != 0) {
        self.orderAry = orderArray;
    }else{
        NSString *newsPageUrl = [DEF_GetNewspage stringByAppendingString:[[CityManager shareInstance] getCity]];
        [NetworkManager postRequestJsonWithURL:newsPageUrl params:nil delegate:self tag:@"newsPageData" msg:0 useCache:NO update:YES showHUD:NO];
    }
}

#pragma mark - 网络返回
- (void)requestDidFinishLoading:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg{
    if ([tag isEqualToString:@"newsPageData"]) {
        NSArray *newsAry = [returnJson objectForKey:@"nodes"];
        [[TierManager shareInstance]compareAndSave:newsAry key:News];
        self.orderAry = [[TierManager shareInstance] getOrderTierFromLocal:News];
    }
    if ([tag isEqualToString:@"mainNewsData"]) {
        [self handleMainNewsData:returnJson withMsg:msg];
        if (_firstTableView.tag == msg) {
            [_firstTableView.mj_header endRefreshing];
        }else if (_middleTableView.tag == msg){
            [_middleTableView.mj_header endRefreshing];
        }else if (_lastTableView.tag == msg){
            [_lastTableView.mj_header endRefreshing];
        }
        ClassInfoMode *classInfo = [self.classInfoAry objectAtIndex:msg];
        classInfo.needReflush = NO;
    }
    if ([tag isEqualToString:@"addNewsData"]) {
        [self handleAddNewsData:returnJson withMsg:msg];
    }
}

//缓存数据返回
- (void)requestDidCacheReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger) msg {
    if ([tag isEqualToString:@"mainNewsData"]) {
        [self handleMainNewsData:returnJson withMsg:msg];
    }
}

- (void)requestdidFailWithError:(NSError*)error tag:(NSString *)tag msg:(NSInteger)msg {
    if ([tag isEqualToString:@"mainNewsData"]) {
        if (_firstTableView.tag == msg) {
            [_firstTableView.mj_header endRefreshing];
        }else if (_middleTableView.tag == msg){
            [_middleTableView.mj_header endRefreshing];
        }else if (_lastTableView.tag == msg){
            [_lastTableView.mj_header endRefreshing];
        }
    }
    if ([tag isEqualToString:@"addNewsData"]) {
        if (_firstTableView.tag == msg) {
            [_firstTableView.mj_footer endRefreshing];
        }else if (_middleTableView.tag == msg){
            [_middleTableView.mj_footer endRefreshing];
        }else if (_lastTableView.tag == msg){
            [_lastTableView.mj_footer endRefreshing];
        }
    }
}

- (void)handleMainNewsData:(NSDictionary*)data withMsg:(NSInteger)msg{
    ClassInfoMode *classInfo = [self.classInfoAry objectAtIndex:msg];
    NSMutableArray *tempAry = classInfo.loadData;
    InforMode *inforData = [InforMode mj_objectWithKeyValues:data];
    [tempAry removeAllObjects];
    if (inforData.banners && inforData.banners.count > 0) {
        NSMutableArray *bannersAry = [inforData.banners copy];
        [tempAry addObject:bannersAry];
    }
    for (int i = 0; i < inforData.newsList.count; i++) {
        NewsMode *newsData = [inforData.newsList objectAtIndex:i];
        if (newsData.newsTitle && ![newsData.newsTitle isEqualToString:@""]) {
            [tempAry addObject:newsData];
        }
    }
    if ([inforData.isLastPage isEqualToString:@"1"]) {
        classInfo.isLastPage = YES;
    }else{
        classInfo.isLastPage = NO;
        classInfo.loadingMoreUrl = inforData.nextUrl;
    }
    if (_firstTableView.tag == msg) {
        [_firstTableView reloadData];
    }else if (_middleTableView.tag == msg){
        [_middleTableView reloadData];
    }else if (_lastTableView.tag == msg){
        [_lastTableView reloadData];
    }
    [self hideOrShowSeparatorStyleLine];
}

- (void)handleAddNewsData:(NSDictionary*)data withMsg:(NSInteger)msg{
    ClassInfoMode *classInfo = [self.classInfoAry objectAtIndex:msg];
    NSMutableArray *tempAry = classInfo.loadData;
    InforMode *inforData = [InforMode mj_objectWithKeyValues:data];

    for (int i = 0; i < inforData.newsList.count; i++) {
        NewsMode *newsData = [inforData.newsList objectAtIndex:i];
        BOOL isNotHave = YES;
        for (int j = 0; j < tempAry.count; j++) {
            if ([[tempAry objectAtIndex:j] isKindOfClass:[NewsMode class]]) {
                NewsMode *newsItem = [tempAry objectAtIndex:j];
                if ([newsItem.newsId isEqualToString:newsData.newsId]) {
                    isNotHave = NO;
                    break;
                }
            }
        }
        if (isNotHave && newsData.newsTitle && ![newsData.newsTitle isEqualToString:@""]) {
            [tempAry addObject:newsData];
        }
    }
    if ([inforData.isLastPage isEqualToString:@"1"]) {
        classInfo.isLastPage = YES;
    }else{
        classInfo.isLastPage = NO;
        classInfo.loadingMoreUrl = inforData.nextUrl;
    }
    if (_firstTableView.tag == msg) {
        [_firstTableView.mj_footer endRefreshing];
        [_firstTableView reloadData];
    }else if (_middleTableView.tag == msg){
        [_middleTableView.mj_footer endRefreshing];
        [_middleTableView reloadData];
    }else if (_lastTableView.tag == msg){
        [_lastTableView.mj_footer endRefreshing];
        [_lastTableView reloadData];
    }
}

- (void)addSeparatorStyleLineWithTableView:(UITableView*)tableView {
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorColor = [UIColor colorWithHexColor:@"#c8c8c8"];
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)hideOrShowSeparatorStyleLine {
    int index1 = (int)_firstTableView.tag;
    int index2 = (int)_middleTableView.tag;
    int index3 = (int)_lastTableView.tag;
    ClassInfoMode *info1 = [self.classInfoAry objectAtIndex:index1];
    ClassInfoMode *info2 = [self.classInfoAry objectAtIndex:index2];
    ClassInfoMode *info3 = [self.classInfoAry objectAtIndex:index3];
    
//    if (info1.isLastPage) {
//        _firstTableView.mj_footer = nil;
//    }else{
//        self.firstTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
//    }
//    if (info2.isLastPage) {
//        _middleTableView.mj_footer = nil;
//    }else{
//        self.middleTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
//    }
//    if (info3.isLastPage) {
//        _lastTableView.mj_footer = nil;
//    }else{
//        self.lastTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
//    }
    
    if (info1.loadData.count == 0) {
        _firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _firstTableView.mj_footer.automaticallyHidden = YES;
    }else{
        [self addSeparatorStyleLineWithTableView:_firstTableView];
        _firstTableView.mj_footer.automaticallyHidden = NO;
    }
    if (info2.loadData.count == 0) {
        _middleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _middleTableView.mj_footer.automaticallyHidden = YES;
    }else{
        [self addSeparatorStyleLineWithTableView:_middleTableView];
        _middleTableView.mj_footer.automaticallyHidden = NO;
    }
    if (info3.loadData.count == 0) {
        _lastTableView.mj_footer.automaticallyHidden = YES;
        _lastTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }else{
        _lastTableView.mj_footer.automaticallyHidden = NO;
        [self addSeparatorStyleLineWithTableView:_lastTableView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TabBarBtnDelegate
- (void)tabBarBtnSelectAgain {
    NSLog(@"news===tabBarBtnSelectAgain=====");
}
- (IBAction)classAddBtnSelect:(id)sender {
    if (tierManageView == nil) {
        tierManageView = [[TierManageView loadFromNib] initWithName:News];
        tierManageView.frame = CGRectMake(0, 53, SCREEN_WIDTH, SCREEN_HEIGHT-53);
        tierManageView.delegate = self;
        [self.view addSubview:tierManageView];
    }
    [tierManageView openTierManage:self.curClass clickBtn:nil addImage:self.addImage];
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
        }
        if (nodeId != nil) {
            canReflush = NO;
        }
        if (orderTiers) {
            self.orderAry = orderTiers;
        }
        self.curClass = curClass;
    }
}

#pragma mark -  //下拉刷新\上拉加载下一页
- (void)headerRereshing{
    ClassInfoMode *classInfo = [self.classInfoAry objectAtIndex:self.curClass];
    [NetworkManager postRequestJsonWithURL:classInfo.tier.url params:nil delegate:self tag:@"mainNewsData" msg:self.curClass useCache:YES update:YES showHUD:NO];
}

//上拉加载下一页
- (void)footerRereshing {
    ClassInfoMode *classInfo = [self.classInfoAry objectAtIndex:self.curClass];
    if (!classInfo.isLastPage) {
        [NetworkManager postRequestJsonWithURL:classInfo.loadingMoreUrl params:nil delegate:self tag:@"addNewsData" msg:self.curClass useCache:NO update:YES showHUD:NO];
    }
}


#pragma mark - scrollView
//scrollView停止滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.mainScrollView) {
        float x = self.mainScrollView.contentOffset.x;
        if (x > _beginScrollX) {
            self.curClass = self.curClass + 1;
        }else if (x < _beginScrollX){
            self.curClass = self.curClass - 1;
        }
    }
    if (scrollView == self.firstTableView || scrollView == self.middleTableView || scrollView == self.lastTableView) {
        float y = scrollView.contentOffset.y;
        if (y < 0) {
            y = 0;
        }
        int index = (int)scrollView.tag;
        ClassInfoMode *classInfo = [self.classInfoAry objectAtIndex:index];
        classInfo.curPosition = y;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == self.firstTableView || scrollView == self.middleTableView || scrollView == self.lastTableView) {
        float y = scrollView.contentOffset.y;
        if (y < 0) {
            y = 0;
        }
        int index = (int)scrollView.tag;
        ClassInfoMode *classInfo = [self.classInfoAry objectAtIndex:index];
        classInfo.curPosition = y;
    }
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ClassInfoMode *classInfo = [self.classInfoAry objectAtIndex:tableView.tag];
    return classInfo.loadData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *tempAry = (NSMutableArray*)[[self.classInfoAry objectAtIndex:tableView.tag] loadData];
    if ([[tempAry objectAtIndex:indexPath.row] isKindOfClass:[NewsMode class]]) {
        NewsMode *news = [tempAry objectAtIndex:indexPath.row];
        return [[NewsCellFactory shareInstance] getCell:news tableView:tableView hiddenLine:YES isShortLine:NO];
    }else{
        NSMutableArray *banners = [tempAry objectAtIndex:indexPath.row];
        BannerCell *cell = [BannerCell cellWithTableView:tableView];
        [cell setNews:banners hiddenLine:YES];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *tempAry = (NSMutableArray*)[[self.classInfoAry objectAtIndex:tableView.tag] loadData];
    if ([[tempAry objectAtIndex:indexPath.row] isKindOfClass:[NewsMode class]]) {
        NewsMode *news = [tempAry objectAtIndex:indexPath.row];
        return [[NewsCellFactory shareInstance]getHeightForRow:news];
    }else{
        return SCREEN_WIDTH*197.0f/320.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableArray *tempAry = (NSMutableArray*)[[self.classInfoAry objectAtIndex:tableView.tag] loadData];
    if ([[tempAry objectAtIndex:indexPath.row] isKindOfClass:[NewsMode class]]) {
        NewsMode *news = [tempAry objectAtIndex:indexPath.row];
        [[NewsCellFactory shareInstance]didSelectRowAtIndexPath:news navigation:self.navigationController];
    }
}

#pragma mark - 比较两数组是否相同
- (BOOL)compareArray:(NSMutableArray*)ary1 to:(NSMutableArray*)ary2 {
    BOOL isSame = YES;
    if (ary1.count != ary2.count) {
        isSame = NO;
        return isSame;
    }
    if (ary1.count == ary2.count) {
        for (int i = 0; i < ary1.count; i++) {
            TierMode *mode1 = [ary1 objectAtIndex:i];
            TierMode *mode2 = [ary2 objectAtIndex:i];
            if (![mode1.nodeId isEqualToString:mode2.nodeId]) {
                isSame = NO;
                return isSame;
            }
        }
    }
    return isSame;
}

#pragma mark - 比较ClassInfoAry和OrderAry
- (void)compareClassInfoAryWithOrderAry {
    if (!self.classInfoAry) {
        self.classInfoAry = [[NSMutableArray alloc]init];
    }
    if (self.classInfoAry.count == 0) {
        for (int i = 0; i < self.orderAry.count; i++) {
            TierMode *tier = [self.orderAry objectAtIndex:i];
            ClassInfoMode *classInfo = [[ClassInfoMode alloc]init];
            classInfo.tier = tier;
            [self.classInfoAry addObject:classInfo];
        }
        [self classScrollViewShowData];
        self.curClass = 0;
    }else {
        NSMutableArray *newClassInfoAry = [[NSMutableArray alloc]init];
        for (int i = 0; i < self.orderAry.count; i++) {
            TierMode *tier = [self.orderAry objectAtIndex:i];
            NSInteger position = [self inClassInfoAry:self.classInfoAry WithTier:tier];
            if (position == -1) {
                ClassInfoMode *classInfo = [[ClassInfoMode alloc]init];
                classInfo.tier = tier;
                [newClassInfoAry addObject:classInfo];
            }else{
                ClassInfoMode *classInfo = [self.classInfoAry objectAtIndex:position];
                [newClassInfoAry addObject:classInfo];
            }
        }
        self.classInfoAry = newClassInfoAry;
        [self classScrollViewShowData];
    }
}

- (NSInteger)inClassInfoAry:(NSMutableArray*)ary WithTier:(TierMode*)tier {
    NSInteger position = -1;
    for (int i =  0; i < ary.count; i++) {
        ClassInfoMode *classInfo = [ary objectAtIndex:i];
        if ([classInfo.tier.nodeId isEqualToString:tier.nodeId]) {
            position = i;
            return position;
        }
    }
    return position;
}

#pragma mark - 给colum ScrollView加载数据
-(void)classScrollViewShowData{
    if (self.classInfoAry.count > 0) {
        //每个栏目的起始位置x
        CGFloat labelX = 0;
        //每个栏目的宽度
        CGFloat labelW = 0;
        [self.classScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        for (int i = 0; i<self.classInfoAry.count; i++) {
            ClassInfoMode *classInfo = [self.classInfoAry objectAtIndex:i];
            
            UIButton *button = [[UIButton alloc]init];
            UIFont *fnt = [UIFont systemFontOfSize:17.0f];
            NSDictionary *attribute = @{NSFontAttributeName: fnt};
            CGFloat textSize = TEXTWIDTH(classInfo.tier.nodeName, attribute, 33);
            labelW = textSize + 25;
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, labelW, 33)];
            label.backgroundColor = LRClearColor;
            label.tag = 1001;
            button.frame = CGRectMake(labelX, 0, labelW, 33);
            [button addSubview:label];
            labelX += labelW;
            label.font = fnt;
            label.text = classInfo.tier.nodeName;
            label.textColor = [UIColor blackColor];
            if (i == self.curClass) {
                label.textColor = MainColor;
                _preClassLabel = label;
            }
            button.tag = i;
            [button addTarget:self action:@selector(classBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.classScrollView addSubview:button];
        }
        self.classScrollView.contentSize = CGSizeMake(labelX, 0);
    }
    if (self.classInfoAry.count == 1) {
        _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 0);
        [_mainScrollView addSubview:_firstTableView];
    }else if (self.classInfoAry.count == 2){
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
    self.curClass = button.tag;
}

- (void)handleCurClassChange {
    //把之前高亮的按钮变为黑色
    self.preClassLabel.textColor = [UIColor blackColor];
    //获取到当前高亮的按钮并设为高亮
    UIButton *curBtn = (UIButton *)[self.classScrollView viewWithTag:self.curClass];
    UILabel *label = (UILabel *)[curBtn viewWithTag:1001];
    label.textColor = MainColor;
    _preClassLabel = label;
    
    //scrollView的偏移量
    CGFloat offsetX = self.classScrollView.contentOffset.x;
    //该button的起始位置x
    CGFloat btnX = curBtn.frame.origin.x;
    //该button的宽度
    CGFloat btnW = curBtn.frame.size.width;
    //_scrollView的宽度
    CGFloat scroW = self.classScrollView.frame.size.width;
    if (self.curClass == 0) {
        [self.classScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else{
        if (btnW + btnX - offsetX > scroW) {
            CGFloat setW = btnW + btnX  - scroW;
            [self.classScrollView setContentOffset:CGPointMake(setW, 0) animated:YES];
        }else if (btnX - offsetX < 0){
            CGFloat setW = btnX;
            [self.classScrollView setContentOffset:CGPointMake(setW, 0) animated:YES];
        }
    }
    [self reloadScrollView];
}

-(void)reloadScrollView{
    if (self.curClass == 0) {
        _firstTableView.tag = 0;
        _middleTableView.tag = 1;
        _lastTableView.tag = 2;
        _mainScrollView.contentOffset = CGPointMake(0, 0);
        _beginScrollX = 0.0f;
    }else if (self.curClass == [self.classInfoAry count] - 1){
        _firstTableView.tag = self.curClass-2;
        _middleTableView.tag = self.curClass-1;
        _lastTableView.tag = self.curClass;
        _mainScrollView.contentOffset = CGPointMake(SCREEN_WIDTH*2, 0);
        _beginScrollX = SCREEN_WIDTH*2;
    }else{
        _firstTableView.tag = self.curClass-1;
        _middleTableView.tag = self.curClass;
        _lastTableView.tag = self.curClass+1;
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
    [self hideOrShowSeparatorStyleLine];
    if ([[self.classInfoAry objectAtIndex:index1] needReflush]) {
        if (self.curClass == 0) {
            _firstTableView.contentOffset = CGPointMake(0, [[self.classInfoAry objectAtIndex:self.curClass] curPosition]);
            [_firstTableView.mj_header beginRefreshing];
            if ([[self.classInfoAry objectAtIndex:self.curClass+1] needReflush]) {
                ClassInfoMode *classInfo = [self.classInfoAry objectAtIndex:self.curClass+1];
                NSString *url = classInfo.tier.url;
                [NetworkManager postRequestJsonWithURL:url params:nil delegate:self tag:@"mainNewsData" msg:self.curClass+1 useCache:YES update:NO showHUD:NO];
            }
        }
    }else{
        _firstTableView.contentOffset = CGPointMake(0, [[self.classInfoAry objectAtIndex:index1] curPosition]);
    }
    
    if ([[self.classInfoAry objectAtIndex:index2] needReflush]) {
        if ((self.curClass != [self.classInfoAry count] - 1) && (_curClass != 0)) {
            _middleTableView.contentOffset = CGPointMake(0, [[self.classInfoAry objectAtIndex:self.curClass] curPosition]);
            [_middleTableView.mj_header beginRefreshing];
            ClassInfoMode *classInfo = [self.classInfoAry objectAtIndex:self.curClass+1];
            NSString *url1 = classInfo.tier.url;
            [NetworkManager postRequestJsonWithURL:url1 params:nil delegate:self tag:@"mainNewsData" msg:self.curClass+1 useCache:YES update:NO showHUD:NO];
            
            ClassInfoMode *classInfo1 = [self.classInfoAry objectAtIndex:self.curClass-1];
            NSString *url = classInfo1.tier.url;

            [NetworkManager postRequestJsonWithURL:url params:nil delegate:self tag:@"mainNewsData" msg:self.curClass-1 useCache:YES update:NO showHUD:NO];
        }
    }else{
        _middleTableView.contentOffset = CGPointMake(0, [[self.classInfoAry objectAtIndex:index2] curPosition]);
    }
    
    if ([[self.classInfoAry objectAtIndex:index3] needReflush]) {
        if (self.curClass == [self.classInfoAry count] - 1) {
            _lastTableView.contentOffset = CGPointMake(0, [[self.classInfoAry objectAtIndex:self.curClass] curPosition]);
            [_lastTableView.mj_header beginRefreshing];
            ClassInfoMode *classInfo = [self.classInfoAry objectAtIndex:self.curClass-1];
            [NetworkManager postRequestJsonWithURL:classInfo.tier.url params:nil delegate:self tag:@"mainNewsData" msg:self.curClass-1 useCache:YES update:NO showHUD:NO];
        }
    }else{
        _lastTableView.contentOffset = CGPointMake(0, [[self.classInfoAry objectAtIndex:index3] curPosition]);
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:keyOrderAry];
    [self removeObserver:self forKeyPath:keyCurClass];
}
@end
