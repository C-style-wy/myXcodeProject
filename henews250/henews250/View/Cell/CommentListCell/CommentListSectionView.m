//
//  CommentListSectionView.m
//  henews250
//
//  Created by 汪洋 on 2016/12/26.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "CommentListSectionView.h"

@implementation CommentListSectionView

- (void)setIsHot:(BOOL)isHot {
    _isHot = isHot;
    if (isHot) {
        self.headImage.image = [UIImage imageNamed:@"hot_comment"];
        self.headLabel.text = @"热门评论";
    }else{
        self.headImage.image = [UIImage imageNamed:@"new_comment"];
        self.headLabel.text = @"最新评论";
    }
}

@end
