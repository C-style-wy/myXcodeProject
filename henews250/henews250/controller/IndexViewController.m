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

@interface IndexViewController ()

@end

@implementation IndexViewController

#pragma mark - viewDiaLoad,viewWillAppear,viewDidAppear,viewWillDisappear,viewDidDisappear
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置各个分辨率的启动底图
    [self settingLaunchImage];
    //设置显示或者隐藏导航图
    [self showOrHideGuideImage];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - menory warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.guideScrollView.delegate = self;
    self.guideScrollView.backgroundColor = [UIColor clearColor];
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
    
    if (![self getUserData:isNotFirstOpenKey]) {
        self.scrollBgView.hidden = NO;
        [self setUserData:isNotFirstOpenKey value:isNotFirstOpenValue];
    }else{
        NSLog(@"不是第一次打开");
        self.scrollBgView.hidden = NO;
    }
}

#pragma mark - scrollerView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scroll{
    float x = scroll.contentOffset.x;
    self.guiPageControl.currentPage = (int)(x/SCREEN_WIDTH);
}
#pragma mark - EnterAppDelegate
- (void)enterAppBtnSelect{
//    XNTabBarView *rootView = [[XNTabBarView alloc]init];
    
    //获取storyboard: 通过bundle根据storyboard的名字来获取我们的storyboard,
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //由storyboard根据myView的storyBoardID来获取我们要切换的视图
    UIViewController *rootView = [story instantiateViewControllerWithIdentifier:@"rootStoryboard"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:rootView] animated:NO];
    
//    [self performSegueWithIdentifier:@"showHome" sender:self];
//    self.navigationController.roo
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
