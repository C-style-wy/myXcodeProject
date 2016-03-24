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
        self.backgroundColor = [UIColor blackColor];
        _voiceView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_voiceView];
        
        self.bottomControlView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-30, SCREEN_WIDTH, 30)];
        [self addSubview:_bottomControlView];
        
        _bottomControlView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
        
        _playOrPauseButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 48, _bottomControlView.frame.size.height)];
        [_playOrPauseButton addTarget:self action:@selector(playOrPauseClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        _playOrPauseButton.tag = 1;
        
        UIImageView *playOrPauseImg = [[UIImageView alloc]initWithFrame:CGRectMake(12.5f, 3.5f, 23, 23)];
        playOrPauseImg.image = [UIImage imageNamed:@"play_icon.png"];
        [_playOrPauseButton addSubview:playOrPauseImg];
        [_bottomControlView addSubview:_playOrPauseButton];
        
        _fullScreenButton = [[UIButton alloc]initWithFrame:CGRectMake(_bottomControlView.frame.size.width-47, 0, 47, _bottomControlView.frame.size.height)];
        
        _fullScreenButton.tag = 1;
        [_fullScreenButton addTarget:self action:@selector(fullScreenClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIImageView *fullScreenImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 7.5f, 17.5f, 15)];
        fullScreenImg.image = [UIImage imageNamed:@"fullscreen.png"];
        [_fullScreenButton addSubview:fullScreenImg];
        [_bottomControlView addSubview:_fullScreenButton];
        
        _progressSlider = [[UISlider alloc]initWithFrame:CGRectMake(_playOrPauseButton.frame.size.width, 0, _bottomControlView.frame.size.width - _playOrPauseButton.frame.size.width-_fullScreenButton.frame.size.width-72, _bottomControlView.frame.size.height)];
        
        _progressSlider.minimumTrackTintColor = ROSERED;
        [_progressSlider setThumbImage:[UIImage imageNamed:@"progress_point.png"] forState:UIControlStateNormal];
        [_bottomControlView addSubview:_progressSlider];
    }
    return self;
}

- (void)setPlayUrlAndPlay:(NSString*)url{
    NSLog(@"播放视频=======");
    NSURL *sourceMovieURL = [NSURL URLWithString:url];
    
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = CGRectMake(0, 0, _voiceView.frame.size.width, _voiceView.frame.size.height);
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [_voiceView.layer addSublayer:playerLayer];
    [player play];
}

- (void)fullScreenClickBtn:(UIButton *)button {
    if (1 == button.tag) {  //小屏转大屏
        NSLog(@"fullScreenClickBtn");
        [[UIApplication sharedApplication] setStatusBarOrientation:UIDeviceOrientationLandscapeRight animated:YES];
        button.tag = 0;
    }else{                  //大屏转小屏
        NSLog(@"smallScreenClickBtn");
        button.tag = 1;
    }
}

- (void)playOrPauseClickBtn:(UIButton *)button {
    if (1 == button.tag) { //
        NSLog(@"播放");
        button.tag = 0;
    }else{                //
        NSLog(@"暂停");
        button.tag = 1;
    }
}

@end
