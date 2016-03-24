//
//  picDetailData.m
//  henews
//
//  Created by 汪洋 on 15/12/14.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "picDetailData.h"

@implementation picDetailData

-(id)init{
    self = [super init];
    if (self) {
        _url = @"";
        _name = @"";
        _desc = @"";
        _tags = @"";
        _width = 0.0f;
        _height = 0.0f;
    }
    return self;
}

-(void)initWithData:(id)data{
    if ([data objectForKey:@"url"] && ![[data objectForKey:@"url"] isEqualToString:@""]) {
        self.url = [data objectForKey:@"url"];
    }
    if ([data objectForKey:@"name"] && ![[data objectForKey:@"name"] isEqualToString:@""]) {
        self.name = [data objectForKey:@"name"];
    }
    if ([data objectForKey:@"desc"] && ![[data objectForKey:@"desc"] isEqualToString:@""]) {
        self.desc = [data objectForKey:@"desc"];
    }
    if ([data objectForKey:@"tags"] && ![[data objectForKey:@"tags"] isEqualToString:@""]) {
        self.tags = [data objectForKey:@"tags"];
    }
    if ([data objectForKey:@"width"] && ![[data objectForKey:@"width"] isEqualToString:@""]) {
        self.width = [[data objectForKey:@"width"] floatValue];
    }
    if ([data objectForKey:@"height"] && ![[data objectForKey:@"height"] isEqualToString:@""]) {
        self.height = [[data objectForKey:@"height"] floatValue];
    }
}

@end
