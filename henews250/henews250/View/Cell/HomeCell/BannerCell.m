//
//  BannerCell.m
//  henews250
//
//  Created by 汪洋 on 16/7/22.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BannerCell.h"
#import "UIView+SetAllSubViewHidden.h"

@implementation BannerCell {
    NSMutableArray *_banners;
    NSInteger _currentPage;
    CGFloat _beginScrollX;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifer = @"BannerCell";
    BannerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BannerCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setNews:(NSMutableArray *)banners hiddenLine:(BOOL)hidden {
    if (banners && banners.count > 0) {
        _banners = banners;
        _currentPage = 0;
        [self.bannerScrol.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.bannerScrol.contentOffset = CGPointMake(0, 0);
        for (int i = 0; i < _banners.count; i++) {
            BannerMode *banner = [_banners objectAtIndex:i];
            BannerImageView *imageView = [[BannerImageView loadFromNib]initWithData:banner];
            imageView.frame = CGRectMake(SCREEN_WIDTH*i, 0, self.bannerScrol.bounds.size.width, self.bannerScrol.bounds.size.height);
            [self.bannerScrol addSubview:imageView];
        }
        self.bannerScrol.contentSize = CGSizeMake(SCREEN_WIDTH*_banners.count, 0);
        self.bannerScrol.delegate = self;
        self.pageControl.numberOfPages = banners.count;
        self.pageControlWidth.constant = [_pageControl sizeForNumberOfPages:banners.count].width;
        [self setScrollerAction];
    }
    _line.hidden = hidden;
}

- (void)setScrollerAction {
    self.pageControl.currentPage = _currentPage;
    _beginScrollX = _currentPage*SCREEN_WIDTH;
    if (_banners.count > 0 && [_banners objectAtIndex:_currentPage]) {
        BannerMode *banner = [_banners objectAtIndex:_currentPage];
        float tagWidth = 0;
        if (banner.newsTags && (banner.newsTags.count > 0)) {
            TagMode *tag = [banner.newsTags objectAtIndex:0];
            _tagLabelWidth.constant = [_tagLabel needWidthWithText:tag.tag] + 10;
            tagWidth = [_tagLabel needWidthWithText:tag.tag] + 10;
            _tagLabel.text = tag.tag;
            _tagLabel.hidden = NO;
            _tagImage.hidden = NO;
            _titleLeading.constant = 10.0f;
        }else{
            _tagLabel.hidden = YES;
            _tagImage.hidden = YES;
            _tagLabelWidth.constant = 0;
            _titleLeading.constant = 0;
        }
        if (banner.newsTitle) {
            _titleWidth.constant = SCREEN_WIDTH-16-(tagWidth+10+[_pageControl sizeForNumberOfPages:_banners.count].width+10);
            _title.text = banner.newsTitle;
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //得到当前页数
    float x = scrollView.contentOffset.x;
    if (x < _beginScrollX) {
        _currentPage--;
        [self setScrollerAction];
    }
    //往前翻
    if (x > _beginScrollX) {
        _currentPage++;
        [self setScrollerAction];
    }
}
@end
