//
//  NewsTitleMode.m
//  henews250
//
//  Created by 汪洋 on 2016/11/4.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NewsTitleMode.h"

@implementation NewsTitleMode

- (NewsTitleMode *)initWithData:(NewsDetailMode *)data {
    self = [super init];
    if (self) {
        ContentMode *cont = data.content;
        self.name = cont.name;
        self.source = cont.source;
        self.pubTime = cont.pubTime;
    }
    return self;
}

@end
