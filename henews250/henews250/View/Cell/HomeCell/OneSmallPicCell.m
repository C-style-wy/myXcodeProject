//
//  OneSmallPicCell.m
//  henews250
//
//  Created by 汪洋 on 16/7/19.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "OneSmallPicCell.h"

@implementation OneSmallPicCell{
    NewsMode *_news;
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
    static NSString *identifer = @"OneSmallPicCell";
    OneSmallPicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OneSmallPicCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setNews:(NewsMode *)news hiddenLine:(BOOL)hidden isShortLine:(BOOL)isShort {
    _news = news;
    if (_news) {
        if (_news.images && _news.images.count > 0) {
            ImageMode *image = [_news.images objectAtIndex:0];
            if (image && image.imageUrl && ![image.imageUrl isEqualToString:@""]) {            
                [self.image loadFromWebWithUrlString:image.imageUrl animated:YES];
            }
        }
        if (_news.newsTitle && ![_news.newsTitle isEqualToString:@""]) {
            if ([_title neetHeightWithText:_news.newsTitle] > 18) {
                self.titleHeight.constant = 36.0f;
                self.summary.hidden = YES;
            }else{
                self.titleHeight.constant = 18.0f;
                self.summary.hidden = NO;
            }
            self.title.text = _news.newsTitle;
        }
        if (_news.newsIntro && ![_news.newsIntro isEqualToString:@""]) {
            self.summary.text = _news.newsIntro;
        }
        
        self.sourceWidth.constant = 0;
        
        if (_news.source && ![_news.source isEqualToString:@""]) {
            self.sourceWidth.constant = [_source neetWidthWithText:_news.source];
            self.source.text = _news.source;
            self.pubTimeLeading.constant = 10.0f;
        }else{
            self.sourceWidth.constant = 0;
            self.pubTimeLeading.constant = 0;
        }
        if (_news.createTime && ![_news.createTime isEqualToString:@""]) {
            self.pubTimeWidth.constant = [_pubTime neetWidthWithText:_news.createTime];
            self.pubTime.text = _news.createTime;
        }else{
            self.pubTimeWidth.constant = 0;
        }
        
        if (_news.pv && ![_news.pv isEqualToString:@""]) {
            self.pvWidth.constant = [_pv neetWidthWithText:[_news.pv stringByAppendingString:@"阅"]];
            self.pv.text = [_news.pv stringByAppendingString:@"阅"];
        }
        
        _tagLabel.hidden = YES;
        _tagImage.hidden = YES;
        
        if (_news.newsTags && _news.newsTags.count > 0) {
            TagMode *tag = [_news.newsTags objectAtIndex:0];
            _tagLabelWidth.constant = [_tagLabel neetWidthWithText:tag.tag] + 10;
            _tagLabel.text = tag.tag;
            
            if ((_pubTime.frame.origin.x + _pubTime.frame.size.width + 5) > _tagImage.frame.origin.x) {
                _tagLabel.hidden = YES;
                _tagImage.hidden = YES;
            }else{
                _tagImage.hidden = NO;
                _tagLabel.hidden = NO;
            }
        }else{
            _tagLabel.hidden = YES;
            _tagImage.hidden = YES;
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
}

@end
