//
//  NewsLinkCellData.m
//  henews
//
//  Created by 汪洋 on 16/3/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NewsLinkCellData.h"

@implementation NewsLinkCellData

-(id)init{
    self = [super init];
    if (self) {
        self.linkUrl = @"";
        self.height = 34.0f;
    }
    return self;
}

-(void)initWithData:(NSString*)url{
    self.linkUrl = url;
}

@end
