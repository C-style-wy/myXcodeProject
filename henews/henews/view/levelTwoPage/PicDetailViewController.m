//
//  PicDetailViewController.m
//  henews
//
//  Created by 汪洋 on 15/11/30.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "PicDetailViewController.h"
#import "BottomTextInPicDetail.h"

@interface PicDetailViewController ()
{
    HeadInPicDetail *controlHead;
    BottomTextInPicDetail *text;
    NSString *picTitle;
    int curIndex;
    BOOL showToolBarAndText;
}
@end

@implementation PicDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self preferredStatusBarStyle];
    showToolBarAndText = true;
    [self prefersStatusBarHidden];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden{
//    return !showToolBarAndText; //返回NO表示要显示，返回YES将hiden
    if (showToolBarAndText) {
        return NO;
    }else{
        return YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    NSLog(@"url=%@", self.picUrl);
    [self UIInit];
}

-(void)UIInit{
    if (self.imagesScrollView == nil) {
        self.imagesScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.view addSubview:self.imagesScrollView];
        self.imagesScrollView.pagingEnabled = YES;
        self.imagesScrollView.showsHorizontalScrollIndicator = NO;
        self.imagesScrollView.showsVerticalScrollIndicator = NO;
        self.imagesScrollView.bounces = NO;
        self.imagesScrollView.backgroundColor = [UIColor clearColor];
        self.imagesScrollView.delegate = self;
        self.imagesScrollView.alwaysBounceVertical = YES;
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [self.imagesScrollView addGestureRecognizer:singleTap];
    }
    
    controlHead = [[HeadInPicDetail alloc]init];
    controlHead.delegate = self;
    [self.view addSubview:controlHead];
    
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    loading.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    loading.hidesWhenStopped = YES;
    [self.view addSubview:loading];
    [loading startAnimating];
    _loading = loading;
    
    [Request requestPostForJSON:@"picData" url:_picUrl delegate:self paras:nil msg:0 useCache:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestDidReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg isCacheReturn:(BOOL)flag{
    [_loading stopAnimating];
    if ([tag isEqual:@"picData"]) {
        [self dealPicDataBack:returnJson];
    }
}

-(void)dealPicDataBack:(NSDictionary*)data{
    NSArray *images = [[data objectForKey:@"content"] objectForKey:@"images"];
    picTitle = [[data objectForKey:@"content"] objectForKey:@"name"];
    
    if (_imagesAry == nil) {
        _imagesAry = [[NSMutableArray alloc]init];
    }
    _imagesScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*(images.count), 0);
    for (int i = 0; i < images.count; i++) {
        picDetailData *picCell = [[picDetailData alloc]init];
        [picCell initWithData:[images objectAtIndex:i]];
        [_imagesAry addObject:picCell];
        
        UIImageView *pic = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_imagesScrollView addSubview:pic];
        [pic setImageWithURL:[NSURL URLWithString:picCell.url]];
        pic.contentMode = UIViewContentModeScaleAspectFit;
    }
    text = [[BottomTextInPicDetail alloc]initWithTotalNumPic:(int)self.imagesAry.count];
    [self.view addSubview:text];
    curIndex = 0;
    [text setTextPostion:[self.imagesAry objectAtIndex:curIndex] curIndex:(curIndex+1) title:picTitle];
}

#pragma mark - UIScrollViewDelegate
//scrollView停止滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offX = scrollView.contentOffset.x;
    if (curIndex != (int)(offX/SCREEN_WIDTH)) {
        curIndex = (int)(offX/SCREEN_WIDTH);
        if (curIndex < self.imagesAry.count && [self.imagesAry objectAtIndex:curIndex]) {
            [text setTextPostion:[self.imagesAry objectAtIndex:curIndex] curIndex:(curIndex+1) title:picTitle];
        }
    }
}

#pragma mark - HeadInPicDetailDelegate
- (void)headInPicDetail:(HeadInPicDetail*)head backButton:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    if (showToolBarAndText) {
        [UIView animateWithDuration:0.3f animations:^{
            text.alpha = 0.0f;
            controlHead.alpha = 0.0f;
            showToolBarAndText = NO;
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            text.alpha = 1.0f;
            controlHead.alpha = 1.0f;
            showToolBarAndText = YES;
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
}
@end
