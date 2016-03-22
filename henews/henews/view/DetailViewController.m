//
//  DetailViewController.m
//  henews
//
//  Created by 汪洋 on 15/10/19.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "DetailViewController.h"
#import "Request.h"
#import "UIImageView+AFNetworking.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "InputBox.h"

@interface DetailViewController ()
{
    CGFloat lastContentOffset;
    ShareMode *shareData;
    BOOL hiddenStatusBar;
    NSDictionary *detailData;
    UIButton *collectionBtn;
    BOOL haveCollection;//是否收藏
}
@end

@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self preferredStatusBarStyle];
    hiddenStatusBar = NO;
    [self prefersStatusBarHidden];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
}

- (BOOL)prefersStatusBarHidden{
    return hiddenStatusBar; //返回NO表示要显示，返回YES将hiden
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = VIEWBACKGROUND_COLOR;
    [self UIInit];
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loading.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    loading.hidesWhenStopped = YES;
    [self.view addSubview:loading];
    [loading startAnimating];
    _loading = loading;
}

-(void)UIInit{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 53)];
    headView.backgroundColor = [UIColor whiteColor];
    HeadInDetail *titleView = [[HeadInDetail alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 33)];
    titleView.delegate = self;
    titleView.backgroundColor = [UIColor clearColor];
    [headView addSubview:titleView];
    collectionBtn = titleView.collectionBtn;
    [self.view addSubview:headView];

    self.tableView = [[UITableView alloc]init];
    self.tableView.frame = CGRectMake(0, 53, SCREEN_WIDTH, SCREEN_HEIGHT-53);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    BottomToolBarInDetail *toolBar = [[BottomToolBarInDetail alloc]init];
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    NSLog(@"_detailUrl=%@", _detailUrl);
    [Request requestPostForJSON:@"detailData" url:_detailUrl delegate:self paras:nil msg:0 useCache:NO];
}

-(void)requestDidReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg isCacheReturn:(BOOL)flag{
    [_loading stopAnimating];
    if ([tag isEqual:@"detailData"]) {
        //断言是为不满足表达式，则crash；即必须满足条件，不然就crash
//        NSAssert(returnJson != nil, @"返回值不为nil");
        detailData = returnJson;
        [self dealDetailDataBack:returnJson];
        [self.toolBar openToolBar];
    }else if ([tag isEqual:@"newsDetailData"]){
        [self dealNewsDetailDataBack:returnJson];
    }else if ([tag isEqual:@"isFavoriteUrl"]){
        if ([[returnJson objectForKey:@"resultCode"] isEqualToString:@"1"]) {
            haveCollection = YES;
            [collectionBtn setImage:[UIImage imageNamed:@"detail_collect_icon_s.png"] forState:UIControlStateNormal];
        }else{
            haveCollection = NO;
            [collectionBtn setImage:[UIImage imageNamed:@"detail_collect_icon.png"] forState:UIControlStateNormal];
        }
    }else if ([tag isEqual:@"deleteFavoriteUrl"]){
        if ([[returnJson objectForKey:@"resultCode"] isEqualToString:@"1"]) {
            haveCollection = NO;
            [collectionBtn setImage:[UIImage imageNamed:@"detail_collect_icon.png"] forState:UIControlStateNormal];
        }
    }else if ([tag isEqual:@"addFavoriteUrl"]){
        if ([[returnJson objectForKey:@"resultCode"] isEqualToString:@"1"]) {
            haveCollection = YES;
            [collectionBtn setImage:[UIImage imageNamed:@"detail_collect_icon_s.png"] forState:UIControlStateNormal];
        }
    }
}

- (void)dealNewsDetailDataBack:(NSDictionary*)jsonData{
    NewsVoteCellMode *voteCellData = [[NewsVoteCellMode alloc]init];
    [voteCellData initWithData:[detailData objectForKey:@"contentVoteUrl"] goodTimes:[jsonData objectForKey:@"goodTimes"] badTimes:[jsonData objectForKey:@"badTimes"]];
    [self.tableViewData addObject:voteCellData];
    if ([detailData objectForKey:@"relateConts"]) {
        NSArray *relateConts = [detailData objectForKey:@"relateConts"];
        if (relateConts.count > 0) {
            NSString *relateNewsFlag = [[NSString alloc]init];
            [self.tableViewData addObject:relateNewsFlag];
            
            for (int i=0; i < relateConts.count; i++) {
                CellData *data = [[CellData alloc]init];
                [data initWithData:[relateConts objectAtIndex:i]];
                [self.tableViewData addObject:data];
            }
        }
    }
    self.toolBar.commentNumLabel.text = [[jsonData objectForKey:@"commentNum"] stringByAppendingString:@"评论"];
    [self.tableView reloadData];
}

-(void)dealDetailDataBack:(NSDictionary*)jsonData{
    if (!_tableViewData) {
        _tableViewData = [[NSMutableArray alloc]init];
    }
    [_tableViewData removeAllObjects];
    //处理标题以及来源和时间
    NewsTitleCellData *titleCell = [[NewsTitleCellData alloc]init];
    NSDictionary *content = [jsonData objectForKey:@"content"];
    NSString *title = [content objectForKey:@"name"];
    NSString *source = [content objectForKey:@"source"];
    NSString *time = [content objectForKey:@"pubTime"];
    [titleCell initWithData:title source:source time:time];
    
    shareData = [[ShareMode alloc]initWithTitle:title text:[content objectForKey:@"weiboShareText"] url:[content objectForKey:@"shareUrl"] image:[content objectForKey:@"sharePic"]];
    
    [_tableViewData addObject:titleCell];
    
    NewsShareCellData *shareCell = [[NewsShareCellData alloc]init];
    [_tableViewData addObject:shareCell];
    
    NSArray *detailContent = [content objectForKey:@"content"];
    for (int i = 0; i < detailContent.count; i++) {
        NSDictionary *temp = [detailContent objectAtIndex:i];
        
        NewsContentCellData *contentData = [[NewsContentCellData alloc]init];
        NSString *contentText = [temp objectForKey:@"content"];
        [contentData initWithData:contentText];
        if (![contentData.content isEqual:@""]) {
            [_tableViewData addObject:contentData];
        }
        
        NewsPicCellData *picData = [[NewsPicCellData alloc]init];
        NSArray *picAry = [temp objectForKey:@"imageInfoList"];
        if (picAry && picAry.count > 0) {
            [picData initWithData:[picAry objectAtIndex:0]];
        }
        if (![picData.picUrl isEqual:@""]) {
            [_tableViewData addObject:picData];
        }
    }
    if ([content objectForKey:@"link"] && ![[content objectForKey:@"link"] isEqualToString:@""]) {
        NewsLinkCellData *linkData = [[NewsLinkCellData alloc]init];
        [linkData initWithData:[content objectForKey:@"link"]];
        [self.tableViewData addObject:linkData];
    }
    
    if ([jsonData objectForKey:@"newsDetailDataUrl"] && ![[jsonData objectForKey:@"newsDetailDataUrl"] isEqualToString:@""]) {
        NSString *newsDetailDataUrl = [jsonData objectForKey:@"newsDetailDataUrl"];
        [Request requestPostForJSON:@"newsDetailData" url:newsDetailDataUrl delegate:self paras:nil msg:1 useCache:NO];
    }
    
    if ([jsonData objectForKey:@"isFavoriteUrl"] && ![[jsonData objectForKey:@"isFavoriteUrl"] isEqualToString:@""]) {
        NSString *isFavoriteUrl = [jsonData objectForKey:@"isFavoriteUrl"];
        [Request requestPostForJSON:@"isFavoriteUrl" url:isFavoriteUrl delegate:self paras:nil msg:1 useCache:NO];
    }
    
    //添加透明度的动画
    self.tableView.alpha = 0.0f;
    [_tableView reloadData];
    [UIView animateWithDuration:0.3f animations:^{
        self.tableView.alpha = 1.0f;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsTitleCellData class]]) {
        NewsTitleCellData *one = [_tableViewData objectAtIndex:indexPath.row];
        NewsTitleCell *cell = [NewsTitleCell cellWithTableView:tableView];
        [cell loadTableCell:one];
        return cell;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsShareCellData class]]){
        NewsShareCell *cell = [NewsShareCell cellWithTableView:tableView];
        return cell;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsContentCellData class]]){
        NewsContentCellData *one = [_tableViewData objectAtIndex:indexPath.row];
        NewsContentCell *cell = [NewsContentCell cellWithTableView:tableView];
        [cell loadTableCell:one];
        return cell;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsPicCellData class]]){
        NewsPicCellData *one = [_tableViewData objectAtIndex:indexPath.row];
        NewsPicCell *cell = [NewsPicCell cellWithTableView:tableView];
        [cell loadTableCell:one];
        return cell;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsLinkCellData class]]){
        NewsLinkCellData *one = [self.tableViewData objectAtIndex:indexPath.row];
        NewsLinkCell *cell = [NewsLinkCell cellWithTableView:tableView];
        [cell loadTableCell:one controller:self];
        return cell;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsVoteCellMode class]]){
        NewsVoteCellMode *one = [self.tableViewData objectAtIndex:indexPath.row];
        NewsVoteCell *cell = [NewsVoteCell cellWithTableView:tableView];
        [cell loadTableCell:one];
        return cell;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]){
        relateNewsCell *cell = [relateNewsCell cellWithTableView:tableView];
        return cell;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[CellData class]]){
        CellData *one = [self.tableViewData objectAtIndex:indexPath.row];
        if ([one.images isEqualToString:@""]) {
            OnlyTitleCell *cell = [OnlyTitleCell cellWithTableView:tableView];
            [cell loadTableCell:one isShortLine:NO isWhiteBg:NO isHideLine:NO];
            return cell;
        }else{
            OneSmallPicCell *cell = [OneSmallPicCell cellWithTableView:tableView];
            [cell loadTableCell:one isShortLine:NO isWhiteBg:NO isHideLine:NO];
            return cell;
        }
    }
    else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsTitleCellData class]]) {
        NewsTitleCellData *one = [_tableViewData objectAtIndex:indexPath.row];
        return one.height;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsShareCellData class]]){
        NewsShareCellData *one = [_tableViewData objectAtIndex:indexPath.row];
        return one.height;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsShareCellData class]]){
        NewsShareCellData *one = [_tableViewData objectAtIndex:indexPath.row];
        return one.height;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsContentCellData class]]){
        NewsContentCellData *one = [_tableViewData objectAtIndex:indexPath.row];
        return one.height;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsPicCellData class]]){
        NewsPicCellData *one = [_tableViewData objectAtIndex:indexPath.row];
        return one.height;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsLinkCellData class]]){
        NewsLinkCellData *one = [self.tableViewData objectAtIndex:indexPath.row];
        return one.height;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsVoteCellMode class]]){
        NewsVoteCellMode *one = [self.tableViewData objectAtIndex:indexPath.row];
        return one.height;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]){
        return 44.0f;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[CellData class]]){
        CellData *one = [self.tableViewData objectAtIndex:indexPath.row];
        if ([one.images isEqualToString:@""]) {
            return 80.0f;
        }else{
            return 88.0f;
        }
    }
    else{
        return 0;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[CellData class]]) {
        CellData *cell = [self.tableViewData objectAtIndex:indexPath.row];
        NSString *url = cell.url;
        DetailViewController *detail = [[DetailViewController alloc] init];
        detail.detailUrl = url;
        [self.navigationController pushViewController:detail animated:YES];
    }
}


//scrollView滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > lastContentOffset) { //向上滑动
        if (offsetY > 0) {
            [self.toolBar closeToolBar];
        }
    }else{                             //向下滑动
        CGFloat hight = scrollView.frame.size.height;
        CGFloat distanceFromBottom = scrollView.contentSize.height - offsetY;
        if (distanceFromBottom > hight + 25) {  //是否滑到底
            [self.toolBar openToolBar];
        }
    }
    lastContentOffset = offsetY;
}

#pragma mark - HeadInDetailDelegate
- (void)headInDetail:(HeadInDetail*)head backButton:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)headInDetail:(HeadInDetail*)head collectionButton:(UIButton *)button{
    if (haveCollection) {
        if ([detailData objectForKey:@"deleteFavoriteUrl"] && ![[detailData objectForKey:@"deleteFavoriteUrl"] isEqualToString:@""]) {
            NSString *deleteFavoriteUrl = [detailData objectForKey:@"deleteFavoriteUrl"];
            [Request requestPostForJSON:@"deleteFavoriteUrl" url:deleteFavoriteUrl delegate:self paras:nil msg:1 useCache:NO];
        }
    }else{
        if ([detailData objectForKey:@"addFavoriteUrl"] && ![[detailData objectForKey:@"addFavoriteUrl"] isEqualToString:@""]) {
            NSString *addFavoriteUrl = [detailData objectForKey:@"addFavoriteUrl"];
            [Request requestPostForJSON:@"addFavoriteUrl" url:addFavoriteUrl delegate:self paras:nil msg:1 useCache:NO];
        }
    }
}

- (void)headInDetail:(HeadInDetail*)head modeButton:(UIButton *)button isNight:(BOOL)night{
    if (night) {
        hiddenStatusBar = YES;
        [UIView animateWithDuration:0.3 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }else{
        hiddenStatusBar = NO;
        [UIView animateWithDuration:0.3 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
}

#pragma mark - BottomToolBarInDetailDelegate
- (void)toolBar:(BottomToolBarInDetail*)tool shareButton:(UIButton *)button{
    //1、创建分享参数
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    NSArray* imageArray = @[shareData.shareImage];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:shareData.shareText
                                         images:imageArray
                                            url:[NSURL URLWithString:shareData.shareUrl]
                                          title:shareData.shareTitle
                                           type:SSDKContentTypeAuto];
        [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end){
            switch (state) {
                case SSDKResponseStateSuccess:{
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                    [alertView show];
                }break;
                case SSDKResponseStateFail:{
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                    message:[NSString stringWithFormat:@"%@",error]
//                                                                   delegate:nil
//                                                          cancelButtonTitle:@"OK"
//                                                          otherButtonTitles:nil, nil];
//                    [alert show];
                }break;
                default:
                    break;
            }
        }];
    }

}

- (void)toolBar:(BottomToolBarInDetail*)tool commentButton:(UIButton *)button{
    InputBox *inputBox = [[InputBox alloc]init];
    [inputBox openInputBox:self];
}

@end
