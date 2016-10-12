//
//  WelfareBannerCell.h
//  henews250
//
//  Created by 汪洋 on 2016/10/12.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "MyPageControl.h"
#import "BannerImageView.h"
#import "WelfareBannerModel.h"
#import "MacroDefinition.h"

@interface WelfareBannerCell : UICollectionViewCell<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *bannerScroller;
@property (weak, nonatomic) IBOutlet MyPageControl *pageControl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageControlWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageControlHeight;



@property (nonatomic, retain) NSArray *banners;
@property (nonatomic, assign) NSInteger currentPage;

- (void)setNews:(NSArray *)banners;
@end
