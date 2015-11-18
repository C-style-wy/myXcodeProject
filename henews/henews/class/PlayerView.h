//
//  PlayerView.h
//  henews
//
//  Created by 汪洋 on 15/11/16.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIStringMacros.h"
#import <AVFoundation/AVFoundation.h>

@interface PlayerView : UIView

@property (nonatomic, retain)UIButton *playOrPauseButton;
@property (nonatomic, retain)UIButton *fullScreenButton;
@property (nonatomic, retain)UIView *bottomControlView;
@property (nonatomic, retain)UILabel *timeLabel;
@property (nonatomic, retain)UISlider *progressSlider;

@property (nonatomic, retain)UIView *voiceView;

- (void)setPlayUrlAndPlay:(NSString*)url;

@end
