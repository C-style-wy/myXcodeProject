//
//  WelfareHeaderView.m
//  henews250
//
//  Created by 汪洋 on 2016/10/13.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "WelfareHeaderView.h"

@implementation WelfareHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setObjcWithData:(AreaListModel *)data {
    [self bringSubviewToFront:self.bgView];
    self.areaName.text = data.name;
    if (data.moreUrl && ![data.moreUrl isEqualToString:@""]) {
        self.moreBtn.hidden = NO;
        self.moreLabel.hidden = NO;
    }else{
        self.moreBtn.hidden = YES;
        self.moreLabel.hidden = YES;
    }
}

- (IBAction)moreBtnSelect:(id)sender {
}

@end
