//
//  XNTabBarView.m
//  henews250
//
//  Created by 汪洋 on 16/7/7.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "XNTabBarView.h"
#import "UIViewController+LoadFromStoryboard.h"

#import "HomeController.h"
#import "NewsViewController.h"
#import "ViewPointViewController.h"
#import "WelfareViewController.h"
#import "MyViewController.h"

@interface XNTabBarView ()

@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation XNTabBarView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar removeFromSuperview];
    [self addMenuView];
    
    HomeController *home = [HomeController loadFromStoryboard];
    self.homeDelegate = home;
    NewsViewController *news = [NewsViewController loadFromStoryboard];
    self.newsDelegate = news;
    ViewPointViewController *viewPoint = [ViewPointViewController loadFromStoryboard];
    self.viewPointDelegate = viewPoint;
    WelfareViewController *welfare = [WelfareViewController loadFromStoryboard];
    self.welfareDelegate = welfare;
    MyViewController *my = [MyViewController loadFromStoryboard];
    
    self.viewControllers = @[home, news, viewPoint, welfare, my];
    
//    self.tabBarView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - menuView
- (void)addMenuView {
    UIView *tabBarView = [[UIView alloc]init];
    self.tabBarView = tabBarView;
    tabBarView.frame = CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40);
    tabBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabBarView];
    
    UIImageView *line = [[UIImageView alloc]init];
    line.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5f);
    line.image = [UIImage imageNamed:@"menuFengexian"];
    [tabBarView addSubview:line];
    
    for (int i = 0; i < 5; i++) {
        XNTabBarButton *btn = [[XNTabBarButton alloc]init];
        
        NSString *imageName = [NSString stringWithFormat:@"menu%d", i+1];
        NSString *imageNameSel = [NSString stringWithFormat:@"menusel%d", i+1];
        
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageNameSel] forState:UIControlStateSelected];
        
        CGFloat bntWidth = tabBarView.frame.size.width / 5;
        CGFloat x = i * bntWidth;
        btn.frame = CGRectMake(x, 0, bntWidth, 40);
        
        if (0 == i) {
            _homeBtn = btn;
            [btn setTitle:@"推荐" forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(4, (bntWidth-22)/2, 18, (bntWidth-22)/2)];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(28, -49, 6, 0)];
        }else if (1 == i) {
            _newsBtn = btn;
            [btn setTitle:@"资讯" forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(4, (bntWidth-16)/2, 18, (bntWidth-16)/2)];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(28, -36, 6, 0)];
        }else if (2 == i) {
            _viewPointBtn = btn;
            [btn setTitle:@"视界" forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(4, (bntWidth-18)/2, 18, (bntWidth-18)/2)];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(28, -36, 6, 0)];
        }else if (3 == i) {
            _welfareBtn = btn;
            [btn setTitle:@"福利" forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(4, (bntWidth-18)/2, 18, (bntWidth-18)/2)];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(28, -40, 6, 0)];
        }else if (4 == i) {
            [btn setTitle:@"我的" forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(4, (bntWidth-16)/2, 18, (bntWidth-16)/2)];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(28, -36, 6, 0)];
        }
        [btn setTitleColor:[UIColor colorWithRed:0.88 green:0.02 blue:0.46 alpha:1] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [btn setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forState:UIControlStateNormal];
        
        [tabBarView addSubview:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (0 == i) {
            btn.selected = YES;
            self.selectedBtn = btn;
        }
    }
}

- (void)clickBtn:(UIButton *)button {
    if (self.selectedBtn == button) {
        if (button == _homeBtn) {
            if ([self.homeDelegate respondsToSelector:@selector(tabBarBtnSelectAgain)]) {
                [self.homeDelegate tabBarBtnSelectAgain];
            }
        }else if (button == _newsBtn){
            if ([self.newsDelegate respondsToSelector:@selector(tabBarBtnSelectAgain)]) {
                [self.newsDelegate tabBarBtnSelectAgain];
            }
        }else if (button == _viewPointBtn){
            if ([self.viewPointDelegate respondsToSelector:@selector(tabBarBtnSelectAgain)]) {
                [self.viewPointDelegate tabBarBtnSelectAgain];
            }
        }else if (button == _welfareBtn){
            if ([self.welfareDelegate respondsToSelector:@selector(tabBarBtnSelectAgain)]) {
                [self.welfareDelegate tabBarBtnSelectAgain];
            }
        }
        
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
