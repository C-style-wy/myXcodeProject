//
//  ChoiceImgSource.m
//  henews250
//
//  Created by 汪洋 on 2016/10/22.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "ChoiceImgSource.h"
#import "UIView+LoadFromNib.h"

@implementation ChoiceImgSource
+ (ChoiceImgSource*)shareInstance {
    static ChoiceImgSource *view;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [self loadFromNib];
    });
    return view;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    self.frame = newSuperview.bounds;
    self.viewTop.layer.masksToBounds = YES;
    self.viewTop.layer.cornerRadius = 6.0f;
    self.viewBlow.layer.masksToBounds = YES;
    self.viewBlow.layer.cornerRadius = 6.0f;
    self.bgView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.0f];
//    [self layoutIfNeeded];
    self.btnViewBottom.constant = self.btnView.frame.size.height;
//    [self layoutIfNeeded];
}

- (IBAction)photoBtnSelect:(id)sender {
    [self removeFromSuperview];
//    if (self.photoBlock) {
//        self.photoBlock();
//    }
    if (self.tagrget && [self.tagrget respondsToSelector:self.photoAction]) {
//        SEL selector = NSSelectorFromString(@"processRegion:ofView:");
        SEL selector = self.photoAction;
        IMP imp = [self.tagrget methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(self.tagrget, selector);
        //会警告
//        [self.tagrget performSelector:self.photoAction];
    }
}
- (IBAction)albumBtnSelect:(id)sender {
    [self removeFromSuperview];
//    if (self.albumBlock) {
//        self.albumBlock();
//    }
    if (self.tagrget && [self.tagrget respondsToSelector:self.albumAction]) {
        SEL selector = self.albumAction;
        IMP imp = [self.tagrget methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(self.tagrget, selector);
//        [self.tagrget performSelector:self.albumAction];
    }
}

- (IBAction)cannelBtnSelect:(id)sender {
    [self dismiss];
}
- (IBAction)bgBtnSelect:(id)sender {
    [self dismiss];
}


- (void)showWithSupView:(UIView *)newSupview photoBlock:(PhotoBlock)photoBlock albumBlock:(AlbumBlock)albumBlock {
    self.photoBlock = photoBlock;
    self.albumBlock = albumBlock;
    [newSupview addSubview:self];
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.3f animations:^{
        self.bgView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3f];
    } completion:^(BOOL finished) {
        
    }];
    self.btnViewBottom.constant = 0;
    [UIView animateWithDuration:0.3f animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showWithSupView:(UIView *)newSupview target:(id)target photoAction:(SEL)photoAction albumAction:(SEL)albumAction {
    self.tagrget = target;
    self.photoAction = photoAction;
    self.albumAction = albumAction;
    [newSupview addSubview:self];
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.3f animations:^{
        self.bgView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3f];
    } completion:^(BOOL finished) {
        
    }];
    self.btnViewBottom.constant = 0;
    [UIView animateWithDuration:0.3f animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3f animations:^{
        self.bgView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.0f];
    } completion:^(BOOL finished) {
        
    }];
    self.btnViewBottom.constant = self.btnView.frame.size.height;
    [UIView animateWithDuration:0.3f animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
