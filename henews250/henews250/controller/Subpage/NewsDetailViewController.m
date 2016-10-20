//
//  NewsDetailViewController.m
//  henews250
//
//  Created by 汪洋 on 16/9/7.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.headView.hidden = YES;
//    [MYLoading show];
    NSString *a = @"s";
    self.pageData = [[NSMutableArray alloc]init];
    [self.pageData addObject:a];
    [self.pageData removeAllObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (NSMutableArray *)pageData {
//    if (!_pageData) {
//        _pageData = [[NSMutableArray alloc]init];
//    }
//    return _pageData;
//}

- (void)setPageData:(NSMutableArray *)pageData {
    _pageData = pageData;
    NSLog(@"==========");
}
@end
