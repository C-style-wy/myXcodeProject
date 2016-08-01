//
//  TierHeadView.m
//  henews250
//
//  Created by 汪洋 on 16/7/27.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TierHeadView.h"

@implementation TierHeadView

- (id)init {
    self = [super init];
    if (self) {
        self.addImage.transform = CGAffineTransformMakeRotation(PI/4);
    }
    return self;
}

- (IBAction)closeBtnSelect:(id)sender {
    if ([self.delegate respondsToSelector:@selector(closeTierManage:)]) {
        [self.delegate closeTierManage:self.addImage];
    }
}


@end
