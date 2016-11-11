//
//  DetailPicAndContentFrame.m
//  henews250
//
//  Created by 汪洋 on 2016/11/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "DetailPicAndContentFrame.h"

@implementation DetailPicAndContentFrame

- (void)setContentMode:(SubContentMode *)contentMode {
    _contentMode = contentMode;
    
    CGFloat rightAndLeftPadding = 9;
    
    CGFloat contentHeight = 0;
    CGFloat contentWidth = SCREEN_WIDTH - rightAndLeftPadding*2;
    
    CGFloat contentPicSpace = ContentPicSpace;
    
    _cellHeight = 0;
    
    if (contentMode.content && ![contentMode.content isEqualToString:@""]) {
        
        
        SHLUILabel *contentLabel = [[SHLUILabel alloc] init];
        contentLabel.linesSpacing = ContentLineSpace;
        contentLabel.font = ContentFont;
        contentLabel.text = contentMode.content;
        contentHeight = [contentLabel getAttributedStringHeightWidthValue:contentWidth];
        _cellHeight = _cellHeight + contentHeight;
    }else{
        contentPicSpace = 0;
    }
    _textFrame = CGRectMake(0, 0, contentWidth, contentHeight);
    
    
}

@end
