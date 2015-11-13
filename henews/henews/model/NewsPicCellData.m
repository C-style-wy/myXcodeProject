//
//  NewsPicCellData.m
//  henews
//
//  Created by 汪洋 on 15/11/11.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "NewsPicCellData.h"

@implementation NewsPicCellData

-(id)init{
    self = [super init];
    if (self) {
        _picUrl = @"";
        _picFrame = CGRectMake(0, 0, 0, 0);
        _height = 0;
    }
    return self;
}

-(void)initWithData:(id)data{
    if ([data objectForKey:@"url"] && ![[data objectForKey:@"url"] isEqualToString:@""]) {
        _picUrl = [data objectForKey:@"url"];
        NSString *picW = [data objectForKey:@"width"];
        float width = [picW floatValue];
        
        NSString *picH = [data objectForKey:@"height"];
        float height = [picH floatValue];
        
        float picOnPhoneH = height*(SCREEN_WIDTH - 16)/width;
        _picFrame = CGRectMake(8, 0, SCREEN_WIDTH-16, picOnPhoneH);
        _height = picOnPhoneH + 9;
    }
}

@end
