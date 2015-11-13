//
//  ViewPointViewController.m
//  henews
//
//  Created by 汪洋 on 15/10/23.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "ViewPointViewController.h"
#import "WHScrollAndPageView.h"
#import "APIStringMacros.h"

@interface ViewPointViewController()<WHcrollViewViewDelegate>
{
    WHScrollAndPageView *_whView;
}

@end

@implementation ViewPointViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    UIImageView *bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:bg];
    
    //创建view（view中包含UIScrollView、UIPageControl，设置frame）
    _whView = [[WHScrollAndPageView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-43)];
    
    //把N张图片放到imageView上
    NSMutableArray *tempAry = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guidepage%i.jpg", (i%3)+1]];
        
        [tempAry addObject:imageView];
    }
    
    [_whView setImageViewAry:tempAry];
    
    [self.view addSubview:_whView];
    
    [_whView shouldAutoShow:NO];
    
    _whView.delegate = self;
    
//    UIView *view = [[UIView alloc]initWithFrame:SCREEN_FRAME];
//    
//    UIScrollView *testScroll = [[UIScrollView alloc]initWithFrame:SCREEN_FRAME];
//    testScroll.contentSize = CGSizeMake(SCREEN_WIDTH*3, 0);
//    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    image1.image = [UIImage imageNamed:@"guidepage1.jpg"];
//    [testScroll addSubview:image1];
//    
//    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    image2.image = [UIImage imageNamed:@"guidepage2.jpg"];
//    [testScroll addSubview:image2];
//    
//    UIImageView *image3 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    image3.image = [UIImage imageNamed:@"guidepage3.jpg"];
//    [testScroll addSubview:image3];
//    
//    [view addSubview:testScroll];
//    [self.view addSubview:view];
    
}

-(void)didClickPage:(WHScrollAndPageView *)view atIndex:(NSInteger)index{

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
