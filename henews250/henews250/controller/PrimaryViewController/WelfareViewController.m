//
//  WelfareViewController.m
//  henews250
//
//  Created by 汪洋 on 16/7/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "WelfareViewController.h"


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
        UIView *view = [[UIView alloc]init];
        [self.view addSubview:view];
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 53, SCREEN_WIDTH, SCREEN_HEIGHT-53-40) collectionViewLayout:flowLayout];
        collectionView.backgroundColor = LRClearColor;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.mj_header = [HenewsRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
        [self.view addSubview:_collectionView = collectionView];
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
    if ([tag isEqualToString:@"welfareData"]) {
        [self.collectionView.mj_header endRefreshing];
        if (returnJson) {
            self.welfareData = [WelfareMode mj_objectWithKeyValues:returnJson];
        }
    }
}

//缓存数据返回
- (void)requestDidCacheReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger) msg {
    if ([tag isEqualToString:@"homeData"]) {
        if (returnJson) {
            self.welfareData = [WelfareMode mj_objectWithKeyValues:returnJson];
        }
    }
}

- (void)requestdidFailWithError:(NSError*)error tag:(NSString *)tag msg:(NSInteger)msg {
    if ([tag isEqualToString:@"welfareData"]) {
        [self.collectionView.mj_header endRefreshing];
    }
}

#pragma mark - 刷新
- (void)headerRefreshing {
    [NetworkManager postRequestJsonWithURL:DEF_GetWelfarepage params:nil delegate:self tag:@"welfareData" msg:0 useCache:YES update:YES showHUD:NO];
}

#pragma mark - TabBarBtnDelegate
- (void)tabBarBtnSelectAgain {
    NSLog(@"welfare===tabBarBtnSelectAgain=====");
}

#pragma mark - <UICollectionViewDataSource>
//返回多少组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 0;
}
//每组多少个
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}
//布局CollctionViewのsection
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(0, 0);
}

//collcetion的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

//组之间的距离
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
//collcetion(头部) 非轮播图
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
