//
//  WelfareExchangeCell.m
//  henews250
//
//  Created by 汪洋 on 2016/10/13.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "WelfareExchangeCell.h"
#import "UIImageView+LoadFromWeb.h"
#import "UILabel+NeedWidthAndHeight.h"

@implementation WelfareExchangeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"WelfareExchangeCell" owner:self options:nil];
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

- (void)setObjcWith:(GoodsListModel*)data index:(NSInteger)index {
    [self bringSubviewToFront:self.bgView];
    [self.image loadFromWebWithUrlString:data.imageUrl animated:YES];
    if ((index%2) == 0) {
        self.contentLeading.constant = 9.0f;
        self.contentTrailing.constant = 4.5f;
    }else{
        self.contentLeading.constant = 4.5f;
        self.contentTrailing.constant = 9.0f;
    }
    
    self.nameLabel.text = data.title;
    self.scoreLabel.text = [data.costScore stringByAppendingString:@"积分"];
    self.scoreWidth.constant = [self.scoreLabel needWidth];
    
    [self setNeedsLayout];
}

@end
