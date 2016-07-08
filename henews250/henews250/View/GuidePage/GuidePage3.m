//
//  GuidePage3.m
//  henews250
//
//  Created by 汪洋 on 16/7/7.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "GuidePage3.h"

@implementation GuidePage3

- (id)init{
    self = [super init];
    if (self) {
        [self.enterButton addTarget:self action:@selector(enterButtonSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
    
}

- (void)enterButtonSelect:(UIButton*)button{
    if ([self.delegate respondsToSelector:@selector(enterAppBtnSelect)]) {
        [self.delegate enterAppBtnSelect];
    }
}

@end
