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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
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
//        NSURL *movieURL = [NSURL fileURLWithPath:[returnJson objectForKey:@"url"]];
//        MPMoviePlayerController *movewController = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
//        [movewController prepareToPlay];
//        [self.view addSubview:movewController.view];
//        movewController.shouldAutoplay=YES;
//        [movewController setControlStyle:MPMovieControlStyleDefault];
//        
//        [movewController setFullscreen:NO];
        
//        [movewController.view setFrame:self.view.bounds];
//        [movewController.view setFrame:CGRectMake(0, 20, SCREEN_WIDTH, 200)];
        
//        AVPlayerViewController
   
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"backspace" ofType:@"mov"];
        NSString *filePath = [returnJson objectForKey:@"url"];
        NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
        
        AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
        AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        playerLayer.frame = self.view.layer.bounds;
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        
        [self.view.layer addSublayer:playerLayer];
        [player play];
    }
}

-(void)dealPlayDataBack:(NSDictionary*)jsonData{
    NSString *getPlayUrl = [jsonData objectForKey:@"getPlayUrl"];
    [Request requestPostForJSON:@"playUrl" url:getPlayUrl delegate:self paras:nil msg:0];
}

@end
