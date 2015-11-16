//
//  PlayerView.m
//  henews
//
//  Created by 汪洋 on 15/11/16.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView


//重写initWithFrame
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        self.bottomControlView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-30, SCREEN_WIDTH, 30)];
        [self addSubview:_bottomControlView];
        
        _bottomControlView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
        
        _playOrPauseButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 48, _bottomControlView.frame.size.height)];
        
        UIImageView *playOrPauseImg = [[UIImageView alloc]initWithFrame:CGRectMake(12.5f, 3.5f, 23, 23)];
        playOrPauseImg.image = [UIImage imageNamed:@"play_icon.png"];
        [_playOrPauseButton addSubview:playOrPauseImg];
        [_bottomControlView addSubview:_playOrPauseButton];
        
        _fullScreenButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 48, _bottomControlView.frame.size.height)];
        
        UIImageView *fullScreenImg = [[UIImageView alloc]initWithFrame:CGRectMake(12.5f, 3.5f, 17.5f, 15)];
        fullScreenImg.image = [UIImage imageNamed:@"fullscreen.png"];
        [_fullScreenButton addSubview:fullScreenImg];
        [_bottomControlView addSubview:_fullScreenButton];
    }
    return self;
}

@end
