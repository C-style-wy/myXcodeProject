//
//  TierCollectionViewCell.m
//  henews250
//
//  Created by 汪洋 on 16/7/29.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TierCollectionViewCell.h"

@implementation TierCollectionViewCell {
    TierMode *_tier;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"TierCollectionViewCell" owner:self options:nil];
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

- (void)initWithData:(TierMode *)data hiddenDelete:(BOOL)hiddenDelete {
    _tier = data;
    if (_tier.isHot && [_tier.isHot intValue] == 1) {
        self.hotImage.hidden = NO;
    }else{
        self.hotImage.hidden = YES;
    }
    if (_tier.showAllTime && [_tier.showAllTime intValue] == 1) {
        self.bgImage.image = [UIImage imageNamed:@"tierNotSelectBg"];
        self.name.textColor = [UIColor colorWithHexColor:@"#e40776"];
    }else{
        self.bgImage.image = [UIImage imageNamed:@"tierBgImage"];
        self.name.textColor = [UIColor colorWithHexColor:@"#1e1e1e"];
    }
    self.name.text = data.nodeName;
    self.deleteImage.hidden = hiddenDelete;
}

@end
