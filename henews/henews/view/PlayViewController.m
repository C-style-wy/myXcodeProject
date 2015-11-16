//
//  PlayViewController.m
//  henews
//
//  Created by 汪洋 on 15/11/11.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "PlayViewController.h"

@interface PlayViewController ()

@end

@implementation PlayViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self preferredStatusBarStyle];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = VIEWBACKGROUND_COLOR;
    
    PlayerView *playView = [[PlayerView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 171)];
    [self.view addSubview:playView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)getUrl:(NSString *)urlString{
    [Request requestPostForJSON:@"playData" url:urlString delegate:self paras:nil msg:0];
}

-(void)requestDidReturn:(NSString*)tag returnStr:(NSString*)returnStr returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg;{
    if ([tag isEqual:@"playData"]) {
        [self dealPlayDataBack:returnJson];
    }else if ([tag isEqual:@"playUrl"]){
        UIView *playerBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 191)];
        playerBg.backgroundColor = [UIColor blackColor];
        [self.view addSubview:playerBg];
        
        NSString *filePath = [returnJson objectForKey:@"url"];
        NSURL *sourceMovieURL = [NSURL URLWithString:filePath];
        
        AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
        AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//        playerLayer.frame = self.view.layer.bounds;
        playerLayer.frame = CGRectMake(0, 20, SCREEN_WIDTH, 171);
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        
        [self.view.layer addSublayer:playerLayer];
        [player play];
        
        //UISlider=====
        UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(8, 180, SCREEN_WIDTH-16, 10)];
        slider.minimumTrackTintColor = ROSERED;
//        slider.minimumValueImage = [UIImage imageNamed:@"progress_point.png"];
        [slider setThumbImage:[UIImage imageNamed:@"progress_point.png"] forState:UIControlStateNormal];
        
        [self.view addSubview:slider];
    }
}

-(void)dealPlayDataBack:(NSDictionary*)jsonData{
//    NSString *getPlayUrl = [jsonData objectForKey:@"getPlayUrl"];
//    [Request requestPostForJSON:@"playUrl" url:getPlayUrl delegate:self paras:nil msg:0];
}

@end
