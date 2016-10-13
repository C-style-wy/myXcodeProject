//
//  BigDefaultImageVIew.m
//  henews250
//
//  Created by 汪洋 on 2016/10/13.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BigDefaultImageView.h"
#import "UIImageView+LoadFromWeb.h"
#import "UIView+LoadFromNib.h"

@implementation BigDefaultImageView

- (id)init {
    self = [super init];
    if (self) {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"BigDefaultImageView" owner:self options:nil];
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1){
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
        [self setNeedsLayout];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"BigDefaultImageView" owner:self options:nil];
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1){
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
        [self setNeedsLayout];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"BigDefaultImageView" owner:self options:nil];
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1){
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
        [self setNeedsLayout];
    }
    return self;
}


- (void)setImageUrl:(NSString *)imageUrl {
    [self.imageView loadFromWebWithUrlString:imageUrl animated:YES];
}

@end
