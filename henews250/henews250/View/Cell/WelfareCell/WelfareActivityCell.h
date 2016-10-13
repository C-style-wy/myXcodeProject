//
//  WelfareActivityCell.h
//  henews250
//
//  Created by 汪洋 on 2016/10/13.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListModel.h"

@interface WelfareActivityCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *image;

- (void)setObjcWith:(GoodsListModel*)data;

@end
