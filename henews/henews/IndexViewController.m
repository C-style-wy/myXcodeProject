//
//  IndexViewController.m
//  henews
//
//  Created by 汪洋 on 15/10/15.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "IndexViewController.h"
#import "XNTabBarView.h"
#import "Request.h"

@interface IndexViewController ()
{
    UIPageControl *pageControl;
    UIScrollView *scrollView;
}

@end

@implementation IndexViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    int screenW = [[UIScreen mainScreen] bounds].size.width;
    int screenH = [[UIScreen mainScreen] bounds].size.height;
    if ((320 == screenW && 480 == screenH) || (640 == screenW && 960 == screenH)) {
        bgImage.image = [UIImage imageNamed:@"launch640_960.png"];
    }else if ((320 == screenW && 568 == screenH) || (640 == screenW && 1136 == screenH)){
        bgImage.image = [UIImage imageNamed:@"launch640_1136.png"];
    }else if ((750 == screenW && 1334 == screenH) || (375 == screenW && 667 == screenH)){
        bgImage.image = [UIImage imageNamed:@"launch750_1334.png"];
    }else if ((1242 == screenW && 2208 == screenH) || (621 == screenW && 1104 == screenH)){
        bgImage.image = [UIImage imageNamed:@"launch1242_2208.png"];
    }
    [self.view addSubview:bgImage];
    
    [self firstEnterShowGuidePage];
    NSString *addHead = [GET_SERVER stringByAppendingString:GET_INDEX_URL];
    NSString *url = [addHead stringByAppendingString:@"合肥"];
    [Request requestPostForJSON:@"indexData" url:url delegate:self paras:nil msg:0 useCache:NO];
}

-(void)requestDidReturn:(NSString*)tag returnStr:(NSString*)returnStr returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg isCacheReturn:(BOOL)flag{    
    //处理广告
    _adviceData = [[AdviceData alloc]init];
    [_adviceData initWithData:[returnJson objectForKey:@"pic"] start:[returnJson objectForKey:@"startTime"] end:[returnJson objectForKey:@"endTime"] showTime:[returnJson objectForKey:@"displayTime"]];
    
    NSArray *newsAry = [returnJson objectForKey:@"hNewsNodes"];
    ProgramaStructure *stru = [[ProgramaStructure alloc]init];
    [stru compareAndSave:newsAry OrderName:NEWS_ORDER NotOrderName:NEWS_NOT_ORDER];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults stringForKey:@"isNotFirstOpen"] isEqual: @"1"]){
        XNTabBarView *tabBar = [[XNTabBarView alloc] init];
        [self.navigationController setViewControllers: [NSArray arrayWithObject:tabBar]animated: NO];
    }
}

-(void)firstEnterShowGuidePage{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults stringForKey:@"isNotFirstOpen"]){
        scrollView = [[UIScrollView alloc]initWithFrame:SCREEN_FRAME];
        scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, 0);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.bounces = NO;
        [self.view addSubview:scrollView];
        
        pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-20, SCREEN_WIDTH, 10)];
        pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:0.88 green:0.02 blue:0.46 alpha:1];
        pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        [self.view addSubview:pageControl];
        pageControl.numberOfPages=3;
        
        [self createView];
    }
}

-(void)createView{
    for (int i = 0; i < 3; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:SCREEN_FRAME];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        NSString *imageName = [NSString stringWithFormat:@"guidepage%d.jpg", i+1];
        imageView.image = [UIImage imageNamed:imageName];
        [view addSubview:imageView];
        
        UITapGestureRecognizer *singleTap = nil;
        if (0 == i) {
            singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress1:)];
        }else if (1 == i){
            singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress2:)];
        }else if (2 == i){
            singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress3:)];
        }
        
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:singleTap];
        
        [scrollView addSubview:view];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scroll{
    float x = scroll.contentOffset.x;
    pageControl.currentPage = (int)(x/SCREEN_WIDTH);
}

-(void)buttonpress1:(id)sender
{
    CGFloat pageWidth = CGRectGetWidth(self.view.bounds);
    CGPoint scrollPoint = CGPointMake(pageWidth, 0);
    [scrollView setContentOffset:scrollPoint animated:YES];
    
    pageControl.currentPage = 1;
    
}
-(void)buttonpress2:(id)sender
{
    CGFloat pageWidth = CGRectGetWidth(self.view.bounds);
    CGPoint scrollPoint = CGPointMake(pageWidth*2, 0);
    [scrollView setContentOffset:scrollPoint animated:YES];
    
    pageControl.currentPage = 2;
}

-(void)buttonpress3:(id)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults stringForKey:@"isNotFirstOpen"]){
        [userDefaults setObject:@"1" forKey:@"isNotFirstOpen"];
    }
    XNTabBarView *tabBar = [[XNTabBarView alloc] init];
    [self.navigationController setViewControllers: [NSArray arrayWithObject:tabBar]animated: YES];
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

@end
