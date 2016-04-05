//
//  HomeViewController.m
//  henews
//
//  Created by 汪洋 on 15/10/19.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "HomeViewController.h"
#import "DetailViewController.h"
#import "LinkViewController.h"
#import "TopicViewController.h"
#import "MJRefresh.h"
#import "Request.h"

#import "VideoCell.h"
#import "BannersCell.h"
#import "UIImageView+AFNetworking.h"
#import "NewsNumberTip.h"

@interface HomeViewController ()

@end

@implementation HomeViewController{
    NSTimer *_time;
}

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
    //goto channelManage Page
}

- (void)jumpChannelBntSelect:(UIButton*)button{
    NSLog(@"jump==button===");
}

- (void)exchangeButtonBntSelect:(UIButton*)button{
    NSLog(@"exchange==button===");
    [_tableView reloadData];
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
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.frame = CGRectMake(0, 59, screenW, screenH-99);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    [self setupRefresh];
}

#pragma mark - 网络请求返回
-(void)requestDidReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg isCacheReturn:(BOOL)flag{
    if ([tag isEqual:@"homeData"]) {
        if (!flag) {
            [self.tableView headerEndRefreshing];
            _time =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTip) userInfo:nil repeats:NO];
        }else{
            NSLog(@"requestDidReturn===cache===");
        }
        
        if (!_tableViewData) {
            _tableViewData = [[NSMutableArray alloc]init];
        }
        if (returnJson != nil) {
            [_tableViewData removeAllObjects];
            NSArray *banners = [returnJson objectForKey:@"banners"];
            if (banners && (banners.count > 0)) {
                BannersData *bannersData = [[BannersData alloc]init];
                [bannersData initWithData:banners];
                [_tableViewData addObject:bannersData];
            }
            NSArray *node = [returnJson objectForKey:@"nodes"];
            if (node && node.count > 0) {
                for (int i = 0; i<node.count; i++) {
                    ModulData *modul = [[ModulData alloc]init];
                    [modul initWithData:[node objectAtIndex:i]];
                    if (![modul.nodeName isEqual:@""]) {
                        [_tableViewData addObject:modul];
                    }
                }
            }
            
//            [UIView transitionWithView:_tableView
//                              duration: 0.35f
//                               options: UIViewAnimationOptionTransitionCrossDissolve
//                            animations: ^(void)
//             {
//                 [_tableView reloadData];
//             }
//                            completion: ^(BOOL isFinished)
//             {  
//                 
//             }];
            [_tableView reloadData];
        }
    }
}

- (void)showTip{
    [NewsNumberTip showWithTipDesc:@"已为您推荐了新的内容" superView:self.view showX:0 showY:59];
    if (_time) {
        [_time invalidate];
        _time=nil;
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
    [Request requestPostForJSON:@"homeData" url:url delegate:self paras:nil msg:0 useCache:YES];
}

-(UIView*)getSecHeadView:(NSString*)modulName isWhite:(BOOL)white{
    CGFloat secHeadHeight = 26.5f;
    UIView *modulHead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, secHeadHeight)];
    if (white) {
        modulHead.backgroundColor = [UIColor whiteColor];
    }else{
        modulHead.backgroundColor = VIEWBACKGROUND_COLOR;
    }
    
    UILabel *name = [[UILabel alloc]init];
    name.textColor = [UIColor colorWithRed:0.02 green:0.02 blue:0.02 alpha:1];
    name.frame = CGRectMake(8, 0, SCREEN_WIDTH-16, secHeadHeight);
    name.numberOfLines = 1;
    name.text = modulName;
    
    UIButton *jumpButton = [[UIButton alloc]init];
    jumpButton.backgroundColor = [UIColor clearColor];
    [jumpButton addTarget:self action:@selector(jumpChannelBntSelect:) forControlEvents:UIControlEventTouchUpInside];
    [jumpButton addSubview:name];
    [modulHead addSubview:jumpButton];
    
    UIFont *fnt = [UIFont systemFontOfSize:16.0f];
    name.font = fnt;
    NSDictionary *attribute = @{NSFontAttributeName: fnt};
    CGFloat nameWidth = TEXTWIDTH(modulName, attribute, secHeadHeight);
    name.frame = CGRectMake(0, 0, nameWidth, secHeadHeight);
    
    UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(nameWidth+10, (secHeadHeight-11.5f)/2, 8, 11.5f)];
    arrow.image = [UIImage imageNamed:@"f_arrow.png"];
    [jumpButton addSubview:arrow];
    
    jumpButton.frame = CGRectMake(8, 0, nameWidth+27, secHeadHeight);
    
    
    UIButton *exchangeButton = [[UIButton alloc]init];
    exchangeButton.backgroundColor = [UIColor clearColor];
    [exchangeButton addTarget:self action:@selector(exchangeButtonBntSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *exchangeLabel = @"换一批";
    
    UIFont *fnt1 = [UIFont systemFontOfSize:12];
    NSDictionary *attribute1 = @{NSFontAttributeName: fnt1};
    CGFloat exchangeLabelWidth = TEXTWIDTH(exchangeLabel, attribute1, secHeadHeight);
    
    UILabel *exchange = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, exchangeLabelWidth, secHeadHeight)];

    exchange.text = exchangeLabel;
    exchange.textAlignment = NSTextAlignmentRight;
    exchange.font = fnt1;
    exchange.textColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1];
    [exchangeButton addSubview:exchange];
    
    UIImageView *exchangeImg = [[UIImageView alloc]initWithFrame:CGRectMake(exchangeLabelWidth+8, (secHeadHeight-16)/2, 16, 16)];
    exchangeImg.image = [UIImage imageNamed:@"change_batch_icon.png"];
    [exchangeButton addSubview:exchangeImg];
    exchangeButton.frame = CGRectMake(SCREEN_WIDTH-exchangeLabelWidth-32, 0, exchangeLabelWidth+24, secHeadHeight);
    
    [modulHead addSubview:exchangeButton];
    
    return modulHead;
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _tableViewData.count;
}

//返回没个分区的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([[_tableViewData objectAtIndex:section] isKindOfClass:[BannersData class]]) {
        return nil;
    }
    ModulData *modul = [_tableViewData objectAtIndex:section];
    return [self getSecHeadView:modul.nodeName isWhite:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([[_tableViewData objectAtIndex:section] isKindOfClass:[BannersData class]]) {
        return 0;
    }
    return 26.5f;
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[_tableViewData objectAtIndex:section] isKindOfClass:[BannersData class]]) {
        return 1;
    }
    ModulData *modul = [_tableViewData objectAtIndex:section];
    return modul.newsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[_tableViewData objectAtIndex:indexPath.section] isKindOfClass:[BannersData class]]) {
        BannersData *oneCell = [_tableViewData objectAtIndex:indexPath.section];
        BannersCell *cell = [BannersCell cellWithTableView:tableView];
        cell.delegate = self;
        cell.line.hidden = YES;
        cell.backgroundColor = [UIColor whiteColor];
        [cell loadTableCell:oneCell];
        return cell;
    }
    ModulData *modul = [_tableViewData objectAtIndex:indexPath.section];
    BOOL isWhite = true;
//    if ((indexPath.section)%2 == 0) {
//        isWhite = NO;
//    }
    NSMutableArray *tempAry = modul.newsList;
    CellData *oneCell = [tempAry objectAtIndex:indexPath.row];
    BOOL isHide = NO;
    if (indexPath.row == tempAry.count-1) {
        isHide = YES;
    }
    if ([oneCell.newsType isEqual:@"1"]) {
        VideoCell *cell = [VideoCell cellWithTableView:tableView];
        [cell loadTableCell:oneCell isShortLine:YES isWhiteBg:isWhite isHideLine:isHide];
        return cell;
    }else{
        if ([oneCell.displayType isEqual:ONE_SMALL_PIC]) {   //一张小图
            OneSmallPicCell *cell = [OneSmallPicCell cellWithTableView:tableView];
            [cell loadTableCell:oneCell isShortLine:YES isWhiteBg:isWhite isHideLine:isHide];
            return cell;
        }else if ([oneCell.displayType isEqual:ONE_BIG_PIC] || [oneCell.displayType isEqual:NEWS_EARLY_BUS]){                        //一张大图和新闻早班车
            OneBigPicCell *cell = [OneBigPicCell cellWithTableView:tableView];
            [cell loadTableCell:oneCell isShortLine:YES isWhiteBg:isWhite isHideLine:isHide];
            return cell;
        }else if ([oneCell.displayType isEqual:EVERY_ONE] || [oneCell.displayType isEqual:EVERY_ONE_G]){                                 //大家和感性
            EveryOneCell *cell = [EveryOneCell cellWithTableView:tableView];
            [cell loadTableCell:oneCell isShortLine:YES isWhiteBg:isWhite isHideLine:isHide];
            return cell;
        }else if ([oneCell.displayType isEqual:THREE_SMALL_PIC]){  //三张小图
            ThreePicCell *cell = [ThreePicCell cellWithTableView:tableView];
            [cell loadTableCell:oneCell isShortLine:YES isWhiteBg:isWhite isHideLine:isHide];
            return cell;
        }
        else{                          //无图
            OnlyTitleCell *cell = [OnlyTitleCell cellWithTableView:tableView];
            [cell loadTableCell:oneCell isShortLine:YES isWhiteBg:isWhite isHideLine:isHide];
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[_tableViewData objectAtIndex:indexPath.section] isKindOfClass:[BannersData class]]){
        BannersData *data = [_tableViewData objectAtIndex:indexPath.section];
        return data.height;
    }
    
    ModulData *modul = [_tableViewData objectAtIndex:indexPath.section];
    CellData *data = [modul.newsList objectAtIndex:indexPath.row];
    return data.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ModulData *modul = [_tableViewData objectAtIndex:indexPath.section];
    CellData *cell = [modul.newsList objectAtIndex:indexPath.row];
    NSString *url = cell.url;
    if ([cell.newsType isEqual:@"1"]) {
        PlayViewController *play = [[PlayViewController alloc] init];
        play.playUrl = url;
        play.baseImageUrl = cell.images;
        [self.navigationController pushViewController:play animated:YES];
    }else if ([cell.newsType isEqual:@"3"]){
        TopicViewController *topic = [[TopicViewController alloc]init];
        topic.topicUrl = url;
        [self.navigationController pushViewController:topic animated:YES];
    }else if ([cell.newsType isEqual:@"4"]){
        PicDetailViewController *picDetail = [[PicDetailViewController alloc] init];
        picDetail.picUrl = url;
        [self.navigationController pushViewController:picDetail animated:YES];
    }else if ([cell.newsType isEqual:@"5"]){
        LinkViewController *linkDetail = [[LinkViewController alloc] init];
        linkDetail.linkUrl = url;
        linkDetail.shouldRequstAgain = YES;
        linkDetail.showShareButton = YES;
        [self.navigationController pushViewController:linkDetail animated:YES];
    }
    else{
        DetailViewController *detail = [[DetailViewController alloc] init];
        detail.detailUrl = url;
        
        [self.navigationController pushViewController:detail animated:YES];
    }
}


-(void)dealBannersDelegate:(BannersCell*)view return:(OneBannerData*)one{
    NSString *newsType = one.newsType;
    NSString *url = one.url;
    if ([newsType isEqual:@"1"]) {
        PlayViewController *play = [[PlayViewController alloc] init];
        play.playUrl = url;
        [self.navigationController pushViewController:play animated:YES];
    }else if ([one.newsType isEqual:@"3"]){
        TopicViewController *topic = [[TopicViewController alloc]init];
        topic.topicUrl = url;
        [self.navigationController pushViewController:topic animated:YES];
    }else if ([one.newsType isEqual:@"4"]){
        PicDetailViewController *picDetail = [[PicDetailViewController alloc] init];
        picDetail.picUrl = url;
        [self.navigationController pushViewController:picDetail animated:YES];
    }else if ([one.newsType isEqual:@"5"]){
        LinkViewController *linkDetail = [[LinkViewController alloc] init];
        linkDetail.linkUrl = url;
        linkDetail.shouldRequstAgain = YES;
        linkDetail.showShareButton = YES;
        [self.navigationController pushViewController:linkDetail animated:YES];
    }
    else{
        DetailViewController *detail = [[DetailViewController alloc] init];
        detail.detailUrl = url;
        [self.navigationController pushViewController:detail animated:YES];
    }
}
@end
