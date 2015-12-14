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
    _url = [data objectForKey:@"url"];
    _name = [data objectForKey:@"name"];
    _desc = [data objectForKey:@"desc"];
    _tags = [data objectForKey:@"tags"];
    _width = [[data objectForKey:@"width"] floatValue];
    _height = [[data objectForKey:@"height"] floatValue];
}

@end
