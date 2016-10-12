//
//  WelfareBannerCell.m
//  henews250
//
//  Created by 汪洋 on 2016/10/12.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "WelfareBannerCell.h"

@implementation WelfareBannerCell{
    CGFloat _beginScrollX;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"WelfareBannerCell" owner:self options:nil];
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1){
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

#pragma mark - 懒加载
- (NSArray *)banners {
    if (!_banners) {
        _banners = [[NSArray alloc]init];
    }
    return _banners;
}

- (void)prepareForReuse {
    [super prepareForReuse];
}

- (void)setNews:(NSArray *)banners{
    if (banners && banners.count > 0) {
        self.banners = banners;
        [self.bannerScroller.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.bannerScroller.contentOffset = CGPointZero;
        
        for (int i = 0; i < self.banners.count; i++) {
            WelfareBannerModel *bannerData = [self.banners objectAtIndex:i];
            BannerImageView *imageView = [[BannerImageView loadFromNib] initWithWelfareData:bannerData];
            imageView.frame = CGRectMake(SCREEN_WIDTH*i, 0, _bannerScroller.bounds.size.width, _bannerScroller.bounds.size.height);
            [self.bannerScroller addSubview:imageView];
        }
        self.bannerScroller.contentSize = CGSizeMake(SCREEN_WIDTH*self.banners.count, 0);
        self.bannerScroller.delegate = self;
        self.pageControl.numberOfPages = self.banners.count;
        self.pageControlWidth.constant = [_pageControl sizeForNumberOfPages:self.banners.count].width;
        self.pageControlHeight.constant = [_pageControl sizeForNumberOfPages:self.banners.count].height;
        
        [self bringSubviewToFront: self.bannerScroller];
        [self bringSubviewToFront: self.pageControl];
        
        self.currentPage = 0;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //得到当前页数
    float x = scrollView.contentOffset.x;
    if (x < _beginScrollX) {
        self.currentPage = self.currentPage - 1;
    }
    //往前翻
    if (x > _beginScrollX) {
        self.currentPage = self.currentPage + 1;
    }
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _beginScrollX = currentPage*SCREEN_WIDTH;
    self.pageControl.currentPage = currentPage;
    _currentPage = currentPage;
}

@end
