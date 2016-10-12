//
//  TestCollectionViewCell.m
//  henews250
//
//  Created by 汪洋 on 2016/10/12.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TestCollectionViewCell.h"

@implementation TestCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    return self;
}

- (void)setNews:(NSArray *)banners {
    self.backgroundColor = [UIColor redColor];
}

@end
