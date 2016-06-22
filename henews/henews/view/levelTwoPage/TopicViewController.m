//
//  TopicViewController.m
//  henews
//
//  Created by 汪洋 on 16/3/30.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TopicViewController.h"
#import "MJRefresh.h"
#import "ModulData.h"
#import <objc/runtime.h>

#define secHeadHeight 26.5f

@interface TopicViewController ()

@end

@implementation TopicViewController{
    UITableView *_mainTableView;
    NSMutableArray *_tableViewData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    self.head.shareButton.hidden = NO;
    NSString *str = @"和新闻 · 专题";
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:str];
    [text addAttribute:NSForegroundColorAttributeName value:ROSERED range:NSMakeRange(5, 3)];
    self.head.pageTitle.attributedText = text;
    _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.head.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(self.head.frame))];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTableView];
    [self setupRefresh];
    [_mainTableView headerBeginRefreshing];
}

#pragma mark - 网络请求返回
-(void)requestDidReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg isCacheReturn:(BOOL)flag{
    if ([tag isEqual:@"topicListData"]) {
        if (!flag) {
            [_mainTableView headerEndRefreshing];
        }
        
        if (!_tableViewData) {
            _tableViewData = [[NSMutableArray alloc]init];
        }
        [_tableViewData removeAllObjects];
        
        topicHeadData *topicHead = [[topicHeadData alloc]init];
        [topicHead initWithPic:[returnJson objectForKey:@"imageUrl"] topicIntro:[returnJson objectForKey:@"newsIntro"]];
        [_tableViewData addObject:topicHead];
        
        NSArray *node = [returnJson objectForKey:@"specialNodeList"];
        if (node && node.count > 0) {
            for (int i = 0; i<node.count; i++) {
                ModulData *modul = [[ModulData alloc]init];
                [modul initWithData:[node objectAtIndex:i]];
                if (![modul.nodeName isEqual:@""]) {
                    [_tableViewData addObject:modul];
                }
            }
        }
        [_mainTableView reloadData];
//        objc_msgSend(_mainTableView, @selector(reloadData));
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PageHeadDelegate
- (void)pageHead:(PageHead *)head shareButton:(UIButton *)button{
    NSLog(@"ssss");
}

- (void)pageHead:(PageHead*)head backButton:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 上下拉刷新加载更多方法
- (void)setupRefresh{
    [_mainTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
}

//下拉刷新
- (void)headerRereshing{
    [Request requestPostForJSON:@"topicListData" url:self.topicUrl delegate:self paras:nil msg:0 useCache:NO];
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
    if ([[_tableViewData objectAtIndex:section] isKindOfClass:[topicHeadData class]]) {
        return nil;
    }else{
        ModulData *modul = [_tableViewData objectAtIndex:section];
        return [self getSecHeadView:modul.nodeName isWhite:NO];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([[_tableViewData objectAtIndex:section] isKindOfClass:[topicHeadData class]]){
        return 0;
    }
    return secHeadHeight;
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[_tableViewData objectAtIndex:section] isKindOfClass:[topicHeadData class]]){
        return 1;
    }
    ModulData *modul = [_tableViewData objectAtIndex:section];
    return modul.newsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[_tableViewData objectAtIndex:indexPath.section] isKindOfClass:[topicHeadData class]]){
        topicHeadData *data = [_tableViewData objectAtIndex:indexPath.section];
        TopicHeadCell *cell = [TopicHeadCell cellWithTableView:tableView];
        [cell loadTableCell:data];
        return cell;
    }
    
    
    ModulData *modul = [_tableViewData objectAtIndex:indexPath.section];
    BOOL isWhite = true;

    NSMutableArray *tempAry = modul.newsList;
    CellData *oneCell = [tempAry objectAtIndex:indexPath.row];
    BOOL isHide = NO;
    if (indexPath.row == tempAry.count-1) {
        isHide = YES;
        if (indexPath.section == _tableViewData.count-1) {
            isHide = NO;
        }
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
    if ([[_tableViewData objectAtIndex:indexPath.section] isKindOfClass:[topicHeadData class]]){
        topicHeadData *data = [_tableViewData objectAtIndex:indexPath.section];
        return data.height;
    }
    
    ModulData *modul = [_tableViewData objectAtIndex:indexPath.section];
    CellData *data = [modul.newsList objectAtIndex:indexPath.row];
    return data.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([[_tableViewData objectAtIndex:indexPath.section] isKindOfClass:[topicHeadData class]]){
        return;
    }
    
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

-(UIView*)getSecHeadView:(NSString*)modulName isWhite:(BOOL)white{
    UIView *modulHead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, secHeadHeight)];
    if (white) {
        modulHead.backgroundColor = [UIColor whiteColor];
    }else{
        modulHead.backgroundColor = VIEWBACKGROUND_COLOR;
    }
    
    UILabel *name = [[UILabel alloc]init];
    name.textColor = [UIColor colorWithRed:0.02 green:0.02 blue:0.02 alpha:1];
    name.numberOfLines = 1;
    name.text = modulName;
    UIFont *fnt = [UIFont systemFontOfSize:16.0f];
    name.font = fnt;
    NSDictionary *attribute = @{NSFontAttributeName: fnt};
    CGFloat nameWidth = TEXTWIDTH(modulName, attribute, secHeadHeight);
    name.frame = CGRectMake(8, 0, nameWidth, secHeadHeight);
    [modulHead addSubview:name];
    
    UIButton *jumpButton = [[UIButton alloc]initWithFrame:CGRectMake(modulHead.frame.size.width-64, 0, 64, secHeadHeight)];
    jumpButton.backgroundColor = [UIColor clearColor];
    [jumpButton addTarget:self action:@selector(jumpChannelBntSelect:) forControlEvents:UIControlEventTouchUpInside];
    [modulHead addSubview:jumpButton];
    
    UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(jumpButton.frame.size.width-8-8, (secHeadHeight-11.5f)/2, 8, 11.5f)];
    arrow.image = [UIImage imageNamed:@"f_arrow.png"];
    [jumpButton addSubview:arrow];
    
    UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, arrow.frame.origin.x-8, secHeadHeight)];
    moreLabel.textAlignment = NSTextAlignmentRight;
    moreLabel.font = [UIFont systemFontOfSize:12];
    moreLabel.textColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1];
    moreLabel.text = @"更多";
    [jumpButton addSubview:moreLabel];
    
    return modulHead;
}

#pragma mark - 点击事件
- (void)jumpChannelBntSelect:(UIButton *)button{
    
}

@end
