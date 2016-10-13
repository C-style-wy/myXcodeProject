//
//  WelfareActivityCell.m
//  henews250
//
//  Created by 汪洋 on 2016/10/13.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "WelfareActivityCell.h"
#import "UIImageView+LoadFromWeb.h"

@implementation WelfareActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"WelfareActivityCell" owner:self options:nil];
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
    }
    return self;
}

- (void)setObjcWith:(GoodsListModel*)data {
    [self bringSubviewToFront:self.bgView];
    [self.image loadFromWebWithUrlString:data.imageUrl animated:YES];
}
@end
