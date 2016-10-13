//
//  WelfareExchangeCell.h
//  henews250
//
//  Created by 汪洋 on 2016/10/13.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListModel.h"

@interface WelfareExchangeCell : UICollectionViewCell

- (void)setObjcWith:(GoodsListModel*)data index:(NSInteger)index;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTrailing;

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scoreWidth;

@end
