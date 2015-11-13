//
//  NewsContentCellData.m
//  henews
//
//  Created by 汪洋 on 15/11/11.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "NewsContentCellData.h"

@implementation NewsContentCellData

-(id)init{
    self = [super init];
    if (self) {
        _content = @"";
        _contentFrame = CGRectMake(0, 0, 0, 0);
        _height = 0;
    }
    return self;
}

-(void)initWithData:(NSString*)content{
    _content = content;
    
    UIFont *fnt = NEWS_CONTENT_SIZE;
    
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_content];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:NEWS_CONTENT_DIS];//调整行间距
//    
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_content length])];
    
    NSDictionary *attribute = @{NSFontAttributeName: fnt};
    CGFloat titleHeight = TEXTHEIGHT(_content, attribute, SCREEN_WIDTH-16);
    
    _contentFrame = CGRectMake(8, 0, SCREEN_WIDTH-16, titleHeight);
    _height = titleHeight+9;
}

@end
