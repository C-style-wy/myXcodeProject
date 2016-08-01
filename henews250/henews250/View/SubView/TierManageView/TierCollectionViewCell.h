//
//  TierCollectionViewCell.h
//  henews250
//
//  Created by 汪洋 on 16/7/29.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TierMode.h"
#import "UIColor+hexColor.h"

@interface TierCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *hotImage;
@property (weak, nonatomic) IBOutlet UIImageView *deleteImage;


- (void)initWithData:(TierMode *)data;
@end
