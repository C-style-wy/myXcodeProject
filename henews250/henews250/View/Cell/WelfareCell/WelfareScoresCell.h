//
//  WelfareScoresCell.h
//  henews250
//
//  Created by 汪洋 on 2016/10/13.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelfareScoresCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scoreLabelWidth;
@property (weak, nonatomic) IBOutlet UILabel *recordLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *recordLabelWidth;
@property (weak, nonatomic) IBOutlet UILabel *howLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *howLabelWidth;

- (void)setObjc;

@end
