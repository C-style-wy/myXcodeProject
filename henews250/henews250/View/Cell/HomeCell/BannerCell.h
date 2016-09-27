//
//  BannerCell.h
//  henews250
//
//  Created by 汪洋 on 16/7/22.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
#import "MyPageControl.h"
#import "BannerMode.h"
#import "BannerImageView.h"

@interface BannerCell : BaseCell<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *bannerScrol;

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagLabelWidth;
@property (weak, nonatomic) IBOutlet UIImageView *tagImage;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLeading;

@property (weak, nonatomic) IBOutlet MyPageControl *pageControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageControlWidth;


@property (weak, nonatomic) IBOutlet UIImageView *line;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setNews:(NSMutableArray *)banners hiddenLine:(BOOL)hidden;
@end
