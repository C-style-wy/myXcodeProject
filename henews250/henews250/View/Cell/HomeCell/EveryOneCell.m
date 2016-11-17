//
//  EveryOneCell.m
//  henews250
//
//  Created by 汪洋 on 16/7/20.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "EveryOneCell.h"

@implementation EveryOneCell{
    NewsMode *_news;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifer = @"EveryOneCell";
    EveryOneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EveryOneCell" owner:nil options:nil] firstObject];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = SelectColor;
    [cell layoutIfNeeded];
    return cell;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.image.image = nil;
}

- (void)setNews:(NewsMode *)news hiddenLine:(BOOL)hidden isShortLine:(BOOL)isShort{
    _news = news;
    if (_news) {
        if (_news.images && _news.images.count > 0) {
            ImageMode *image = [_news.images objectAtIndex:0];
            if (image && image.imageUrl && ![image.imageUrl isEqualToString:@""]) {
                [self.image loadFromWebWithUrlString:image.imageUrl animated:YES];
            }
        }
        if ([[ReadRecordManage shareInstance] isAlreadyReadWithId:_news.newsId]) {
            self.title.textColor = ReadColor;
        }else{
            self.title.textColor = TitleNorColor;
        }
        if (_news.newsTitle && ![_news.newsTitle isEqualToString:@""]) {
            if ([_title needHeightWithText:_news.newsTitle] > 18) {
                self.titleHeight.constant = 36.0f;
                self.summaryHeight.constant = 30.0f;
            }else{
                self.titleHeight.constant = 18.0f;
                self.summaryHeight.constant = 45.0f;
            }
            self.title.text = _news.newsTitle;
        }
        if (_news.newsIntro && ![_news.newsIntro isEqualToString:@""]) {
            self.summary.text = _news.newsIntro;
        }
    }
    
    if (isShort) {
        _lineLeading.constant = 8;
        _lineTrailing.constant = 8;
    }else{
        _lineLeading.constant = 0;
        _lineTrailing.constant = 0;
    }
    
    _line.hidden = hidden;
    [self layoutIfNeeded];
}

@end
