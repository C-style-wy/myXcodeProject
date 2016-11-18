//
//  TopicTitleModel.m
//  henews250
//
//  Created by 汪洋 on 2016/11/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TopicTitleModel.h"

@implementation TopicTitleModel

- (TopicTitleModel *)initWithData:(TopicModel *)data {
    self = [super init];
    if (self) {
        self.imageUrl = data.imageUrl;
        self.topicIntro = data.newsIntro;
    }
    return self;
}

@end
