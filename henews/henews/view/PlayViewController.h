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

@interface PlayViewController : UIViewController<PlayerViewDelegate, UIScrollViewDelegate>

@property (nonatomic, retain) NSString *playUrl;

@end
