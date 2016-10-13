//
//  WelfareScoresCell.m
//  henews250
//
//  Created by 汪洋 on 2016/10/13.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "WelfareScoresCell.h"
#import "UILabel+NeedWidthAndHeight.h"

@implementation WelfareScoresCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"WelfareScoresCell" owner:self options:nil];
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

- (void)setObjc {
    [self bringSubviewToFront: self.bgView];
    {
        self.scoreLabel.text = @"积分:?";
        self.scoreLabelWidth.constant = [self.scoreLabel needWidth];
    }
    {
        self.recordLabel.text = @"兑换记录";
        self.recordLabelWidth.constant = [self.recordLabel needWidth];
    }
    {
        self.howLabel.text = @"如何获得";
        self.howLabelWidth.constant = [self.howLabel needWidth];
    }
}
- (IBAction)howBtnSelect:(id)sender {
    
}
- (IBAction)recordBtnSelect:(id)sender {
    
}


@end
