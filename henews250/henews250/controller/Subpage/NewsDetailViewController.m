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
    
    self.deleteData = [[HideDeleteMode alloc]init];
    [self.deleteData addObserver:self forKeyPath:@"hideDelete" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSLog(@"observeValueForKeyPath====");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn1:(id)sender {
    self.deleteData.hideDelete = YES;
}
- (IBAction)btn2:(id)sender {
    self.deleteData.hideDelete = NO;
}

- (void)dealloc {
    [self.deleteData removeObserver:self forKeyPath:@"hideDelete"];
}

@end
