//
//  NewsTitleCellData.m
//  henews
//
//  Created by 汪洋 on 15/11/11.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "NewsTitleCellData.h"

@implementation NewsTitleCellData

-(id)init{
    self = [super init];
    if (self) {
        _title = @"";
        _sourceAndTime = @"";
        _titleFrame = CGRectMake(0, 0, 0, 0);
        _timeFrame = CGRectMake(0, 0, 0, 0);
        _height = 0;
    }
    return self;
}

-(void)initWithData:(NSString*)newsTitle source:(NSString*)newsSource time:(NSString*)time{
    if (newsTitle) {
        _title = newsTitle;
    }
    NSString *str = @"";
    if (newsSource && ![newsSource isEqual:@""]) {
        str = [newsSource stringByAppendingString:@"  "];
        if (time) {
            str = [str stringByAppendingString:time];
        }
    }else{
        if (time) {
            str = time;
        }
    }
    _sourceAndTime = str;
    
    UIFont *fnt = NEWS_TITLE_SIZE;
    NSDictionary *attribute = @{NSFontAttributeName: fnt};
    CGFloat titleHeight = TEXTHEIGHT(_title, attribute, SCREEN_WIDTH-16);
    
    _titleFrame = CGRectMake(8, 10, SCREEN_WIDTH-16, titleHeight);
    _timeFrame = CGRectMake(8, 16+titleHeight, SCREEN_WIDTH-16, 12);
    _height = titleHeight+28;
}

@end
