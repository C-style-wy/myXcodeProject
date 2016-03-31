//
//  OneBannerData.m
//  henews
//
//  Created by 汪洋 on 15/11/18.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "OneBannerData.h"

@implementation OneBannerData

-(id)init{
    self = [super init];
    if (self) {
        _newsId = @"";
        _newsTitle = @"";
        _newsType = @"";
        _newsTag = @"";
        _imageUrl = @"";
        _url = @"";
    }
    return self;
}

-(void)initWithData:(id)data{
    if ([data objectForKey:@"newsId"] && ![[data objectForKey:@"newsId"] isEqualToString:@""]) {
        _newsId = [data objectForKey:@"newsId"];
    }
    
    if ([data objectForKey:@"newsTitle"] && ![[data objectForKey:@"newsTitle"] isEqualToString:@""]) {
        _newsTitle = [data objectForKey:@"newsTitle"];
    }
    if ([data objectForKey:@"newsType"] && ![[data objectForKey:@"newsType"] isEqualToString:@""]) {
        _newsType = [data objectForKey:@"newsType"];
    }
    NSArray *tempAry = [data objectForKey:@"newsTags"];
    if (tempAry && tempAry.count > 0) {
        NSString *tag = [[tempAry objectAtIndex:0] objectForKey:@"tag"];
        if (tag&&![tag isEqual:@""]) {
            _newsTag = tag;
        }
    }
    if ([data objectForKey:@"imageUrl"] && ![[data objectForKey:@"imageUrl"] isEqualToString:@""]) {
        _imageUrl = [data objectForKey:@"imageUrl"];
    }
    if ([data objectForKey:@"url"] && ![[data objectForKey:@"url"] isEqualToString:@""]) {
        _url = [data objectForKey:@"url"];
    }
}

@end
