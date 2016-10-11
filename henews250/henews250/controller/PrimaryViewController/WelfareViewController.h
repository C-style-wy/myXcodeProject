//
//  WelfareViewController.h
//  henews250
//
//  Created by 汪洋 on 16/7/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseViewController.h"
#import "XNTabBarView.h"
#import "WelfareMode.h"

@interface WelfareViewController : BaseViewController<TabBarBtnDelegate>

@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, retain) WelfareMode *welfareData;

@property (nonatomic, retain) NSMutableArray *showDataAry;

@end
