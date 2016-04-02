//
//  HeadInPicDetail.m
//  henews
//
//  Created by 汪洋 on 16/3/22.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "HeadInPicDetail.h"

@interface HeadInPicDetail ()
{
    UILabel *commentNumLabel;
    UIImageView *commentNumImage;
}
@end

@implementation HeadInPicDetail

- (id)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 58.0f);
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH, 33.0f)];
        view.backgroundColor = [UIColor clearColor];
        [self addSubview:view];
        
        //返回按钮
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, view.frame.size.height)];
        [backBtn addTarget:self action:@selector(handleBtnSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:backBtn];
        [backBtn setImage:[UIImage imageNamed:@"detail_back_night.png"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"newBackSel_black.png"] forState:UIControlStateHighlighted];
        [backBtn setImageEdgeInsets:UIEdgeInsetsMake(5.0f, 8.0f, 5.0f, 29)];
        //评论按钮
        commentNumImage = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width-41-48.5f, (view.frame.size.height-17.5f)/2, 48.5f, 17.5f)];
        commentNumImage.image = [UIImage imageNamed:@"detail_comment_bg.png"];
        [view addSubview:commentNumImage];
        
        commentNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(view.frame.size.width-41-48.5f, (view.frame.size.height-17.5f)/2, 48.5f, 17.5f)];
        commentNumLabel.text = @"0评论";
        commentNumLabel.textAlignment = NSTextAlignmentCenter;
        commentNumLabel.textColor = [UIColor whiteColor];
        commentNumLabel.font = [UIFont systemFontOfSize:11.0f];
        [view addSubview:commentNumLabel];
        
        UIButton *commentBtn = [[UIButton alloc]initWithFrame:CGRectMake(view.frame.size.width-41-60, 0, 60, view.frame.size.height)];
        commentBtn.backgroundColor = [UIColor clearColor];
        [commentBtn addTarget:self action:@selector(handleCommentBtnSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:commentBtn];
        //三个点按钮
        UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(view.frame.size.width-41, 0, 41, view.frame.size.height)];
        moreBtn.backgroundColor = [UIColor clearColor];
        [moreBtn addTarget:self action:@selector(handleMoreBtnSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:moreBtn];
        [moreBtn setImage:[UIImage imageNamed:@"detail_more.png"] forState:UIControlStateNormal];
        [moreBtn setImageEdgeInsets:UIEdgeInsetsMake((view.frame.size.height-4.0f)/2, 11.0f, (view.frame.size.height-4.0f)/2, 11.0f)];
    }
    return self;
}

- (void)handleBtnSelectAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(headInPicDetail:backButton:)]) {
        [self.delegate headInPicDetail:self backButton:button];
    }
}

- (void)handleMoreBtnSelectAction:(UIButton *)button{
    
}

- (void)handleCommentBtnSelectAction:(UIButton *)button{
    
}

@end
