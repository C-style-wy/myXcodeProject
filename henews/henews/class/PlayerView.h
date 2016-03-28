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

typedef enum{
    PlayerViewReadyPlay=0, //可以播放
    PlayerViewPlay,//开始播放
    PlayerViewPause,//暂停
    PlayerViewBuffer,//停顿缓冲
    PlayerViewEnd,//播放结束
    PlayerViewFailed,//播放失败
    PlayerViewUnknown,//未知
}PlayerViewStatus;

@protocol PlayerViewDelegate <NSObject>

@optional
//播放结束
- (void)playFinishedWithItem:(AVPlayerItem *)item;

//更新播放状态
- (void)updatePlayerStatus:(PlayerViewStatus)status;

//更新播放进度（currentTime目前播放时间，total总播放时间）
- (void)updateProgressWithCurrentTime:(CGFloat)currentTime totalTime:(CGFloat)totalTime;

//更新缓冲进度（startTime本次缓冲的起始时间，duration本次缓冲获得的时长，totalBuffer已获得的总缓冲时间）
- (void)updateBufferWithStartTime:(CGFloat)startTime duration:(CGFloat)duration totalBuffer:(NSTimeInterval)totalBuffer;

//单击显示上下导航栏时回调
- (void)showBar;

//单击隐藏上下导航栏时回调
- (void)hideBar;

//双击回调（默认UI时相当于点击了一次切换全屏按钮并处罚-(void)switchSizeClick回调）
- (void)doubleClick;

//横向拖动屏幕手势回调
- (void)panGR:(UIPanGestureRecognizer *)pan;

//非全屏下返回键点击回调(仅限默认UI)
- (void)back;

//每次点击切换全屏键回调(仅限默认UI)
- (void)switchSizeClick;

@end

@interface PlayerView : UIView

//AVPlayer播放器对象
@property (nonatomic, strong) AVPlayer *player;

//播放状态
@property (nonatomic, assign, readonly) PlayerViewStatus status;

//切换\取消全屏状态
//如要使用全屏,必须要用isSwitch判断,并且在info.plist里面加入View controller-based status bar appearance后设置为NO
//并且在全屏模式下点击返回应为取消全屏效果，而不是退出对应viewController
@property (nonatomic, assign) BOOL isFullScreen;

//用来判断是否正在切换全屏中
@property (nonatomic, assign, readonly) BOOL isSwitch;

//用来判断是否正在切换上下导航栏状态(仅限默认UI)
@property (nonatomic, assign, readonly) BOOL changeBar;

//标题（仅限默认UI）
@property (nonatomic, strong) NSString *title;

//当前播放时间
@property (nonatomic, assign, readonly) CGFloat currentTime;

//总播放时间
@property (nonatomic, assign, readonly) CGFloat totalTime;

@property (nonatomic, weak) id<PlayerViewDelegate> delegate;

//初始化
- (instancetype)initWithFrame:(CGRect)frame url:(NSString *)url delegate:(id<PlayerViewDelegate>)delegate haveOriginalUI:(BOOL)haveOriginalUI;

//播放并判断是否重新加载当前url资源
- (void)play;

//暂停
- (void)pause;

//关闭播放器并销毁当前播放view
//一定要在退出时使用，否则内存可能释放不了
- (void)close;

//改变当前播放时间到time
- (void)seeTime:(CGFloat)time;

@end
