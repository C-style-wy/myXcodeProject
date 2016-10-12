//
//  WelfareViewController.m
//  henews250
//
//  Created by 汪洋 on 16/7/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "WelfareViewController.h"
#import "WelfareBannerCell.h"

#import "TestCollectionViewCell.h"

static NSString * const welfareBannerCell = @"welfareBannerCell";
static NSString * const welfareDataTag = @"welfareData";

@interface WelfareViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation WelfareViewController

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
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 53, SCREEN_WIDTH, SCREEN_HEIGHT-53-40) collectionViewLayout:flowLayout];
        collectionView.backgroundColor = LRClearColor;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.mj_header = [HenewsRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
        [self.view addSubview:_collectionView = collectionView];
        
        [_collectionView registerClass:[WelfareBannerCell class] forCellWithReuseIdentifier:welfareBannerCell];
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
    [self.collectionView reloadData];
}

#pragma mark - 刷新
- (void)headerRefreshing {
    [NetworkManager postRequestJsonWithURL:DEF_GetWelfarepage params:nil delegate:self tag:welfareDataTag msg:0 useCache:YES update:YES showHUD:NO];
}

#pragma mark - TabBarBtnDelegate
- (void)tabBarBtnSelectAgain {
    NSLog(@"welfare===tabBarBtnSelectAgain=====");
}

#pragma mark - <UICollectionViewDataSource>
//返回多少组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.showDataAry.count;
}
//每组多少个
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([[self.showDataAry objectAtIndex:section] isKindOfClass:[NSArray class]]) {
        return 1;
    }
    return 0;
}
//布局CollctionViewのsection
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([[self.showDataAry objectAtIndex:indexPath.section] isKindOfClass:[NSArray class]]) {
        return CGSizeMake(SCREEN_WIDTH, (165.5/320)*SCREEN_WIDTH);
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
    }
    return nil;
}

//组之间的距离
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//collcetion(头部)
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
//collction头部尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}

#pragma mark - <UICollectionViewDelegate>
//colletionView点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
