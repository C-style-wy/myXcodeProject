//
//  BannersCell.h
//  henews
//
//  Created by 汪洋 on 15/11/3.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannersData.h"
#import "UIImageView+AFNetworking.h"

@protocol BannersDelegate;

@interface BannersCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, retain) id <BannersDelegate> delegate;

@property (nonatomic, retain) UIScrollView *bannersScrollView;
@property (nonatomic, retain) UIPageControl *pageContrl;
@property (nonatomic, retain) BannersData *bannersData;
@property (nonatomic, assign) int bannersNum;
@property (nonatomic, retain) UILabel *titleLable;
@property (nonatomic, assign) NSInteger curPage;



+ (instancetype)cellWithTableView:(UITableView *)tableView;



-(void)loadTableCell:(BannersData*)data;
@end


@protocol BannersDelegate <NSObject>

@optional
-(void)dealBannersDelegate:(BannersCell*)view return:(OneBannerData*)one;

@end