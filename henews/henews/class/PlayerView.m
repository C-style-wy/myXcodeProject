//
//  PlayerView.m
//  henews
//
//  Created by 汪洋 on 15/11/16.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "PlayerView.h"
#import "CDPButton.h"
#import "PlayLoading.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UIImageView+AFNetworking.h"

//上下导航栏高(全屏时上导航栏高+20)
#define CDPTOPHEIGHT(FullScreen) ((FullScreen==YES)?30.5f:40)
#define CDPFOOTHEIGHT 32

//导航栏上button的宽高
#define CDPButtonWidth 30
#define CDPButtonHeight 30

//导航栏隐藏前所需等待时间
#define CDPHideBarIntervalTime 5

@implementation PlayerView{
    AVPlayerLayer *_playerLayer;//播放器layer
    id _playerTimeObserver;
    
    UIView *_bufferView;//缓冲view
    UIActivityIndicatorView *_activityView;//缓冲旋转菊花
    UILabel *_bufferLabel;//缓冲label
    
    UISlider *_volumeSlider;//音量slider
    
    NSTimer *_timer;//计时器
    
    NSString *_urlStr;//视频地址
    
    BOOL _haveOriginalUI;//是否创建默认交互UI
    CGRect _initFrame;
    
    CGFloat _lastShowBarTime;//最后一次导航栏显示时的时间
    BOOL _isShowBar;//导航栏是否显示
    
    UIView *_topBar;//顶部导航栏
    UIButton *_backButton;//返回button
    UILabel *_titleLabel;//标题
    
    UIView *_footBar;//底部导航栏
    UIButton *_playButton;//播放\暂停button
    UIButton *_switchButton;//切换全屏button
    UILabel *_timeLabel;//时间label
    
    UISlider *_slider;//播放进度条
    BOOL _dragSlider;//是否正在拖动slider
    UIProgressView *_progressView;//缓冲进度条
    
    UIImageView *_baseImage;//底图
    UIImageView *_middPlayImage;//播放界面中间的播放按钮
    UIButton *_baseButton;
}

-(instancetype)initWithFrame:(CGRect)frame url:(NSString *)url delegate:(id <PlayerViewDelegate>)delegate haveOriginalUI:(BOOL)haveOriginalUI{
    if (self=[super initWithFrame:frame]) {
        _initFrame=frame;
        _urlStr=url;
        _delegate=delegate;
        _currentTime=0;
        _totalTime=0;
        _isFullScreen=NO;
        _isSwitch=NO;
        _changeBar=NO;
        _lastShowBarTime=0;
        _haveOriginalUI=haveOriginalUI;
        _dragSlider=NO;
        _isShowBar = YES;
        
        //添加手势
        [self addGR];
        
        [self createUI];
        
        //监控播放器
        [_player addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
        
        //开始播放
        [self checkAndUpdateStatus:PlayerViewReadyPlay];
        [_player play];
    }
    return self;
}

- (void)setPlayerUrlAndPlay:(NSString*)url{
    _urlStr=url;
    
    AVPlayerItem *playerItem=[self getPlayItemWithUrl:_urlStr];
    _player=[AVPlayer playerWithPlayerItem:playerItem];
    
    _playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame=self.bounds;
    //视频填充模式
    [self.layer insertSublayer:_playerLayer atIndex:0];
    //添加KVO监控
    [self addObserver];
    //进度监控
    [self addProgressObserver];
    //添加通知
    [self addNotification];
    //监控播放器
    [_player addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
    //开始播放
    [self checkAndUpdateStatus:PlayerViewReadyPlay];
    [_player play];
    
    //计时器
    if (_timer==nil) {
        //添加定时器时，就记住时间
        _lastShowBarTime = [[NSDate date] timeIntervalSince1970];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeGo) userInfo:nil repeats:YES];
    }
}

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<PlayerViewDelegate>)delegate baseImageUrl:(NSString*)url{
    if (self=[super initWithFrame:frame]) {
        _initFrame=frame;
        _delegate=delegate;
        _currentTime=0;
        _totalTime=0;
        _isFullScreen=NO;
        _isSwitch=NO;
        _changeBar=NO;
        _lastShowBarTime=0;
        _dragSlider=NO;
        _isShowBar = YES;
        _haveOriginalUI = YES;
        self.basePicUrl = url;
        
        _baseImage = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:_baseImage];
        if (self.basePicUrl) {
            [_baseImage setImageWithURL:[NSURL URLWithString:self.basePicUrl]];
        }
        
        _baseButton = [[UIButton alloc]initWithFrame:CGRectMake((_initFrame.size.width-38)/2, (_initFrame.size.height-38)/2, 38, 38)];
        [_baseButton setImage:[UIImage imageNamed:@"playIconNew.png"] forState:UIControlStateNormal];
        [_baseButton addTarget:self action:@selector(playOrPause) forControlEvents:UIControlEventTouchUpInside];
        [_baseButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        _baseButton.hidden = YES;
        [self addSubview:_baseButton];
        
        //添加手势
        [self addGR];
        
        [self createUIWithoutPlayer];
    }
    return self;
}

-(void)dealloc{
    [_player removeObserver:self forKeyPath:@"rate"];
    [self closePlayer];
    if (self.superview) {
        [self removeFromSuperview];
    }
}

//添加手势
-(void)addGR{
    //单击
    UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
    [self addGestureRecognizer:tapGR];
    
    //双击
    UITapGestureRecognizer *doubleGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
    doubleGR.numberOfTouchesRequired = 1;
    doubleGR.numberOfTapsRequired = 2;
    [tapGR requireGestureRecognizerToFail:doubleGR];
    [self addGestureRecognizer:doubleGR];
    
    //拖动
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:panGesture];
}
//关闭播放器
-(void)closePlayer{
    if (_timer) {
        [_timer invalidate];
        _timer=nil;
    }
    
    [self removeObserver];
    [self removeNotification];
    
    [_player.currentItem cancelPendingSeeks];
    [_player.currentItem.asset cancelLoading];
    
    [_player removeTimeObserver:_playerTimeObserver];
    _playerTimeObserver=nil;
    
    [_player cancelPendingPrerolls];
    
    [_player replaceCurrentItemWithPlayerItem:nil];
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    for (CALayer *subLayer in self.layer.sublayers) {
        [subLayer removeFromSuperlayer];
    }
}
//计时器
-(void)timeGo{
    //判断是否隐藏导航栏
    if ([[NSDate date] timeIntervalSince1970]-_lastShowBarTime>=CDPHideBarIntervalTime) {
        [self hideBar];
    }else if(_lastShowBarTime==0){
        [self hideBar];
    }
    
    if (_slider) {
        _slider.userInteractionEnabled=(_totalTime==0)?NO:YES;
    }
}
#pragma mark - 通知
//添加通知
-(void)addNotification{
    //添加AVPlayerItem播放结束通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playBackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
    
    //添加AVPlayerItem开始缓冲通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bufferStart:) name:AVPlayerItemPlaybackStalledNotification object:_player.currentItem];
    
}
//移除通知
-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//播放结束通知回调
-(void)playBackFinished:(NSNotification *)notification{
    
    [self checkAndUpdateStatus:PlayerViewEnd];
    
    if ([_delegate respondsToSelector:@selector(playFinishedWithItem:)]) {
        [_delegate playFinishedWithItem:notification.object];
    }
}
//缓冲开始回调
-(void)bufferStart:(NSNotification *)notification{
    [self checkAndUpdateStatus:PlayerViewBuffer];
}
#pragma mark - KVO监控
//给播放器添加进度更新
-(void)addProgressObserver{
    //设置每秒执行一次
    AVPlayerItem *playerItem=_player.currentItem;
    __weak typeof (self) weakSelf=self;
    __weak typeof(_slider) weakSlider=_slider;
    
    _playerTimeObserver=[_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0,10.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        CGFloat current=CMTimeGetSeconds(time);
        CGFloat total=CMTimeGetSeconds([playerItem duration]);

        if (current) {
            _currentTime=current;
            if (_currentTime>0) {
                [PlayLoading loadingHide:weakSelf];
                [weakSelf showOrHideBaseImage:YES];
                _baseButton.hidden = YES;
            }
            _totalTime=total;
            if (_haveOriginalUI==YES&&weakSlider&&_dragSlider==NO) {
                weakSlider.value=_currentTime/_totalTime;
                
                [weakSelf updateTime:current];
            }
            if ([weakSelf.delegate respondsToSelector:@selector(updateProgressWithCurrentTime:totalTime:)]) {
                [weakSelf.delegate updateProgressWithCurrentTime:current totalTime:total];
            }
        }
    }];
}
//添加KVO监控
-(void)addObserver{
    AVPlayerItem *playerItem=_player.currentItem;
    //监控状态属性(AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态)
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监控网络加载情况属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    //监控是否可播放
    [playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
}
//移除KVO监控
-(void)removeObserver{
    [_player.currentItem removeObserver:self forKeyPath:@"status"];
    [_player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [_player.currentItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
}
//通过KVO监控回调
//keyPath 监控属性 object 监视器 change 状态改变 context 上下文
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
        //监控是否可播放
        if (_haveOriginalUI==YES&&_bufferView) {
            [self removeBufferView];
        }
        
        if (_status!=PlayerViewPause&&_status!=PlayerViewEnd) {
            if (_player.currentItem.playbackLikelyToKeepUp==YES) {
                [self checkAndUpdateStatus:PlayerViewPlay];
                [_player play];
            }
        }
    }else if ([keyPath isEqualToString:@"rate"]) {
        //监控播放器播放速率
        if(_player.rate==1){
            [self checkAndUpdateStatus:PlayerViewPlay];
        }
    }else if ([keyPath isEqualToString:@"status"]) {
        //监控状态属性
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        
        switch (status) {
            case AVPlayerStatusReadyToPlay:{
                _currentTime=CMTimeGetSeconds(_player.currentTime);
                _totalTime=CMTimeGetSeconds([_player.currentItem duration]);
                
                if (status!=PlayerViewPause) {
                    [self checkAndUpdateStatus:PlayerViewReadyPlay];
                }
            }
                break;
            case AVPlayerStatusUnknown:{
                [self closePlayer];
                [self checkAndUpdateStatus:PlayerViewUnknown];
            }
                break;
            case AVPlayerStatusFailed:{
                [self closePlayer];
                [self checkAndUpdateStatus:PlayerViewFailed];
            }
                break;
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        //监控网络加载情况属性
        NSArray *array=_player.currentItem.loadedTimeRanges;
        
        //本次缓冲时间范围
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
        CGFloat startSeconds = CMTimeGetSeconds(timeRange.start);
        CGFloat durationSeconds = CMTimeGetSeconds(timeRange.duration);
        
        //现有缓冲总长度
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;
        
        if (_haveOriginalUI&&_progressView) {
            [_progressView setProgress:totalBuffer/_totalTime animated:NO];
        }
        if ([_delegate respondsToSelector:@selector(updateBufferWithStartTime:duration:totalBuffer:)]) {
            [_delegate updateBufferWithStartTime:startSeconds duration:durationSeconds totalBuffer:totalBuffer];
        }
    }
}
#pragma mark - 创建UI
-(void)createUI{
    //容器view
    self.backgroundColor=[UIColor blackColor];
    self.userInteractionEnabled=YES;
    
    //播放器
    [self createPlayerWithContainView:self];
    
    //音量
    MPVolumeView *mpVolumeView=[[MPVolumeView alloc] initWithFrame:CGRectMake(50,50,40,40)];
    for (UIView *view in [mpVolumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            _volumeSlider=(UISlider*)view;
            break;
        }
    }
    [mpVolumeView setHidden:YES];
    [mpVolumeView setShowsVolumeSlider:YES];
    [mpVolumeView sizeToFit];
}

- (void)createUIWithoutPlayer{
    //容器view
    self.backgroundColor=[UIColor blackColor];
    self.userInteractionEnabled=YES;
    
    [self createTopBar];
    [self createFootBar];
    [self createBufferView];
    //添加loading
    [PlayLoading loadingShow:self below:_topBar];
    //音量
    MPVolumeView *mpVolumeView=[[MPVolumeView alloc] initWithFrame:CGRectMake(50,50,40,40)];
    for (UIView *view in [mpVolumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            _volumeSlider=(UISlider*)view;
            break;
        }
    }
    [mpVolumeView setHidden:YES];
    [mpVolumeView setShowsVolumeSlider:YES];
    [mpVolumeView sizeToFit];
}
//创建播放器
-(void)createPlayerWithContainView:(UIView *)containView{
    AVPlayerItem *playerItem=[self getPlayItemWithUrl:_urlStr];
    _player=[AVPlayer playerWithPlayerItem:playerItem];
    
    _playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame=containView.bounds;
    
    //视频填充模式
    //    _playerLayer.videoGravity=AVLayerVideoGravityResizeAspect;
    [containView.layer insertSublayer:_playerLayer atIndex:0];
    
    //默认交互UI
    if (_haveOriginalUI==YES) {
        [self createTopBar];
        [self createFootBar];
        [self createBufferView];
    }
    
    //添加KVO监控
    [self addObserver];
    
    //进度监控
    [self addProgressObserver];
    
    //添加通知
    [self addNotification];
    
    //计时器
    if (_timer==nil) {
        //添加定时器时，就记住时间
        _lastShowBarTime=[[NSDate date] timeIntervalSince1970];
        _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeGo) userInfo:nil repeats:YES];
    }
    
}
//根据url获得AVPlayerItem对象
-(AVPlayerItem *)getPlayItemWithUrl:(NSString *)urlStr{
    //对url进行编码
    //    urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    AVPlayerItem *playerItem=[AVPlayerItem playerItemWithURL:url];
    return playerItem;
}
//创建缓冲view
-(void)createBufferView{
    _bufferView=[[UIView alloc] initWithFrame:CGRectMake(_initFrame.size.width/2-60,_initFrame.size.height/2-30,120,60)];
    _bufferView.backgroundColor=[UIColor blackColor];
    _bufferView.alpha=0.7;
    _bufferView.layer.cornerRadius=10;
    _bufferView.layer.masksToBounds=YES;
    
    //缓冲旋转菊花
    _activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(_bufferView.frame.origin.x+41,_bufferView.frame.origin.y+1,38,38)];
    [_activityView stopAnimating];
    
    //缓冲label
    _bufferLabel=[[UILabel alloc] initWithFrame:CGRectMake(_bufferView.frame.origin.x,CGRectGetMaxY(_activityView.frame),120,20)];
    _bufferLabel.textColor=[UIColor whiteColor];
    _bufferLabel.textAlignment=NSTextAlignmentCenter;
    _bufferLabel.font=[UIFont systemFontOfSize:16];
    _bufferLabel.text=@"加 载 中...";
}
//创建topBar
-(void)createTopBar{
    if (_topBar==nil) {
        _topBar=[[UIView alloc] initWithFrame:CGRectMake(0,0,_initFrame.size.width,CDPTOPHEIGHT(NO))];
        _topBar.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.5f];;
//        _topBar.alpha=0.5;
        _topBar.userInteractionEnabled=YES;
        [self addSubview:_topBar];

        _backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, _topBar.frame.origin.y, 45, _topBar.frame.size.height)];
        [_backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setImage:[UIImage imageNamed:@"detail_back_night.png"] forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"newBackSel_black.png"] forState:UIControlStateHighlighted];
        [_backButton setImageEdgeInsets:UIEdgeInsetsMake((_backButton.frame.size.height-23)/2, 8.0f, (_backButton.frame.size.height-23)/2, _backButton.frame.size.width-8-23)];
        [self addSubview:_backButton];
        
        //标题
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxY(_backButton.frame),0,_topBar.frame.size.width-CGRectGetMaxY(_backButton.frame)-5,_topBar.frame.size.height)];
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.font=[UIFont systemFontOfSize:14];
        [_topBar addSubview:_titleLabel];
        
        _topBar.hidden = YES;
    }
}
//创建footBar
-(void)createFootBar{
    if (_footBar==nil) {
        _footBar=[[UIView alloc] initWithFrame:CGRectMake(0,_initFrame.size.height-CDPFOOTHEIGHT,_initFrame.size.width,CDPFOOTHEIGHT)];
        _footBar.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.5];;
        _footBar.userInteractionEnabled=YES;
        [self addSubview:_footBar];
        
        //播放\暂停
        _playButton=[[UIButton alloc] initWithFrame:CGRectMake(0,0,31,_footBar.frame.size.height)];
        [_playButton addTarget:self action:@selector(playOrPause) forControlEvents:UIControlEventTouchUpInside];
        [_playButton setImage:[UIImage imageNamed:@"startPlay_n.png"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"pause_n.png"] forState:UIControlStateSelected];
        [_playButton setImageEdgeInsets:UIEdgeInsetsMake((_playButton.frame.size.height-18)/2, 8.0f, (_playButton.frame.size.height-18)/2, _playButton.frame.size.width-8-18)];
        [_footBar addSubview:_playButton];
        
        //切换全屏
        _switchButton=[[UIButton alloc] initWithFrame:CGRectMake(_footBar.frame.size.width-25,0,25,_footBar.frame.size.height)];
        [_switchButton addTarget:self action:@selector(switchClick) forControlEvents:UIControlEventTouchUpInside];
        [_switchButton setImage:[UIImage imageNamed:@"fullscreen.png"] forState:UIControlStateNormal];
        [_switchButton setImage:[UIImage imageNamed:@"smallscreen.png"] forState:UIControlStateSelected];
        [_switchButton setImageEdgeInsets:UIEdgeInsetsMake((_switchButton.frame.size.height-13)/2, 0, (_switchButton.frame.size.height-13)/2, _switchButton.frame.size.width-16)];
        [_footBar addSubview:_switchButton];
        
        //时间
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(_switchButton.frame.origin.x-80,0,80,_footBar.frame.size.height)];
        _timeLabel.textAlignment=NSTextAlignmentCenter;
        _timeLabel.text=@"00:00/00:00";
        _timeLabel.font=[UIFont systemFontOfSize:11];
        _timeLabel.numberOfLines=0;
        _timeLabel.textColor=[UIColor whiteColor];
        [_footBar addSubview:_timeLabel];
        
        //缓冲进度条
        _progressView=[[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame=CGRectMake(CGRectGetMaxX(_playButton.frame)+8,(_footBar.frame.size.height-2)/2,CGRectGetMinX(_timeLabel.frame)-CGRectGetMaxX(_playButton.frame)-8, 2);
        _progressView.progressTintColor=[UIColor lightGrayColor];
        _progressView.trackTintColor=[UIColor darkGrayColor];
        [_footBar insertSubview:_progressView belowSubview:_playButton];
        
        //进度条
        _slider=[[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMinX(_progressView.frame)-2,(_footBar.frame.size.height-30)/2,_progressView.bounds.size.width+4,30)];
        [_slider setThumbImage:[UIImage imageNamed:@"CDPSlider"] forState:UIControlStateNormal];
        _slider.minimumTrackTintColor=ROSERED;
        _slider.maximumTrackTintColor=[UIColor clearColor];
        [_slider addTarget:self action:@selector(sliderChange) forControlEvents:UIControlEventValueChanged];
        [_slider addTarget:self action:@selector(sliderChangeEnd) forControlEvents:UIControlEventTouchUpInside];
        [_footBar insertSubview:_slider aboveSubview:_progressView];
    }
}
#pragma mark - PlayerView外部交互
//播放
-(void)play{
    //记录最后一次显示开始时间
    _lastShowBarTime=[[NSDate date] timeIntervalSince1970];
    
    if (_player.currentItem==nil) {
        _currentTime=0;
        _totalTime=0;
        [self createPlayerWithContainView:self];
    }
    [_player play];
    [self checkAndUpdateStatus:PlayerViewPlay];
}
//暂停
-(void)pause{
    //记录最后一次显示开始时间
    _lastShowBarTime=[[NSDate date] timeIntervalSince1970];
    
    [_player pause];
    [self checkAndUpdateStatus:PlayerViewPause];
}
//关闭播放器并销毁当前播放view
-(void)close{
    [self closePlayer];
    for (UIGestureRecognizer *gr in self.gestureRecognizers) {
        [self removeGestureRecognizer:gr];
    }
    if (self.superview) {
        [self removeFromSuperview];
    }
}
//切换\取消全屏状态
-(void)setIsFullScreen:(BOOL)isFullScreen{
    NSLog(@"setIsFullScreen==");
    //记录最后一次显示开始时间
    _lastShowBarTime=[[NSDate date] timeIntervalSince1970];
    
    if (_isSwitch==YES) {
        return;
    }
    _isFullScreen=isFullScreen;
    
    _isSwitch=YES;
    if (_isFullScreen==YES) {
        //全屏下显示标题
        _topBar.hidden = NO;
        //全屏
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
            [self updateFrame];
        }completion:^(BOOL finished) {
            _isSwitch=NO;
        }];
    }else{
        //非全屏下显示标题
        _topBar.hidden = YES;
        //非全屏
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.transform=CGAffineTransformIdentity;
            [self updateFrame];
        }completion:^(BOOL finished) {
            _isSwitch=NO;
        }];
    }
}
//改变当前播放时间到time
-(void)seeTime:(CGFloat)time{
    [_player seekToTime:CMTimeMakeWithSeconds(time,1) completionHandler:^(BOOL finished) {
        
    }];
}
#pragma mark - 更新
//检查并更新播放器状态
-(void)checkAndUpdateStatus:(PlayerViewStatus)newStatus{
    if (_status!=newStatus) {
        _status=newStatus;
        
        //判断进行默认UI交互
        if (_haveOriginalUI==YES) {
            switch (_status) {
                case PlayerViewReadyPlay:{
                    //可播放
                    [self removeBufferView];
                }
                    break;
                case PlayerViewPlay:{
                    //开始播放
                    _playButton.selected=YES;
                    [self removeBufferView];
                }
                    break;
                case PlayerViewPause:{
                    //暂停
                    _playButton.selected=NO;
                }
                    break;
                case PlayerViewBuffer:{
                    //缓冲
                    _playButton.selected=YES;
                    [self showBufferView];
                }
                    break;
                case PlayerViewEnd:{
                    //播放结束
                    _playButton.selected=NO;
                    [self removeBufferView];
                    //进度设置为0，显示底图
                    _slider.value = 0;
                    [self showOrHideBaseImage:NO];
                    [self updateTime:0.0f];
                    [self showBar];
                    _baseButton.hidden = NO;
                }
                    break;
                case PlayerViewUnknown:{
                    //播放失败
                    _playButton.selected=NO;
                    [self removeBufferView];
                }
                    break;
                case PlayerViewFailed:{
                    //未知
                    _playButton.selected=NO;
                    [self removeBufferView];
                }
                    break;
            }
        }
        
        if ([_delegate respondsToSelector:@selector(updatePlayerStatus:)]) {
            [_delegate updatePlayerStatus:_status];
        }
    }
}
//更新播放器frame
-(void)updateFrame{
    if ([self.delegate respondsToSelector:@selector(hideOrShowStaBar:)]) {
        [self.delegate hideOrShowStaBar:_isFullScreen];
    }
    if (_isFullScreen==YES) {
        //全屏
        self.frame=CGRectMake(0,0,SCREEN_HEIGHT,SCREEN_WIDTH);
        _playerLayer.frame=self.bounds;
        self.center=self.window.center;
        if (_haveOriginalUI==YES&&_topBar&&_footBar) {
            [self restoreOrChangeAlpha:YES];
            [self restoreOrChangeFrame:NO];
            _switchButton.selected=YES;
        }
    }else{
        //非全屏
        self.frame=_initFrame;
        _playerLayer.frame=self.bounds;
        if (_haveOriginalUI==YES&&_topBar&&_footBar) {
            [self restoreOrChangeTransForm:YES];
            [self restoreOrChangeFrame:YES];
            _switchButton.selected=NO;
        }
    }
}
#pragma mark - 手势点击
//单双击
-(void)tapGR:(UITapGestureRecognizer *)tapGR{
    if(tapGR.numberOfTapsRequired == 2) {
        //双击
        if ([_delegate respondsToSelector:@selector(doubleClick)]) {
            [_delegate doubleClick];
        }
        if (_haveOriginalUI==YES) {
            [self switchClick];
        }
    }else{
        //单击
        if (_isShowBar==YES) {
            NSLog(@"hidebar====");
            [self hideBar];
        }else{
            NSLog(@"showBar====");
            [self showBar];
        }
    }
}
//拖动
- (void)panGesture:(UIPanGestureRecognizer *)panGR{
    if(panGR.numberOfTouches>1) {
        return;
    }
    CGPoint translationPoint=[panGR translationInView:self];
    [panGR setTranslation:CGPointZero inView:self];
    
    CGFloat x=translationPoint.x;
    CGFloat y=translationPoint.y;
    
    if ((x==0&&fabs(y)>=5)||fabs(y)/fabs(x)>=3) {
        //上下调节音量
        if (_dragSlider==YES) {
            return;
        }
        CGFloat ratio = ([[UIDevice currentDevice].model rangeOfString:@"iPad"].location != NSNotFound)?20000.0f:13000.0f;
        CGPoint velocity = [panGR velocityInView:self];
        
        CGFloat nowValue = _volumeSlider.value;
        CGFloat changedValue = 1.0f * (nowValue - velocity.y / ratio);
        if(changedValue < 0) {
            changedValue = 0;
        }
        if(changedValue > 1) {
            changedValue = 1;
        }
        
        [_volumeSlider setValue:changedValue animated:YES];
        
        [_volumeSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
    }else{
        if ([_delegate respondsToSelector:@selector(panGR:)]) {
            [_delegate panGR:panGR];
        }
        if (_haveOriginalUI==YES){
            //默认UI左右拖动调节进度
            if((y==0&&fabs(x)>=5)||fabs(x)/fabs(y)>=3) {
                if (_totalTime==0) {
                    return;
                }
                if (_player.rate==1||_status!=PlayerViewPause) {
                    [_player pause];
                }
                _dragSlider=YES;
                
                _slider.value=_slider.value+(x/self.bounds.size.width);
                
                [self seeTime:_slider.value*_totalTime];
                [self updateTime:_slider.value*_totalTime];
            }
            if (panGR.state==UIGestureRecognizerStateEnded) {
                //拖动手势结束
                _dragSlider=NO;
                
                if (_status!=PlayerViewPause) {
                    [_player play];
                }
            }
        }
    }
}
#pragma mark - 默认UI交互
//显示缓冲view
-(void)showBufferView{
    [_activityView startAnimating];
    
    if (_bufferView.superview==nil) {
        [self addSubview:_bufferView];
    }
    if (_activityView.superview==nil) {
        [self addSubview:_activityView];
    }
    if (_bufferLabel.superview==nil) {
        [self addSubview:_bufferLabel];
    }
}
//隐藏缓冲view
-(void)removeBufferView{
    [_activityView stopAnimating];
    
    [_bufferView removeFromSuperview];
    [_activityView removeFromSuperview];
    [_bufferLabel removeFromSuperview];
}
//设置标题
-(void)setTitle:(NSString *)title{
    _title=title;
    if (_titleLabel) {
        _titleLabel.text=_title;
    }
}
//返回
-(void)backClick{
    //记录最后一次显示开始时间
    _lastShowBarTime=[[NSDate date] timeIntervalSince1970];
    
    if (_isFullScreen==YES) {
        //取消全屏
        [self switchClick];
    }
    else{
        //返回
        if ([_delegate respondsToSelector:@selector(back)]) {
            [_delegate back];
        }
    }
}
//播放、暂停
-(void)playOrPause{
    if(_playButton.selected==NO){
        //开始播放
        if (_status==PlayerViewEnd) {
            [self seeTime:1];
            [self updateTime:1];
        }
        [self play];
        _playButton.selected=YES;
    }
    else{
        //暂停播放
        [self pause];
        _playButton.selected=NO;
    }
}
//切换\取消全屏状态
-(void)switchClick{
    self.isFullScreen=!_isFullScreen;
    
    if ([_delegate respondsToSelector:@selector(switchSizeClick)]) {
        [_delegate switchSizeClick];
    }
}
//拖动slider时,改变当前播放时间
-(void)sliderChange{
    if (_totalTime==0) {
        return;
    }
    _dragSlider=YES;
    
    [self seeTime:_slider.value*_totalTime];
    
    [self updateTime:_slider.value*_totalTime];
}
//拖动slider后
-(void)sliderChangeEnd{
    _dragSlider=NO;
}
//更新播放时间
-(void)updateTime:(CGFloat)playTime{
    NSInteger a=playTime/60;
    NSInteger b=_totalTime/60;
    NSInteger c=playTime-a*60;
    NSInteger d=_totalTime-b*60;
    if (_timeLabel) {
        _timeLabel.text=[NSString stringWithFormat:@"%ld:%02ld/%ld:%02ld",(long)a,(long)c,(long)b,(long)d];
    }
}
//显示导航栏
-(void)showBar{
    //记录最后一次显示开始时间
    _lastShowBarTime=[[NSDate date] timeIntervalSince1970];
    if (_isShowBar==YES||_changeBar==YES) {
        return;
    }
    _isShowBar=YES;
    if ([_delegate respondsToSelector:@selector(showBar)]) {
        [_delegate showBar];
    }
    if (_haveOriginalUI==YES&&_changeBar==NO) {
        _changeBar=YES;
        [UIView animateWithDuration:0.3 animations:^{
            [self restoreOrChangeAlpha:YES];
            
            [self restoreOrChangeTransForm:YES];
            
        }completion:^(BOOL finished) {
            _changeBar=NO;
        }];
    }
}
//隐藏导航栏
-(void)hideBar{
    if (_isShowBar==NO||_changeBar==YES) {
        return;
    }
    _isShowBar=NO;
    if ([_delegate respondsToSelector:@selector(hideBar)]) {
        [_delegate hideBar];
    }
    if (_haveOriginalUI==YES&&_changeBar==NO) {
        _changeBar=YES;
        
        [self restoreOrChangeTransForm:YES];
        [UIView animateWithDuration:0.3 animations:^{
            if (_isFullScreen==YES) {
                [self restoreOrChangeTransForm:NO];
                [self restoreOrChangeAlpha:YES];
            }else{
                [self restoreOrChangeAlpha:NO];
            }
        }completion:^(BOOL finished) {
            _changeBar=NO;
        }];
    }
}
//恢复或改变transForm
-(void)restoreOrChangeTransForm:(BOOL)restore{
    CGAffineTransform oriTransform=CGAffineTransformIdentity;
    CGAffineTransform topTransform=CGAffineTransformMakeTranslation(0,-_topBar.bounds.size.height);
    CGAffineTransform footTransform=CGAffineTransformMakeTranslation(0,_footBar.bounds.size.height);
    if (restore==YES) {
        NSLog(@"restoreOrChangeTransForm====");
        _topBar.transform=oriTransform;
        _backButton.transform=oriTransform;
        
        _footBar.transform=oriTransform;
    }
    else{
        _topBar.transform=topTransform;
        _backButton.transform=topTransform;

        _footBar.transform=footTransform;
    }
}
//恢复或改变alpha
-(void)restoreOrChangeAlpha:(BOOL)restore{
    CGFloat a=0;
    CGFloat b=1;
    if (restore==YES) {
        _topBar.alpha=b;
        _backButton.alpha=b;
        _footBar.alpha=b;
    }else{
        _topBar.alpha=a;
        _backButton.alpha=a;
        _footBar.alpha=a;
    }
}
//恢复或改变frame
-(void)restoreOrChangeFrame:(BOOL)restoreFrame{
    if (restoreFrame==YES) {
        _topBar.frame=CGRectMake(0,0,_initFrame.size.width,CDPTOPHEIGHT(NO));
        _footBar.frame=CGRectMake(0,_initFrame.size.height-CDPFOOTHEIGHT,_initFrame.size.width,CDPFOOTHEIGHT);
        
        _baseButton.frame = CGRectMake((_initFrame.size.width-38)/2, (_initFrame.size.height-38)/2, 38, 38);
    }else{
        _topBar.frame=CGRectMake(0,0,self.bounds.size.width,CDPTOPHEIGHT(YES));
        _footBar.frame=CGRectMake(0,self.bounds.size.height-CDPFOOTHEIGHT,self.bounds.size.width,CDPFOOTHEIGHT);
        _baseButton.frame = CGRectMake((SCREEN_WIDTH-38)/2, (SCREEN_HEIGHT-38)/2, 38, 38);
    }
    
    if ([PlayLoading loadingIsShow:self]) {
        [PlayLoading loadingHide:self];
        [PlayLoading loadingShow:self below:_topBar];
    }
    
    _baseImage.frame = self.bounds;
    
    _backButton.frame = CGRectMake(0, _topBar.frame.origin.y, 45, _topBar.frame.size.height);
    [_backButton setImageEdgeInsets:UIEdgeInsetsMake((_backButton.frame.size.height-23)/2, 8.0f, (_backButton.frame.size.height-23)/2, _backButton.frame.size.width-8-23)];
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_backButton.frame),0,_topBar.frame.size.width-CGRectGetMaxY(_backButton.frame)-5,_topBar.frame.size.height);
    
    _bufferView.frame=CGRectMake(self.bounds.size.width/2-60,self.bounds.size.height/2-30,120,60);
    _activityView.frame=CGRectMake(_bufferView.frame.origin.x+41,_bufferView.frame.origin.y+1,38,38);
    _bufferLabel.frame=CGRectMake(_bufferView.frame.origin.x,CGRectGetMaxY(_activityView.frame),120,20);
    
    _playButton.frame = CGRectMake(0,0,31,_footBar.frame.size.height);
    _switchButton.frame = CGRectMake(_footBar.frame.size.width-25,0,25,_footBar.frame.size.height);
    _timeLabel.frame = CGRectMake(_switchButton.frame.origin.x-80,0,80,_footBar.frame.size.height);
    _progressView.frame = CGRectMake(CGRectGetMaxX(_playButton.frame)+8,(_footBar.frame.size.height-2)/2,CGRectGetMinX(_timeLabel.frame)-CGRectGetMaxX(_playButton.frame)-8, 2);
    _slider.frame = CGRectMake(CGRectGetMinX(_progressView.frame)-2,(_footBar.frame.size.height-30)/2,_progressView.bounds.size.width+4,30);
}

- (void)showOrHideBaseImage:(BOOL)hide{
    if (hide) {
        [UIView animateWithDuration:0.3 animations:^{
            _baseImage.alpha = 0;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            _baseImage.alpha = 1;
        }];
    }
    
}

@end
