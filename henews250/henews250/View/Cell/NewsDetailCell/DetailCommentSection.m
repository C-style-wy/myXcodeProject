//
//  DetailCommentSection.m
//  henews250
//
//  Created by 汪洋 on 2016/11/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "DetailCommentSection.h"

@implementation DetailCommentSection

- (DetailCommentSection *)initWithSectionType:(SectionType)sectionType {
    self = [super init];
    if (self) {
        if (sectionType == SectionTypeComment) {
            self.detail_comment_list_icon.image = [UIImage imageNamed:@"detail_comment_list_icon"];
            self.sectionLabel.text = @"精彩评论";
        }else if (sectionType == SectionTypeRecommend) {
            self.detail_comment_list_icon.image = [UIImage imageNamed:@"detail_relation_icon"];
            self.sectionLabel.text = @"推荐新闻";
        }
    }
    return self;
}

@end
