//
//  MyViewController.m
//  henews
//
//  Created by 汪洋 on 15/10/23.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "MyViewController.h"
#import "DetailViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

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
    [self initPageLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initPageLayout{
    int screenW = [[UIScreen mainScreen] bounds].size.width;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    UIImageView *myHeadBg = [[UIImageView alloc]init];
    myHeadBg.frame = CGRectMake(0, 0, screenW, 177.5);
    myHeadBg.image = [UIImage imageNamed:@"my_head_bg.png"];
    [self.view addSubview:myHeadBg];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"secrecy_s.png"]];
    imageView.frame = CGRectMake((SCREEN_WIDTH-62.0f)/2, 49.0f, 62.0f, 62.0f);
    imageView.layer.cornerRadius = 31.0f;
    imageView.clipsToBounds = YES;
    imageView.layer.borderWidth = 0;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:imageView];
    
    UILabel *userName = [[UILabel alloc]initWithFrame:CGRectMake(0, 126, SCREEN_WIDTH, 22)];
    userName.text = @"点击登陆";
    [self.view addSubview:userName];
    userName.textColor = [UIColor whiteColor];
    userName.font = [UIFont systemFontOfSize:13.0f];
    userName.textAlignment = NSTextAlignmentCenter;
    
    for (int i = 0; i < 5; i++) {
        UIView *view1 = [[UIView alloc]init];
        CGFloat initY = 177.5f + 32.5f*i;
        view1.frame = CGRectMake(0, initY, screenW, 32.5f);
        
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(0, 0, screenW, view1.frame.size.height);
        [button addTarget:self action:@selector(myBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(buttonBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
        
        button.tag = i;
        [view1 addSubview:button];
        
        UIImageView *line = [[UIImageView alloc]init];
        line.frame = CGRectMake(8, button.frame.size.height - 0.5f, screenW-16, 0.5f);
        line.image = [UIImage imageNamed:@"menuFenge.png"];
        [view1 addSubview:line];
        
        NSString *imageName = [NSString stringWithFormat:@"my_list_icon_%d", i+1];
        UIImageView *icon = [[UIImageView alloc]init];
        icon.frame = CGRectMake(8, (button.frame.size.height - 19.5f)/2, 19.5f, 19.5f);
        icon.image = [UIImage imageNamed:imageName];
        [view1 addSubview:icon];
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(41, 0, 90, button.frame.size.height);
        label.font = [UIFont systemFontOfSize:12.5f];
        if (0 == i) {
            label.text = @"我的消息";
        }else if (1 == i){
            label.text = @"我参与的";
            UILabel *labelTip = [[UILabel alloc]init];
            labelTip.frame = CGRectMake(0, 0, button.frame.size.width - 29, button.frame.size.height);
            labelTip.text = @"评论/活动/爆料";
            labelTip.textColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1];
            labelTip.font = [UIFont systemFontOfSize:12.5f];
            labelTip.textAlignment =  NSTextAlignmentRight;
            [view1 addSubview:labelTip];
        }else if (2 == i){
            label.text = @"我的快讯";
        }else if (3 == i){
            label.text = @"我的收藏";
        }else if (4 == i){
            label.text = @"我的积分";
            UILabel *labelScore = [[UILabel alloc]init];
            labelScore.frame = CGRectMake(0, 0, button.frame.size.width - 29, button.frame.size.height);
            labelScore.text = @"积分288";
            labelScore.textColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1];
            labelScore.font = [UIFont systemFontOfSize:12.5f];
            labelScore.textAlignment =  NSTextAlignmentRight;
            [view1 addSubview:labelScore];
        }
        [view1 addSubview:label];
        
        UIImageView *arrow = [[UIImageView alloc]init];
        arrow.frame = CGRectMake(screenW-16, (button.frame.size.height - 14)/2, 8, 14);
        arrow.image = [UIImage imageNamed:@"right_arrow.png"];
        [view1 addSubview:arrow];
        
        [self.view addSubview:view1];
    }
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 164 -40, SCREEN_WIDTH, 164)];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = [UIColor clearColor];
    for (int i = 0; i < 5; i++) {
        int line = (int)i/3;
        int row = i%3;
        float itemX = (bottomView.frame.size.width/3)*row;
        float itemY = (bottomView.frame.size.height/2)*line;
        
        UIView *itemView = [[UIView alloc]initWithFrame:CGRectMake(itemX, itemY, bottomView.frame.size.width/3, bottomView.frame.size.height/2)];
//        itemView.backgroundColor = [UIColor redColor];
        [bottomView addSubview:itemView];
        
        
        NSLog(@"itemX=%f", itemX);
        NSLog(@"itemY=%f", itemY);
        
        NSString *imageName = [NSString stringWithFormat:@"my_b_%i", i+1];
        NSString *imageNameSel = [NSString stringWithFormat:@"my_b_s_%i", i+1];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((itemView.frame.size.width-40)/2, 0, 40, 40)];
        
        button.tag = i;
        
        [button addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageNameSel] forState:UIControlStateHighlighted];
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, 45, itemView.frame.size.width, 18);
        
        label.font = [UIFont systemFontOfSize:12.5f];
        label.textAlignment = NSTextAlignmentCenter;
        if (0 == i) {
            label.text = @"爆料";
        }else if (1 == i){
            label.text = @"邀请好友";
        }else if (2 == i){
            label.text = @"扫一扫";
        }else if (3 == i){
            label.text = @"新闻搜索";
        }else if (4 == i){
            label.text = @"设置";
        }
        [itemView addSubview:label];
        [itemView addSubview:button];
    }
}

- (void)myBtnClick:(UIButton *)button {
    button.backgroundColor = [UIColor clearColor];
    if (0 == button.tag) {   //我的消息

    }else if (1 == button.tag){  //我参与的
        
    }else if (2 == button.tag){  //我的快讯

    }else if (3 == button.tag){  //我的收藏

    }else if (4 == button.tag){  //我的积分
        
    }
}

//  button高亮状态下的背景色
- (void)buttonBackGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor = [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1];
}

- (void)bottomBtnClick:(UIButton *)button {
    if (0 == button.tag) {   //爆料
        
    }else if (1 == button.tag){ //邀请好友
        
    }else if (2 == button.tag){  //扫一扫
        
    }else if (3 == button.tag){  //新闻搜索
        
    }else if (4 == button.tag){  //设置
        
    }
}

#pragma mark - UICollectionView


@end
