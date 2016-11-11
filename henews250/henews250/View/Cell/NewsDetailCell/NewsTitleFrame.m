//
//  NewsTitleFrame.m
//  henews250
//
//  Created by 汪洋 on 2016/11/9.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NewsTitleFrame.h"

@implementation NewsTitleFrame

- (void)setNewsTitle:(NewsTitleMode *)newsTitle {
    _newsTitle = newsTitle;
    
    CGFloat titleTopPadding = 10.0f;
    CGFloat rightAndLeftPadding = 9;
    CGFloat titleWidth = SCREEN_WIDTH - rightAndLeftPadding*2;
    SHLUILabel *titleLabel = [[SHLUILabel alloc] init];
    titleLabel.linesSpacing = TitleLineSpace;
    titleLabel.font = TitleFont;
    titleLabel.text = _newsTitle.name;
    CGFloat titleHeight = [titleLabel getAttributedStringHeightWidthValue:titleWidth];
    
    _titleFrame = CGRectMake(rightAndLeftPadding, titleTopPadding, titleWidth, titleHeight);
    
    
    CGFloat sourceTopPadding = 6.0f;
    UILabel *testLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 14)];
    testLabel.font = SourceAndTimeFont;
    
    _sourceFrame = CGRectMake(rightAndLeftPadding, titleTopPadding+titleHeight+sourceTopPadding, [testLabel needWidthWithText:_newsTitle.source], 14);
    _timeFrame = CGRectMake(rightAndLeftPadding+[testLabel needWidthWithText:_newsTitle.source]+8, titleTopPadding+titleHeight+sourceTopPadding, [testLabel needWidthWithText:_newsTitle.pubTime], 14);
    
    _cellHeight = titleTopPadding + titleHeight + sourceTopPadding + 14;
}

@end
