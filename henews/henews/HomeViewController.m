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

- (void)jumpChannelBntSelect:(UIButton*)button{
    NSLog(@"jump==button===");
}

- (void)exchangeButtonBntSelect:(UIButton*)button{
    NSLog(@"exchange==button===");
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
        
        if (!_tableViewData) {
            _tableViewData = [[NSMutableArray alloc]init];
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

-(UIView*)getSecHeadView:(NSString*)modulName isWhite:(BOOL)white{
    UIView *modulHead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35.0f)];
    if (white) {
        modulHead.backgroundColor = [UIColor whiteColor];
    }else{
        modulHead.backgroundColor = VIEWBACKGROUND_COLOR;
    }
    
    UIImageView *line = [[UIImageView alloc]init];
    line.frame = CGRectMake(8, 34.5f, SCREEN_WIDTH-16, 0.5f);
    line.image = [UIImage imageNamed:@"menuFenge.png"];
    [modulHead addSubview:line];
    
    UILabel *name = [[UILabel alloc]init];
    name.textColor = [UIColor colorWithRed:0.02 green:0.02 blue:0.02 alpha:1];
    name.frame = CGRectMake(8, 0, SCREEN_WIDTH-16, 35);
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
    CGFloat nameWidth = TEXTWIDTH(modulName, attribute, 35.0f);
    name.frame = CGRectMake(0, 0, nameWidth, 35);
    
    UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(nameWidth+10, 11.25f, 17, 12.5f)];
    arrow.image = [UIImage imageNamed:@"f_arrow.png"];
    [jumpButton addSubview:arrow];
    
    jumpButton.frame = CGRectMake(8, 0, nameWidth+27, 35);
    
    
    UIButton *exchangeButton = [[UIButton alloc]init];
    exchangeButton.backgroundColor = [UIColor clearColor];
    [exchangeButton addTarget:self action:@selector(exchangeButtonBntSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *exchangeLabel = @"换一批";
    
    UIFont *fnt1 = [UIFont systemFontOfSize:12];
    NSDictionary *attribute1 = @{NSFontAttributeName: fnt1};
    CGFloat exchangeLabelWidth = TEXTWIDTH(exchangeLabel, attribute1, 35);
    
    UILabel *exchange = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, exchangeLabelWidth, 35)];
    exchange.text = exchangeLabel;
    exchange.textAlignment = NSTextAlignmentRight;
    exchange.font = fnt1;
    exchange.textColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1];
    [exchangeButton addSubview:exchange];
    
    UIImageView *exchangeImg = [[UIImageView alloc]initWithFrame:CGRectMake(exchangeLabelWidth+10, 8, 19, 19)];
    exchangeImg.image = [UIImage imageNamed:@"change_batch_icon.png"];
    [exchangeButton addSubview:exchangeImg];
    exchangeButton.frame = CGRectMake(SCREEN_WIDTH-exchangeLabelWidth-36, 0, exchangeLabelWidth+28, 35);
    
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
    ModulData *modul = [_tableViewData objectAtIndex:section];
    if (section%2 == 0) {
        return [self getSecHeadView:modul.nodeName isWhite:NO];
    }else{
        return [self getSecHeadView:modul.nodeName isWhite:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ModulData *modul = [_tableViewData objectAtIndex:section];
    return modul.newsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModulData *modul = [_tableViewData objectAtIndex:indexPath.section];
    BOOL isWhite = true;
    if ((indexPath.section)%2 == 0) {
        isWhite = NO;
    }
    NSMutableArray *tempAry = modul.newsList;
    CellData *oneCell = [tempAry objectAtIndex:indexPath.row];
    BOOL isHide = NO;
    if (indexPath.row == tempAry.count-1) {
        isHide = YES;
    }
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModulData *modul = [_tableViewData objectAtIndex:indexPath.section];
    CellData *data = [modul.newsList objectAtIndex:indexPath.row];
    return data.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
