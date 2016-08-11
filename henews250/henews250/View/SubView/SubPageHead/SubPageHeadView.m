//
//  SubPageHeadView.m
//  henews250
//
//  Created by 汪洋 on 16/8/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SubPageHeadView.h"

@implementation SubPageHeadView


- (IBAction)backBtnSelect:(id)sender {
    if ([self.delegate respondsToSelector:@selector(pageBackBtnSelect)]) {
        [self.delegate pageBackBtnSelect];
    }
}
- (IBAction)shareBtnSelect:(id)sender {
    if ([self.delegate respondsToSelector:@selector(pageShareBtnSelect)]) {
        [self.delegate pageShareBtnSelect];
    }
}

@end
