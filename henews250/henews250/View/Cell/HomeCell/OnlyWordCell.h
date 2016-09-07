//
//  OnlyWordCell.h
//  henews250
//
//  Created by 汪洋 on 16/9/7.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"

@interface OnlyWordCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeight;

@property (weak, nonatomic) IBOutlet UILabel *summary;

@property (weak, nonatomic) IBOutlet UILabel *source;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sourceWidth;

@property (weak, nonatomic) IBOutlet UILabel *pubTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pubTimeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pubTimeLeading;

@property (weak, nonatomic) IBOutlet UILabel *pv;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pvWidth;

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tagImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagLabelWidth;

@property (weak, nonatomic) IBOutlet UIImageView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineTrailing;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setNews:(NewsMode *)news hiddenLine:(BOOL)hidden isShortLine:(BOOL)isShort;
@end
