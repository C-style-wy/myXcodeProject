//
//  TopicTitleFrame.m
//  henews250
//
//  Created by 汪洋 on 2016/11/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TopicTitleFrame.h"

@implementation TopicTitleFrame

- (void)setTopicTitleModel:(TopicTitleModel *)topicTitleModel {
    _topicTitleModel = topicTitleModel;
    _cellHeight = 0;
    CGFloat introY = 0;
    if (_topicTitleModel.imageUrl && ![_topicTitleModel.imageUrl isEqualToString:@""]) {
        _cellHeight = _cellHeight + SCREEN_WIDTH*146.0f/320.0f;
        introY = introY + _cellHeight + IntroPicSpace;
    }
    _topicImageFrame = CGRectMake(0, 0, SCREEN_WIDTH, _cellHeight);
    CGFloat rightAndLeftPadding = 8;
    CGFloat contentHeight = 0;
    CGFloat contentWidth = SCREEN_WIDTH - 2*rightAndLeftPadding;
    if (_topicTitleModel.topicIntro && ![_topicTitleModel.topicIntro isEqualToString:@""]) {
        SHLUILabel *contentLabel = [[SHLUILabel alloc] init];
        contentLabel.linesSpacing = IntroLineSpace;
        contentLabel.font = IntroFont;
        contentLabel.text = _topicTitleModel.topicIntro;
        contentHeight = [contentLabel getAttributedStringHeightWidthValue:contentWidth];
        
        _cellHeight = _cellHeight + IntroPicSpace + contentHeight + IntroPicSpace;
    }
    _topicIntroFrame = CGRectMake(rightAndLeftPadding, introY, contentWidth, contentHeight);
}

@end
