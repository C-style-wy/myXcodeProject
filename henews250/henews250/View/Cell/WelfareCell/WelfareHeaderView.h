//
//  WelfareHeaderView.h
//  henews250
//
//  Created by 汪洋 on 2016/10/13.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaListModel.h"

@interface WelfareHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *areaName;
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

- (void)setObjcWithData:(AreaListModel *)data;

@end
