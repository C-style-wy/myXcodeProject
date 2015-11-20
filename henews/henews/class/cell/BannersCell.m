//
//  BannersCell.m
//  henews
//
//  Created by 汪洋 on 15/11/3.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "BannersCell.h"
#import "APIStringMacros.h"
#import "UIImageView+AFNetworking.h"

@interface BannersCell()
{
    CGFloat _beginScrollX;
}
@end

@implementation BannersCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"BannersCell";
    // 1.缓存中取
    BannersCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[BannersCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
        UIImageView *line = [[UIImageView alloc]init];
        line.frame = CGRectMake(0, 195.5f, SCREEN_WIDTH, 0.5f);
        line.image = [UIImage imageNamed:@"menuFenge.png"];
        [self addSubview:line];
        
        
        UIScrollView *scro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 166)];
        scro.scrollEnabled = YES;
        scro.pagingEnabled = YES;
        scro.bounces = YES;
        scro.showsHorizontalScrollIndicator = NO;
        scro.showsVerticalScrollIndicator = NO;
        [self addSubview:scro];
        scro.delegate = self;
        self.bannersScrollView = scro;
        
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        [self addSubview:pageControl];
        _pageContrl = pageControl;
        
        _titleLable = [[UILabel alloc]init];
        _titleLable.font = [UIFont systemFontOfSize:12.0f];
        _titleLable.textColor = [UIColor colorWithRed:0.12 green:0.12 blue:0.12 alpha:1];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLable];
    }
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
//    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    return self;
}

-(void)loadTableCell:(BannersData*)data{
    [_bannersScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _bannersData = data;
    _bannersNum = (int)_bannersData.bannersAry.count;
    for (int i=0; i<_bannersNum; i++) {
        OneBannerData *oneBanner = [data.bannersAry objectAtIndex:i];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, _bannersScrollView.frame.size.width, _bannersScrollView.frame.size.height)];
        view.backgroundColor = DEFAULTCOLOR;
        
        UIImageView *defaultImage = [[UIImageView alloc]init];
        defaultImage.frame = CGRectMake((view.frame.size.width-45)/2, (view.frame.size.height-45)/2, 45, 45);
        [defaultImage setImage:[UIImage imageNamed:@"newsBigBg.png"]];
        [view addSubview:defaultImage];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        image.contentMode = UIViewContentModeScaleAspectFill;
        [image setContentScaleFactor:[[UIScreen mainScreen]scale]];
        image.clipsToBounds  = YES;
        
//        [image setImage:[UIImage imageNamed:@""]];
        if (![oneBanner.imageUrl isEqual:@""]) {
            [image setImageWithURL:[NSURL URLWithString:oneBanner.imageUrl]];
        }
        [view addSubview:image];
        
        [_bannersScrollView addSubview:view];
    }
    _curPage = 0;
    
    _bannersScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*_bannersNum, 0);
    
    CGSize pageControlSize = [_pageContrl sizeForNumberOfPages:_bannersNum];
    _pageContrl.numberOfPages = _bannersNum;
    _pageContrl.frame = CGRectMake(self.frame.size.width-pageControlSize.width-8, data.height-30, pageControlSize.width, 30);
    _pageContrl.currentPageIndicatorTintColor = ROSERED;
    _pageContrl.pageIndicatorTintColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1];
    
    _titleLable.frame = CGRectMake(8, data.height-30, SCREEN_WIDTH-pageControlSize.width-24, 30);
    OneBannerData *oneBanner = [data.bannersAry objectAtIndex:_curPage];
    _titleLable.text = oneBanner.newsTitle;
    
    _beginScrollX = 0;
    _pageContrl.currentPage = _curPage;
    _bannersScrollView.contentOffset = CGPointMake(0, 0);
}

#pragma mark - scrollView停止滑动
//scrollView开始滑动
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    _beginScrollX = scrollView.contentOffset.x;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //得到当前页数
    float x = scrollView.contentOffset.x;
    NSLog(@"x===%f", x);
    NSLog(@"_beginScrollX===%f", _beginScrollX);
    NSLog(@"_curPage==before==%li", (long)_curPage);
    if (x < _beginScrollX) {
        NSLog(@"往后翻");
        _curPage--;
        [self reloadData];
    }
    //往前翻
    if (x > _beginScrollX) {
        NSLog(@"往前翻");
        _curPage++;
        [self reloadData];
    }
    NSLog(@"_curPage==end==%li", (long)_curPage);
}

-(void)reloadData{
    OneBannerData *one = [_bannersData.bannersAry objectAtIndex:_curPage];
    _titleLable.text = one.newsTitle;
    _beginScrollX = _curPage*SCREEN_WIDTH;
    _pageContrl.currentPage = _curPage;
}

@end
