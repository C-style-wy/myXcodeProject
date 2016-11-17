//
//  NewsSectionMode.m
//  henews250
//
//  Created by 汪洋 on 2016/11/2.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NewsSectionMode.h"

@implementation NewsSectionMode

- (NewsSectionMode *)initWithData:(NewsDetailMode *)data {
    self = [super init];
    if (self) {
        self.sectionType = SectionTypeNews;
        if (!self.newsSectionAry) {
            self.newsSectionAry = [[NSMutableArray alloc]init];
        }
        [self.newsSectionAry removeAllObjects];
        // 标题+source+时间
        NewsTitleMode *title = [[NewsTitleMode alloc]initWithData:data];
        [self.newsSectionAry addObject:title];
        // 分享
        DetailShareMode *share = [[DetailShareMode alloc]initWithData:data];
        [self.newsSectionAry addObject:share];
        // 图文混排
        ContentMode *contentData = data.content;
        NSArray *newsContent = contentData.content;
        
        for (int i = 0; i < newsContent.count; i++) {
            SubContentMode *subContent = [newsContent objectAtIndex:i];
            [subContent handleContent];
            [self.newsSectionAry addObject:subContent];
        }
        
        if (data && data.content && data.content.link && ![data.content.link isEqualToString:@""]) {
            LinkReadMode *linkReadData = [[LinkReadMode alloc]initWithData:data];
            [self.newsSectionAry addObject:linkReadData];
        }
        // 点赞
        SpotMode *spot = [[SpotMode alloc]init];
        [self.newsSectionAry addObject:spot];
    }
    return self;
}

- (NewsSectionMode *)initWithCommentData:(NewsDetailMode *)data {
    self = [super init];
    if (self) {
        self.sectionType = SectionTypeComment;
        if (!self.newsSectionAry) {
            self.newsSectionAry = [[NSMutableArray alloc]init];
        }
        [self.newsSectionAry removeAllObjects];
        NSString *loadingStr = @"正在获取评论数据...";
        [self.newsSectionAry addObject:loadingStr];
    }
    return self;
}

- (NewsSectionMode *)initWithRelateContsData:(NewsDetailMode *)data {
    self = [super init];
    if (self) {
        self.sectionType = SectionTypeRecommend;
        if (!self.newsSectionAry) {
            self.newsSectionAry = [[NSMutableArray alloc]init];
        }
        [self.newsSectionAry removeAllObjects];
        self.newsSectionAry = [data.relateConts copy];
    }
    return self;
}

@end
