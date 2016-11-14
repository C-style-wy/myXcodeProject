//
//  MyListView.m
//  henews250
//
//  Created by 汪洋 on 16/9/29.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "MyListView.h"

@implementation MyListView

- (IBAction)myMsgBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(btnActionWithTag:)]) {
        [self.delegate btnActionWithTag:1];
    }
}

- (IBAction)myJoinBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(btnActionWithTag:)]) {
        [self.delegate btnActionWithTag:2];
    }
}
- (IBAction)myCollectionBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(btnActionWithTag:)]) {
        [self.delegate btnActionWithTag:3];
    }
}
- (IBAction)mySubscribeBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(btnActionWithTag:)]) {
        [self.delegate btnActionWithTag:4];
    }
}
- (IBAction)myIntegralBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(btnActionWithTag:)]) {
        [self.delegate btnActionWithTag:5];
    }
}
- (IBAction)settingBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(btnActionWithTag:)]) {
        [self.delegate btnActionWithTag:6];
    }
    
}

@end
