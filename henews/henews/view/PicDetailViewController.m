//
//  PicDetailViewController.m
//  henews
//
//  Created by 汪洋 on 15/11/30.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "PicDetailViewController.h"

@interface PicDetailViewController ()

@end

@implementation PicDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self preferredStatusBarStyle];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self UIInit];
}

-(void)UIInit{
    if (_imagesScrollView == nil) {
        _imagesScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.view addSubview:_imagesScrollView];
        _imagesScrollView.pagingEnabled = YES;
        _imagesScrollView.showsHorizontalScrollIndicator = NO;
        _imagesScrollView.showsVerticalScrollIndicator = NO;
        _imagesScrollView.bounces = NO;
//        _imagesScrollView.backgroundColor = [UIColor redColor];
        _imagesScrollView.alwaysBounceVertical = YES;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 58)];
    headView.backgroundColor = [UIColor clearColor];
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 38)];
    titleView.backgroundColor = [UIColor clearColor];
    [headView addSubview:titleView];
    [self.view addSubview:headView];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, titleView.frame.size.height)];
    
    [backBtn addTarget:self action:@selector(backBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:backBtn];
    
    [backBtn setImage:[UIImage imageNamed:@"back_arrow.png"] forState:UIControlStateNormal];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(9.5f, 8, 9.5f, 41)];
    
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
}


- (void)backBtnSelect:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
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
