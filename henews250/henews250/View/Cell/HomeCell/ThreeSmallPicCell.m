//
//  ThreeSmallPicCell.m
//  henews250
//
//  Created by 汪洋 on 16/7/21.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "ThreeSmallPicCell.h"

@implementation ThreeSmallPicCell{
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
    static NSString *identifer = @"ThreeSmallPicCell";
    ThreeSmallPicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ThreeSmallPicCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setNews:(NewsMode *)news hiddenLine:(BOOL)hidden isShortLine:(BOOL)isShort {
    _news = news;
    if (_news) {
        if (_news.images && _news.images.count > 0) {
            int length = _news.images.count > 3 ? 3 : (int)_news.images.count;
            for (int i = 0; i < length; i++) {
                ImageMode *image = [_news.images objectAtIndex:i];
                if (image && image.imageUrl && ![image.imageUrl isEqualToString:@""]) {
                    if (0 == i) {
                        [self.image1 loadFromWebWithUrlString:image.imageUrl animated:YES];
                    }else if (1 == i){
                        [self.image2 loadFromWebWithUrlString:image.imageUrl animated:YES];
                    }else if (2 == i){
                        [self.image3 loadFromWebWithUrlString:image.imageUrl animated:YES];
                    }
                    
                }
            }
        }
        
        if (_news.newsTitle && ![_news.newsTitle isEqualToString:@""]) {
            self.title.text = _news.newsTitle;
        }
        
        self.sourceWidth.constant = 0;
        
        if (_news.source && ![_news.source isEqualToString:@""]) {
            self.sourceWidth.constant = [_source needWidthWithText:_news.source];
            self.source.text = _news.source;
            self.pubTimeLeading.constant = 10.0f;
        }else{
            self.sourceWidth.constant = 0;
            self.pubTimeLeading.constant = 0;
        }
        if (_news.createTime && ![_news.createTime isEqualToString:@""]) {
            self.pubTimeWidth.constant = [_pubTime needWidthWithText:_news.createTime];
            self.pubTime.text = _news.createTime;
        }else{
            self.pubTimeWidth.constant = 0;
        }
        
        if (_news.pv && ![_news.pv isEqualToString:@""]) {
            self.pvWidth.constant = [_pv needWidthWithText:[_news.pv stringByAppendingString:@"阅"]];
            self.pv.text = [_news.pv stringByAppendingString:@"阅"];
        }
        
        _tag1.hidden = YES;
        _tag1Image.hidden = YES;
        
        if (_news.newsTags && _news.newsTags.count > 0) {
            TagMode *tag = [_news.newsTags objectAtIndex:0];
            _tag1Width.constant = [_tag1 needWidthWithText:tag.tag] + 10;
            _tag1.text = tag.tag;
            
            if ((_pubTime.frame.origin.x + _pubTime.frame.size.width + 5) > _tag1Image.frame.origin.x) {
                _tag1.hidden = YES;
                _tag1Image.hidden = YES;
            }else{
                _tag1Image.hidden = NO;
                _tag1.hidden = NO;
            }
        }else{
            _tag1.hidden = YES;
            _tag1Image.hidden = YES;
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
