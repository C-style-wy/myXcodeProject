//
//  XNTabBarView.m
//  henews
//
//  Created by 汪洋 on 15/10/23.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "XNTabBarView.h"
#import "XNTabBarButton.h"
#import "HomeViewController.h"
#import "NewsViewController.h"
#import "ViewPointViewController.h"
#import "SearchViewController.h"
#import "MyViewController.h"

@interface XNTabBarView ()

@property (nonatomic, weak) UIButton *selectedBtn;
@end

@implementation XNTabBarView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    [self.tabBar removeFromSuperview];
    
    int screenW = [[UIScreen mainScreen] bounds].size.width;
    int screenH = [[UIScreen mainScreen] bounds].size.height;
    
    UIView *tabBarView = [[UIView alloc]init];
    tabBarView.frame = CGRectMake(0, screenH-43, screenW, 43);
    tabBarView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *line = [[UIImageView alloc]init];
    line.frame = CGRectMake(0, 0, screenW, 0.5f);
    line.image = [UIImage imageNamed:@"menuFenge.png"];
    [tabBarView addSubview:line];
    
    for (int i = 0; i < 5; i++) {
        XNTabBarButton *bnt = [[XNTabBarButton alloc] init];
        
        NSString *imageName = [NSString stringWithFormat:@"menu%d", i+1];
        NSString *imageNameSel = [NSString stringWithFormat:@"menusel%d", i+1];
        
        [bnt setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [bnt setImage:[UIImage imageNamed:imageNameSel] forState:UIControlStateSelected];
        
        CGFloat bntWidth = tabBarView.frame.size.width / 5;
        CGFloat x = i * bntWidth;
        bnt.frame = CGRectMake(x, 0, bntWidth, 43);
        
        if (0 == i) {
            [bnt setTitle:@"推荐" forState:UIControlStateNormal];
            [bnt setImageEdgeInsets:UIEdgeInsetsMake(4, (bntWidth-22)/2, 21, (bntWidth-22)/2)];
            [bnt setTitleEdgeInsets:UIEdgeInsetsMake(27, -49, 6, 0)];
            
        }else if (1 == i) {
            [bnt setTitle:@"资讯" forState:UIControlStateNormal];
            [bnt setImageEdgeInsets:UIEdgeInsetsMake(4, (bntWidth-18)/2, 21, (bntWidth-18)/2)];
            [bnt setTitleEdgeInsets:UIEdgeInsetsMake(27, -39, 6, 0)];
        }else if (2 == i) {
            [bnt setTitle:@"视界" forState:UIControlStateNormal];
            [bnt setImageEdgeInsets:UIEdgeInsetsMake(4, (bntWidth-18)/2, 21, (bntWidth-18)/2)];
            [bnt setTitleEdgeInsets:UIEdgeInsetsMake(27, -39, 6, 0)];
        }else if (3 == i) {
            [bnt setTitle:@"发现" forState:UIControlStateNormal];
            [bnt setImageEdgeInsets:UIEdgeInsetsMake(4, (bntWidth-18)/2, 21, (bntWidth-18)/2)];
            [bnt setTitleEdgeInsets:UIEdgeInsetsMake(27, -39, 6, 0)];
        }else if (4 == i) {
            [bnt setTitle:@"我的" forState:UIControlStateNormal];
            [bnt setImageEdgeInsets:UIEdgeInsetsMake(4, (bntWidth-18)/2, 21, (bntWidth-18)/2)];
            [bnt setTitleEdgeInsets:UIEdgeInsetsMake(27, -39, 6, 0)];
        }
        [bnt setTitleColor:[UIColor colorWithRed:0.88 green:0.02 blue:0.46 alpha:1] forState:UIControlStateSelected];
        bnt.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [bnt setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forState:UIControlStateNormal];
        
        [tabBarView addSubview:bnt];
        bnt.tag = i;
        [bnt addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (0 == i) {
            bnt.selected = YES;
            self.selectedBtn = bnt;
        }
    }
    
    [self.view addSubview:tabBarView];
    
    HomeViewController *home = [[HomeViewController alloc]init];
    NewsViewController *news = [[NewsViewController alloc]init];
    ViewPointViewController *viewPoint = [[ViewPointViewController alloc]init];
    SearchViewController *find = [[SearchViewController alloc]init];
    MyViewController *my = [[MyViewController alloc]init];
    self.viewControllers = @[home, news, viewPoint, find, my];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickBtn:(UIButton *)button {
    if (self.selectedBtn == button) {
        [self->_reflushDelegate reflushTableView];
    }else{
        self.selectedBtn.selected = NO;
        button.selected = YES;
        self.selectedBtn = button;
        self.selectedIndex = button.tag;
    }
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
