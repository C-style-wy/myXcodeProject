//
//  IndexViewController.m
//  henews250
//
//  Created by 汪洋 on 16/7/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "IndexViewController.h"
#import "GuidePage1.h"
#import "GuidePage2.h"
#import "XNTabBarView.h"
#import "UIViewController+LoadFromStoryboard.h"
#import "XNTabBarView.h"

@interface IndexViewController ()

@end

@implementation IndexViewController {
    float guideScrollViewBeginOffsetX;
    NSTimer *_readSecTime;
}

#pragma mark - viewDiaLoad,viewWillAppear,viewDidAppear,viewWillDisappear,viewDidDisappear
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化页面
    [self initPage];
    //设置各个分辨率的启动底图
    [self settingLaunchImage];
    //请求数据
    [self requestData];
    //设置显示或者隐藏导航图
    [self showOrHideGuideImage];
}

- (BOOL)prefersStatusBarHidden{
    //    return !showToolBarAndText; //返回NO表示要显示，返回YES将hiden
    return YES;
}

#pragma mark - menory warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化页面
- (void)initPage {
//    [self.adView setHidden:YES];
    [self.adView setAllHidden:YES];
}

#pragma mark - 请求接口
- (void)requestData {
    NSString *addHead = [SERVER_URL stringByAppendingString:INDEX_URL];
    NSString *url = [addHead stringByAppendingString:@"合肥"];
    [Request requestPostForJSON:@"indexData" url:url delegate:self paras:nil msg:0 useCache:NO];
}

#pragma mark - 数据返回
-(void)requestDidReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg isCacheReturn:(BOOL)flag{
    self.loadingMode = [LoadingMode mj_objectWithKeyValues:returnJson];
    //设置广告图
    if (!isFirstOpen) {
        if (![self showOrHideAdImage]) {
            [self jumpeHome:NO];
        }
    }
}
    
#pragma mark - 设置启动图函数
- (void)settingLaunchImage{
    NSString *imageStr = [[NSString alloc]initWithFormat:iPhone5LaunchImage];
    switch ([self returnIphoneType]) {
        case iPhone4:
            imageStr = iPhone4LaunchImage;
            break;
        case iPhone5:
            imageStr = iPhone5LaunchImage;
            break;
        case iPhone6:
            imageStr = iPhone6LaunchImage;
            break;
        case iPhone6p:
            imageStr = iPhone6pLaunchImage;
            break;
        default:
            break;
    }
    self.launchImage.image = [UIImage  imageNamed:imageStr];
}
#pragma mark - 显示或者隐藏导航图
- (void)showOrHideGuideImage {
    if (isFirstOpen) {
        self.guideScrollView.delegate = self;
        self.guideScrollView.backgroundColor = LRClearColor;
        self.guideScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, 0);
        
        //page1
        GuidePage1 *guidePage1 = [[GuidePage1 loadFromNib] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.guideScrollView addSubview:guidePage1];
        //page2
        GuidePage2 *guidePage2 = [GuidePage2 loadFromNib];
        guidePage2.frame = CGRectMake(SCREEN_WIDTH, 0, guidePage2.frame.size.width, guidePage2.frame.size.height);
        [self.guideScrollView addSubview:guidePage2];
        //page3
        GuidePage3 *guidePage3 = [[GuidePage3 loadFromNib] init];
        guidePage3.delegate = self;
        guidePage3.frame = CGRectMake(SCREEN_WIDTH*2, 0, guidePage3.frame.size.width, guidePage3.frame.size.height);
        [self.guideScrollView addSubview:guidePage3];
        
        self.scrollBgView.hidden = NO;
    }else{
        self.scrollBgView.hidden = YES;
    }
}
#pragma mark - 显示或者隐藏广告图
- (BOOL)showOrHideAdImage {
    if ([self laterCurTimeWithTimeStr:self.loadingMode.adInfo.endTime] && [self earlierCurTimeWithTimeStr:self.loadingMode.adInfo.startTime] && !isFirstOpen) {
        
        if ([self.loadingMode.adInfo.fullScreen isEqualToString:@"1"]) {
            self.adImageDistanceBottom.constant = 0;
        }else{
            self.adImageDistanceBottom.constant = 106.0f*SCREEN_WIDTH/320;
        }
        self.secBgWidth.constant = 38.0f*SCREEN_WIDTH/320;
        self.jumpLabelTop.constant = 10.0f*SCREEN_WIDTH/320;
        if (![self.loadingMode.adInfo.pic isEqualToString:@""]) {
            self.secLabel.text = [_loadingMode.adInfo.displayTime stringByAppendingString:@"s"];
            
            [self.adImage sd_setImageWithURL:[NSURL URLWithString:self.loadingMode.adInfo.pic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                _readSecTime = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(readSecTime) userInfo:nil repeats:YES];
                
                [self.adView setAllHidden:NO];
                self.adView.alpha = 0;
                [UIView animateWithDuration:0.4f animations:^{
                    self.adView.alpha = 1.0f;
                }];
            }];
            return YES;
        }
    }
    return NO;
}

- (void)readSecTime {
    int time = [self.secLabel.text intValue];
    if (time > 1) {
        NSString *timeStr = [NSString stringWithFormat:@"%d",(time-1)];
        self.secLabel.text = [timeStr stringByAppendingString:@"s"];
    }else{
        [_readSecTime invalidate];
        [self jumpeHome:NO];
    }
}

#pragma mark - scrollerView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float x = scrollView.contentOffset.x;
    self.guiPageControl.currentPage = (int)(x/SCREEN_WIDTH);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    guideScrollViewBeginOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float x = scrollView.contentOffset.x;
    if (guideScrollViewBeginOffsetX == SCREEN_WIDTH*2) {
        if (x > SCREEN_WIDTH*2 + 0.5f) {
            [self jumpeHome:YES];
        }
    }
}

//- (void)scrollView
#pragma mark - EnterAppDelegate
- (void)enterAppBtnSelect{
    [self jumpeHome:NO];
}

#pragma mark - goHome
- (void)jumpeHome:(BOOL)animated {
    //关闭定时器
    [_readSecTime invalidate];
    [self setUserData:isNotFirstOpenKey value:isNotFirstOpenValue];
    XNTabBarView *rootView = [XNTabBarView loadFromStoryboard];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:rootView] animated:animated];
}
- (IBAction)jumpButtonSelect:(id)sender {
    [self jumpeHome:NO];
}

@end
