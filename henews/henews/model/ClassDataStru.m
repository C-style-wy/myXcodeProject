//
//  ClassDataStru.m
//  henews
//
//  Created by 汪洋 on 15/11/6.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "ClassDataStru.h"

@implementation ClassDataStru

-(id)init{
    self = [super init];
    if (self) {
        self.needReflush = YES;
        self.curPosition = 0.0f;
        self.data = [[NSMutableArray alloc]init];
        self.reflushUrl = @"";
        self.loadingMoreUrl = @"";
    }
    return self;
}

@end
