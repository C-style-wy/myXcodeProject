//
//  LinkReadMode.m
//  henews250
//
//  Created by 汪洋 on 2016/11/16.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "LinkReadMode.h"

@implementation LinkReadMode

- (LinkReadMode *)initWithData:(NewsDetailMode *)data {
    self = [super init];
    if (self) {
        self.linkUrl = data.content.link;
    }
    return self;
}

@end
