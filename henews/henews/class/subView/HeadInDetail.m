//
//  HeadInDetail.m
//  henews
//
//  Created by 汪洋 on 16/3/15.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "HeadInDetail.h"

@implementation HeadInDetail

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //返回按钮
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, frame.size.height)];
        backBtn.tag = 1;
        [backBtn addTarget:self action:@selector(handleBtnSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        [backBtn setImage:[UIImage imageNamed:@"new_back.png"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"new_back_sel.png"] forState:UIControlStateHighlighted];
        [backBtn setImageEdgeInsets:UIEdgeInsetsMake(5.0f, 8.0f, 5.0f, 29)];
        //收藏按钮
        UIButton *collectionBtn = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-78, 0, 40, frame.size.height)];
        collectionBtn.tag = 2;
        [collectionBtn addTarget:self action:@selector(handleBtnSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:collectionBtn];
        [collectionBtn setImage:[UIImage imageNamed:@"detail_collect_icon.png"] forState:UIControlStateNormal];
        [collectionBtn setImageEdgeInsets:UIEdgeInsetsMake(5.0f, 17.0f, 5.0f, 0.0f)];
        //夜间模式按钮
        UIButton *modeBtn = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-31, 0, 31, frame.size.height)];
        modeBtn.tag = 0;
        [modeBtn addTarget:self action:@selector(handleModeBtnSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:modeBtn];
        [modeBtn setImage:[UIImage imageNamed:@"detail_night_icon.png"] forState:UIControlStateNormal];
        [modeBtn setImageEdgeInsets:UIEdgeInsetsMake(5.0f, 0.0f, 5.0f, 8)];
    }
    return self;
}


- (void)handleBtnSelectAction:(UIButton *)button {
    if (button.tag == 1) {
        if ([self.delegate respondsToSelector:@selector(headInDetail:backButton:)]) {
            [self.delegate headInDetail:self backButton:button];
        }
    }else if (button.tag == 2){
        if ([self.delegate respondsToSelector:@selector(headInDetail:collectionButton:)]) {
            [self.delegate headInDetail:self collectionButton:button];
        }
    }
}

- (void)handleModeBtnSelectAction:(UIButton *)button {
    if (button.tag == 0) {
        button.tag = 1;
        [button setImage:[UIImage imageNamed:@"detail_day_icon.png"] forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(headInDetail:modeButton:isNight:)]) {
            [self.delegate headInDetail:self modeButton:button isNight:YES];
        }
    }else{
        button.tag = 0;
        [button setImage:[UIImage imageNamed:@"detail_night_icon.png"] forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(headInDetail:modeButton:isNight:)]) {
            [self.delegate headInDetail:self modeButton:button isNight:NO];
        }
    }
}
@end
