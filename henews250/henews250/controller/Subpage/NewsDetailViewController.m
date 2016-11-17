//
//  NewsDetailViewController.m
//  henews250
//
//  Created by 汪洋 on 16/9/7.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "DetailShowMode.h"
#import "CommentListViewController.h"
#import "WebViewController.h"
#import "NewsCellFactory.h"


static NSString * const NewsDetailTag = @"NewsDetailTag";
static NSString * const NewsCommentTag = @"NewsCommentTag";

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headView.hidden = YES;
//    self.collectionBtn.selected = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initPage {
    [super initPage];
    if (self.url && ![self.url isEqualToString:@""]) {
        [NetworkManager postRequestJsonWithURL:self.url params:nil delegate:self tag:NewsDetailTag msg:0 useCache:YES update:YES showHUD:YES];
    }
}

#pragma mark - 网络返回
- (void)requestDidFinishLoading:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg{
    if ([tag isEqualToString:NewsDetailTag]) {
        self.newsDetailData = [NewsDetailMode mj_objectWithKeyValues:returnJson];
        
        // 请求评论相关数据
        if (self.newsDetailData.newsDetailDataUrl && ![self.newsDetailData.newsDetailDataUrl isEqualToString:@""]) {
            [NetworkManager postRequestJsonWithURL:self.newsDetailData.newsDetailDataUrl params:nil delegate:self tag:NewsCommentTag msg:0 useCache:NO update:YES showHUD:NO];
        }
        
        [self.pageData removeAllObjects];
        
        NewsSectionMode *newsSection = [[NewsSectionMode alloc]initWithData:self.newsDetailData];
        [self.pageData addObject:newsSection];
        NewsSectionMode *commentSection = [[NewsSectionMode alloc]initWithCommentData:self.newsDetailData];
        [self.pageData addObject:commentSection];
        if (self.newsDetailData.relateConts && self.newsDetailData.relateConts.count > 0) {
            NewsSectionMode *relationSection = [[NewsSectionMode alloc]initWithRelateContsData:self.newsDetailData];
            [self.pageData addObject:relationSection];
        }
        [self.tableView reloadData];
    }else if ([tag isEqualToString:NewsCommentTag]) {
        self.commentRelateMode = [CommentRelateMode mj_objectWithKeyValues:returnJson];
        self.commentLabel.text = [self.commentRelateMode.commentNum stringByAppendingString:@"评论"];
        
        if ([self.commentRelateMode.isFavorited isEqualToString:@"1"]) {
            self.collectionBtn.selected = YES;
        }else{
            self.collectionBtn.selected = NO;
        }
    }
}

//缓存数据返回
- (void)requestDidCacheReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger) msg {
    
}

- (void)requestdidFailWithError:(NSError*)error tag:(NSString *)tag msg:(NSInteger)msg {

}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
//        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.offset(headerHeight);
//            make.leading.offset(0);
//            make.trailing.offset(0);
//            make.bottom.offset(35.5);
//        }];
        _tableView.frame = CGRectMake(0, headerHeight, SCREEN_WIDTH, SCREEN_HEIGHT-headerHeight-35.5f);
        _tableView.contentSize = CGSizeMake(_tableView.bounds.size.width, _tableView.bounds.size.height);
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)pageData {
    if (!_pageData) {
        _pageData = [[NSMutableArray alloc]init];
    }
    return _pageData;
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.pageData.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NewsSectionMode *sectionMode = [self.pageData objectAtIndex:section];
    switch (sectionMode.sectionType) {
        case SectionTypeNews:{
            return nil;
        }
            break;
        case SectionTypeComment:{
            DetailCommentSection *sectionView = [[DetailCommentSection loadFromNib] initWithSectionType:SectionTypeComment];
            return sectionView;
        }
            break;
        case SectionTypeRecommend:{
            DetailCommentSection *sectionView = [[DetailCommentSection loadFromNib] initWithSectionType:SectionTypeRecommend];
            return sectionView;
        }
            break;
        default:
            return nil;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NewsSectionMode *sectionMode = [self.pageData objectAtIndex:section];
    switch (sectionMode.sectionType) {
        case SectionTypeNews:{
            return 0;
        }
            break;
        case SectionTypeComment:{
            return SCREEN_WIDTH*43.5f/320.0f;
        }
            break;
        case SectionTypeRecommend:{
            return SCREEN_WIDTH*43.5f/320.0f;
        }
            break;
        default:
            return 0;
            break;
    }
}
//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NewsSectionMode *sectionMode = [self.pageData objectAtIndex:section];
    return sectionMode.newsSectionAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsSectionMode *sectionMode = [self.pageData objectAtIndex:indexPath.section];
    switch (sectionMode.sectionType) {
        case SectionTypeNews:{
            NSMutableArray *ary = sectionMode.newsSectionAry;
            if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[NewsTitleMode class]]) {
                NewsTitleMode *titleData = [ary objectAtIndex:indexPath.row];
                NewsTitleFrame *titleFrame = [[NewsTitleFrame alloc]init];
                titleFrame.newsTitle = titleData;
                
                NewsTitleCell *cell = [NewsTitleCell cellWithTableView:tableView];
                cell.newsTitleFrame = titleFrame;
                return cell;
            }else if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[DetailShareMode class]]) {
                DetailShareCell *cell = [DetailShareCell cellWithTableView:tableView];
                return cell;
            }else if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[SubContentMode class]]){
                SubContentMode *contentData = [ary objectAtIndex:indexPath.row];
                DetailPicAndContentFrame *frame = [[DetailPicAndContentFrame alloc]init];
                frame.contentMode = contentData;
                
                DetailPicAndContentCell *cell = [DetailPicAndContentCell cellWithTableView:tableView indexpath:indexPath];
                cell.detailPicAndContentFrame = frame;
                return cell;
            }else if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[LinkReadMode class]]){
                LinkReadCell *cell = [LinkReadCell cellWithTableView:tableView];
                return cell;
            }else if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[SpotMode class]]){
                DetailDingCaiCell *cell = [DetailDingCaiCell cellWithTableView:tableView];
                return cell;
            }
            
        }
            break;
        case SectionTypeComment:{
            NSMutableArray *ary = sectionMode.newsSectionAry;
            if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
                NoCommentCell *cell = [NoCommentCell cellWithTableView:tableView];
                return cell;
            }
        }
            break;
        case SectionTypeRecommend:{
            NSMutableArray *ary = sectionMode.newsSectionAry;
            if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[NewsMode class]]) {
                NewsMode *newsData = [ary objectAtIndex:indexPath.row];
                if (newsData.images && newsData.images.count > 0) {
                    OneSmallPicCell *cell = [OneSmallPicCell cellWithTableView:tableView];
                    [cell setNews:newsData hiddenLine:NO isShortLine:YES];
                    return cell;
                }else{
                    OnlyWordCell *cell = [OnlyWordCell cellWithTableView:tableView];
                    [cell setNews:newsData hiddenLine:NO isShortLine:YES];
                    return cell;
                }
            }
        }
            break;
        default:
            return nil;
            break;
    }
    return nil;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100.0f;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsSectionMode *sectionMode = [self.pageData objectAtIndex:indexPath.section];
    switch (sectionMode.sectionType) {
        case SectionTypeNews:{
            NSMutableArray *ary = sectionMode.newsSectionAry;
            if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[NewsTitleMode class]]) {
                NewsTitleMode *titleData = [ary objectAtIndex:indexPath.row];
                NewsTitleFrame *titleFrame = [[NewsTitleFrame alloc]init];
                titleFrame.newsTitle = titleData;
                return titleFrame.cellHeight;
            }else if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[DetailShareMode class]]) {
                return SCREEN_WIDTH*61.0f/320.0f;
            }else if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[SubContentMode class]]){
                SubContentMode *contentData = [ary objectAtIndex:indexPath.row];
                DetailPicAndContentFrame *frame = [[DetailPicAndContentFrame alloc]init];
                frame.contentMode = contentData;
                return frame.cellHeight;
            }else if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[LinkReadMode class]]){
                return SCREEN_WIDTH*35.0f/320.0f;
            }else if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[SpotMode class]]){
                return 96.0f;
            }
        }
            break;
        case SectionTypeComment:{
            NSMutableArray *ary = sectionMode.newsSectionAry;
            if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
                return SCREEN_WIDTH*40.0f/320.0f;
            }
        }
            break;
        case SectionTypeRecommend:{
            NSMutableArray *ary = sectionMode.newsSectionAry;
            if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[NewsMode class]]) {
                NewsMode *newsData = [ary objectAtIndex:indexPath.row];
                if (newsData.images && newsData.images.count > 0) {
                    return SCREEN_WIDTH*88.0f/320.0f;
                }else{
                    return SCREEN_WIDTH*80.0f/320.0f;
                }
            }
        }
            break;
        default:
            return 0;
            break;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsSectionMode *sectionMode = [self.pageData objectAtIndex:indexPath.section];
    switch (sectionMode.sectionType) {
        case SectionTypeNews:{
            NSMutableArray *ary = sectionMode.newsSectionAry;
            if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[NewsTitleMode class]]) {
                
            }else if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[DetailShareMode class]]) {
                
            }else if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[SubContentMode class]]){
                
            }else if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[LinkReadMode class]]){
                LinkReadMode *linkReadData = [ary objectAtIndex:indexPath.row];
                
                WebViewController *webDetail = [WebViewController loadFromStoryboard];
                webDetail.url = linkReadData.linkUrl;
                webDetail.isWebLinkUrl = YES;
                [self.navigationController pushViewController:webDetail animated:YES];
            }
        }
            break;
        case SectionTypeRecommend:{
            NSMutableArray *ary = sectionMode.newsSectionAry;
            if ([[ary objectAtIndex:indexPath.row] isKindOfClass:[NewsMode class]]) {
                NewsMode *newsData = [ary objectAtIndex:indexPath.row];
                [[NewsCellFactory shareInstance]goNewPageWithType:[newsData.newsType intValue] url:newsData.url param:nil navigation:self.navigationController];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - 按钮点击事件
- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)collectionBtnAction:(id)sender {
    if (self.collectionBtn.selected) {
        [NetworkManager postRequestJsonWithURL:self.newsDetailData.deleteFavoriteUrl params:nil cacheBlock:^(NSDictionary *returnJson) {
            
        } successBlock:^(NSDictionary *returnJson) {
            if ([[returnJson objectForKey:@"resultCode"] isEqualToString:@"1"]) {
                self.collectionBtn.selected = NO;
            }
        } failureBlock:^(NSError *error) {
            
        } showHUD:NO];
    }else{
        [NetworkManager postRequestJsonWithURL:self.newsDetailData.addFavoriteUrl params:nil cacheBlock:^(NSDictionary *returnJson) {
            
        } successBlock:^(NSDictionary *returnJson) {
            if ([[returnJson objectForKey:@"resultCode"] isEqualToString:@"1"]) {
                self.collectionBtn.selected = YES;
            }
        } failureBlock:^(NSError *error) {
            
        } showHUD:NO];
    }
}
- (IBAction)nightBtnAction:(id)sender {
}
- (IBAction)shareBtnAction:(id)sender {
}
- (IBAction)fontBtnAction:(id)sender {
}
- (IBAction)commentBtnAction:(id)sender {
    CommentListViewController *commentListViewController = [[CommentListViewController alloc]init];
    commentListViewController.url = self.newsDetailData.commentListUrl;
    commentListViewController.commentUrl = self.newsDetailData.commentUrl;
    [self.navigationController pushViewController:commentListViewController animated:YES];
}

- (IBAction)inputBtnAction:(id)sender {
    NSLog(@"inputBtnAction=====");
}

@end
