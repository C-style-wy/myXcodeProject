//
//  PlayViewController.h
//  henews
//
//  Created by 汪洋 on 15/11/11.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "APIStringMacros.h"
#import "Request.h"
#import "PlayerView.h"

@interface PlayViewController : UIViewController

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;


@property (nonatomic ,retain) PlayerView *playView;

@property (nonatomic, retain) NSString *playUrl;

@end
