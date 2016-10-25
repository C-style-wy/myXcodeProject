//
//  WelfareViewController.m
//  henews250
//
//  Created by 汪洋 on 16/7/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "WelfareViewController.h"
#import "WelfareBannerCell.h"
#import "WelfareScoresCell.h"
#import "WelfareActivityCell.h"
#import "WelfareExchangeCell.h"
#import "WelfareHeaderView.h"
#import "WelfareCollectionViewFlowLayout.h"
#import "WelfareMoreCell.h"
#import "WelfareScoreItemMode.h"

static NSString * const welfareBannerCell = @"welfareBannerCell";
static NSString * const welfareScoresCell = @"welfareScoresCell";
static NSString * const welfareExchangeCell = @"welfareExchangeCell";
static NSString * const welfareActivityCell = @"welfareActivityCell";
static NSString * const welfareMoreCell = @"welfareMoreCell";

static NSString * const welfareHeaderView = @"WelfareHeaderView";

static NSString * const welfareDataTag = @"welfareData";

@interface WelfareViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation WelfareViewController {
    BOOL canReflush;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
        [self.view addSubview:view];
        WelfareCollectionViewFlowLayout *flowLayout = [[WelfareCollectionViewFlowLayout alloc]init];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 53, SCREEN_WIDTH, SCREEN_HEIGHT-53-40) collectionViewLayout:flowLayout];
        collectionView.backgroundColor = LRClearColor;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.mj_header = [HenewsRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
        // 设置刷新显示的时间的key
        collectionView.mj_header.lastUpdatedTimeKey = NSStringFromClass([self class]);
        [self.view addSubview:_collectionView = collectionView];
        
        [_collectionView registerClass:[WelfareBannerCell class] forCellWithReuseIdentifier:welfareBannerCell];
        [_collectionView registerClass:[WelfareScoresCell class] forCellWithReuseIdentifier:welfareScoresCell];
        [_collectionView registerClass:[WelfareActivityCell class] forCellWithReuseIdentifier:welfareActivityCell];
        [_collectionView registerClass:[WelfareExchangeCell class] forCellWithReuseIdentifier:welfareExchangeCell];
        [_collectionView registerClass:[WelfareMoreCell class] forCellWithReuseIdentifier:welfareMoreCell];
        
        [_collectionView registerNib:[UINib nibWithNibName:welfareHeaderView bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:welfareHeaderView];
    }
    return _collectionView;
}

- (NSMutableArray *)showDataAry {
    if (!_showDataAry) {
        NSMutableArray *ary = [[NSMutableArray alloc]init];
        _showDataAry = ary;
    }
    return _showDataAry;
}

#pragma mark - 初始化页面和请求数据
- (void)initPage {
    //*******
    if (self.showDataAry.count > 0) {
        [self.collectionView reloadData];
    }
    
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark - 网络返回
- (void)requestDidFinishLoading:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg{
    if ([tag isEqualToString:welfareDataTag]) {
        [self.collectionView.mj_header endRefreshing];
        if (returnJson) {
            [self dealReturnData:returnJson];
        }
    }
}

//缓存数据返回
- (void)requestDidCacheReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger) msg {
    if ([tag isEqualToString:welfareDataTag]) {
        if (returnJson) {
            [self dealReturnData:returnJson];
        }
    }
}

- (void)requestdidFailWithError:(NSError*)error tag:(NSString *)tag msg:(NSInteger)msg {
    if ([tag isEqualToString:welfareDataTag]) {
        [self.collectionView.mj_header endRefreshing];
    }
}

#pragma mark - 数据处理
- (void)dealReturnData:(NSDictionary*)returnJson {
    self.welfareData = [WelfareMode mj_objectWithKeyValues:returnJson];
    [self.showDataAry removeAllObjects];
    if (self.welfareData.banners && self.welfareData.banners.count > 0) {
        [self.showDataAry addObject:self.welfareData.banners];
    }
    {
        WelfareScoreItemMode *scoreCell = [[WelfareScoreItemMode alloc]init];
        [self.showDataAry addObject:scoreCell];
    }
    {
        for (int i = 0; i < _welfareData.areaList.count; i++) {
            AreaListModel *area = [_welfareData.areaList objectAtIndex:i];
            [self.showDataAry addObject:area];
        }
    }
    {
        if (_welfareData.moreFuliUrl && ![_welfareData.moreFuliUrl isEqualToString:@""]) {
            [self.showDataAry addObject:_welfareData.moreFuliUrl];
        }
    }
    [self.collectionView reloadData];
    //******
    [NetworkCache saveHttpCache:self.showDataAry forKey:NSStringFromClass([self class])];
}

#pragma mark - 刷新
- (void)headerRefreshing {
    [NetworkManager postRequestJsonWithURL:DEF_GetWelfarepage params:nil delegate:self tag:welfareDataTag msg:0 useCache:YES update:YES showHUD:NO];
}

#pragma mark - TabBarBtnDelegate
- (void)tabBarBtnSelectAgain {
    if (self.collectionView.contentOffset.y == 0) {
        [self.collectionView.mj_header beginRefreshing];
    }else{
        canReflush = YES;
        [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

#pragma mark - <UICollectionViewDataSource>
//返回多少组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.showDataAry.count;
}
//每组多少个
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([[self.showDataAry objectAtIndex:section] isKindOfClass:[NSArray class]]) {
        return 1;
    } else if ([[self.showDataAry objectAtIndex:section] isKindOfClass:[WelfareScoreItemMode class]]) {
        return 1;
    } else if ([[self.showDataAry objectAtIndex:section] isKindOfClass:[AreaListModel class]]) {
        AreaListModel *area = [self.showDataAry objectAtIndex:section];
        return area.goodsList.count;
    } else if ([[self.showDataAry objectAtIndex:section] isKindOfClass:[NSString class]]) {
        return 1;
    }
    
    return 0;
}
//布局CollctionViewのsection
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([[self.showDataAry objectAtIndex:indexPath.section] isKindOfClass:[NSArray class]]) {
        return CGSizeMake(SCREEN_WIDTH, (165.5/320)*SCREEN_WIDTH);
    } else if ([[self.showDataAry objectAtIndex:indexPath.section] isKindOfClass:[WelfareScoreItemMode class]]) {
        return CGSizeMake(SCREEN_WIDTH, (35.5/320)*SCREEN_WIDTH);
    } else if ([[self.showDataAry objectAtIndex:indexPath.section] isKindOfClass:[AreaListModel class]]) {
        AreaListModel *area = [self.showDataAry objectAtIndex:indexPath.section];
        if ([area.showType isEqualToString:@"1"]) {
            return CGSizeMake(SCREEN_WIDTH, (155.0/320)*SCREEN_WIDTH);
        }else{
            return CGSizeMake((SCREEN_WIDTH)/2, (144.5/320)*SCREEN_WIDTH);
        }
    } else if ([[self.showDataAry objectAtIndex:indexPath.section] isKindOfClass:[NSString class]]) {
        return CGSizeMake(SCREEN_WIDTH, (45.0/320)*SCREEN_WIDTH);
    }
    return CGSizeMake(0, 0);
}

//collcetion的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[self.showDataAry objectAtIndex:indexPath.section] isKindOfClass:[NSArray class]]) {
        NSArray *banners = [self.showDataAry objectAtIndex:indexPath.section];
        WelfareBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:welfareBannerCell forIndexPath:indexPath];
        [cell setNews:banners];
        return cell;
    } else if ([[self.showDataAry objectAtIndex:indexPath.section] isKindOfClass:[WelfareScoreItemMode class]]) {
        WelfareScoresCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:welfareScoresCell forIndexPath:indexPath];
        [cell setObjc];
        return cell;
    } else if ([[self.showDataAry objectAtIndex:indexPath.section] isKindOfClass:[AreaListModel class]]) {
        AreaListModel *area = [self.showDataAry objectAtIndex:indexPath.section];
        if ([area.showType isEqualToString:@"1"]) {
            WelfareActivityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:welfareActivityCell forIndexPath:indexPath];
            [cell setObjcWith:[area.goodsList objectAtIndex:indexPath.row]];
            return cell;
        }else{
            WelfareExchangeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:welfareExchangeCell forIndexPath:indexPath];
            [cell setObjcWith:[area.goodsList objectAtIndex:indexPath.row] index:indexPath.row];
            return cell;
        }
    } else if ([[self.showDataAry objectAtIndex:indexPath.section] isKindOfClass:[NSString class]]) {
        WelfareMoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:welfareMoreCell forIndexPath:indexPath];
        NSString *moreUrl = [self.showDataAry objectAtIndex:indexPath.section];
        [cell setObjcWith:moreUrl];
        return cell;
    }
    return nil;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if ([[self.showDataAry objectAtIndex:section] isKindOfClass:[AreaListModel class]]) {
        AreaListModel *area = [self.showDataAry objectAtIndex:section];
        if ([area.showType isEqualToString:@"1"]) {
            return 0;
        }else{
            return 0;
        }
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//组之间的距离
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if ([[self.showDataAry objectAtIndex:section] isKindOfClass:[AreaListModel class]]) {
        AreaListModel *area = [self.showDataAry objectAtIndex:section];
        if ([area.showType isEqualToString:@"1"]) {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }else{
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//collcetion(头部)
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([[self.showDataAry objectAtIndex:indexPath.section] isKindOfClass:[AreaListModel class]] && [kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        AreaListModel *area = [self.showDataAry objectAtIndex:indexPath.section];
        WelfareHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:welfareHeaderView forIndexPath:indexPath];
        [header setObjcWithData:area];
        return header;
    }
    return nil;
}
//collction头部尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if ([[self.showDataAry objectAtIndex:section] isKindOfClass:[AreaListModel class]]) {
        return CGSizeMake(SCREEN_WIDTH, (41.0/320)*SCREEN_WIDTH);
    }
    return CGSizeZero;
}

#pragma mark - <UICollectionViewDelegate>
//colletionView点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}

//当cell高亮时返回是否高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([[self.showDataAry objectAtIndex:indexPath.section] isKindOfClass:[NSArray class]]) {
        return NO;
    } else if ([[self.showDataAry objectAtIndex:indexPath.section] isKindOfClass:[WelfareScoreItemMode class]]) {
        return NO;
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([[self.showDataAry objectAtIndex:indexPath.section] isKindOfClass:[AreaListModel class]]) {
        AreaListModel *area = [self.showDataAry objectAtIndex:indexPath.section];
        if ([area.showType isEqualToString:@"1"]) {
            WelfareActivityCell *cell = (WelfareActivityCell*)[collectionView cellForItemAtIndexPath:indexPath];
            [cell.bgView setBackgroundColor:[UIColor colorWithHexColor:@"#f0f0f0"]];
        }else{
            WelfareExchangeCell *cell = (WelfareExchangeCell*)[collectionView cellForItemAtIndexPath:indexPath];
            [cell.bgView setBackgroundColor:[UIColor colorWithHexColor:@"#f0f0f0"]];
        }
    } else if ([[self.showDataAry objectAtIndex:indexPath.section] isKindOfClass:[NSString class]]) {
        WelfareMoreCell *cell = (WelfareMoreCell*)[collectionView cellForItemAtIndexPath:indexPath];
        [cell.bgView setBackgroundColor:[UIColor colorWithHexColor:@"#f0f0f0"]];
    }
}

- (void)collectionView:(UICollectionView *)collectionView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([[self.showDataAry objectAtIndex:indexPath.section] isKindOfClass:[AreaListModel class]]) {
        AreaListModel *area = [self.showDataAry objectAtIndex:indexPath.section];
        if ([area.showType isEqualToString:@"1"]) {
            WelfareActivityCell *cell = (WelfareActivityCell*)[collectionView cellForItemAtIndexPath:indexPath];
            [cell.bgView setBackgroundColor:[UIColor whiteColor]];
        }else{
            WelfareExchangeCell *cell = (WelfareExchangeCell*)[collectionView cellForItemAtIndexPath:indexPath];
            [cell.bgView setBackgroundColor:[UIColor whiteColor]];
        }
    } else if ([[self.showDataAry objectAtIndex:indexPath.section] isKindOfClass:[NSString class]]) {
        WelfareMoreCell *cell = (WelfareMoreCell*)[collectionView cellForItemAtIndexPath:indexPath];
        [cell.bgView setBackgroundColor:[UIColor whiteColor]];
    }
}

//setContentOffset:CGPointMake(0, 0) animated:YES动画结束回调函数
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (canReflush) {
        [self.collectionView.mj_header beginRefreshing];
        canReflush = NO;
    }
}
@end
