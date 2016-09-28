//
//  TierHeadView.m
//  henews250
//
//  Created by 汪洋 on 16/7/27.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TierHeadView.h"

static NSString * const isEditKeyPath = @"isShowDelete";
@implementation TierHeadView

- (id)init {
    self = [super init];
    if (self) {
        self.addImage.transform = CGAffineTransformMakeRotation(PI/4);
        
        [self addObserver:self forKeyPath:isEditKeyPath options:NSKeyValueObservingOptionNew context:nil];
        self.isShowDelete = YES;
    }
    return self;
}

- (id)initWithName:(NSString*)name {
    self = [self init];
    if ([name isEqualToString:@"home"]) {
        self.titleLabel.text = @"我的专区";
    }else{
        self.titleLabel.text = @"我的频道";
    }
    
    return self;
}

- (IBAction)closeBtnSelect:(id)sender {
    if (self.isShowDelete) {
        if ([self.delegate respondsToSelector:@selector(closeTierManage:)]) {
            [self.delegate closeTierManage:self.addImage];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(closeTierFinish)]) {
            [self.delegate closeTierFinish];
        }
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (self.isShowDelete) {
        self.addImage.hidden = NO;
        self.finishLabel.hidden = YES;
    }else{
        self.addImage.hidden = YES;
        self.finishLabel.hidden = NO;
    }
}
@end
