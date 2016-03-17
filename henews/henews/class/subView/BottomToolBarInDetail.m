//
//  BottomToolBarInDetail.m
//  henews
//
//  Created by 汪洋 on 16/3/15.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BottomToolBarInDetail.h"

@implementation BottomToolBarInDetail

- (id)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 35);
        
        self.backgroundColor = [UIColor whiteColor];
        //评论框
        UIButton *commentBtn = [[UIButton alloc]initWithFrame:CGRectMake(8, 0, 170, 35)];
        [commentBtn addTarget:self action:@selector(handleCommentBtnSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [commentBtn setImage:[UIImage imageNamed:@"detail_comment_box.png"] forState:UIControlStateNormal];
        [commentBtn setImageEdgeInsets:UIEdgeInsetsMake(4.0f, 0.0f, 4.0f, 0.0f)];
        [self addSubview:commentBtn];
        //评论数
        UIButton *commentNumBtn = [[UIButton alloc]initWithFrame:CGRectMake(185, 0, 58.5, 35)];
        [commentNumBtn addTarget:self action:@selector(handleCommentNumBtnSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [commentNumBtn setImage:[UIImage imageNamed:@"detail_comment_bg.png"] forState:UIControlStateNormal];
        [commentNumBtn setImageEdgeInsets:UIEdgeInsetsMake(9.0f, 0.0f, 9.0f, 0.0f)];
        [self addSubview:commentNumBtn];
        //字体大小调整
        UIButton *fontSizeBtn = [[UIButton alloc]initWithFrame:CGRectMake(250.5f, 0, 35.5, 35)];
        [fontSizeBtn addTarget:self action:@selector(handleFontSizeBtnSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [fontSizeBtn setImage:[UIImage imageNamed:@"detail_fontsize_icon.png"] forState:UIControlStateNormal];
        [fontSizeBtn setImageEdgeInsets:UIEdgeInsetsMake(4.5f, 0.0f, 4.5f, 9.0f)];
        [self addSubview:fontSizeBtn];
        //分享
        UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-35.5, 0, 35.5, 35)];
        [shareBtn addTarget:self action:@selector(handleShareBtnSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [shareBtn setImage:[UIImage imageNamed:@"detail_share_icon.png"] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:@"newShare_s.png"] forState:UIControlStateHighlighted];
        [shareBtn setImageEdgeInsets:UIEdgeInsetsMake(4.5f, 0.0f, 4.5f, 9.0f)];
        [self addSubview:shareBtn];
    }
    
    return self;
}

- (void)openToolBar{
    [UIView animateWithDuration:0.5f animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT-35, SCREEN_WIDTH, 35);
    }];
}

- (void)closeToolBar{
    [UIView animateWithDuration:0.5f animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 35);
    }];
}

- (void)moveDownToolBar:(CGFloat) distance{
    if (self.frame.origin.y < SCREEN_HEIGHT) {
        self.frame = CGRectMake(0, (self.frame.origin.y + distance), SCREEN_WIDTH, 35);
    }
}

- (void)moveUpToolBar:(CGFloat) distance{
    if (self.frame.origin.y > SCREEN_HEIGHT - 35) {
        self.frame = CGRectMake(0, (self.frame.origin.y - distance), SCREEN_WIDTH, 35);
    }
}

//评论框按钮
- (void)handleCommentBtnSelectAction:(UIButton *)button{
    
}
//评论数按钮
- (void)handleCommentNumBtnSelectAction:(UIButton *)button{
    
}

//调整字体大小按钮
- (void)handleFontSizeBtnSelectAction:(UIButton *)button{
    
}

//分享按钮
- (void)handleShareBtnSelectAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(toolBar:shareButton:)]) {
        [self.delegate toolBar:self shareButton:button];
    }
}
@end