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
    myHeadBg.frame = CGRectMake(0, 0, screenW, 164);
    myHeadBg.image = [UIImage imageNamed:@"my_head_bg.png"];
    [self.view addSubview:myHeadBg];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"headeriocn.png"]];
    imageView.frame = CGRectMake((SCREEN_WIDTH-45)/2, 59.5f, 45, 45);
    imageView.layer.cornerRadius = 22.5f;
    imageView.clipsToBounds = YES;
    imageView.layer.borderWidth = 2;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:imageView];
    
    UILabel *userName = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, 19)];
    userName.text = @"点击登陆";
    [self.view addSubview:userName];
    userName.textColor = [UIColor whiteColor];
    userName.font = [UIFont systemFontOfSize:13.0f];
    userName.textAlignment = NSTextAlignmentCenter;
    
    for (int i = 0; i < 4; i++) {
        UIView *view1 = [[UIView alloc]init];
        CGFloat initY = 164 + 39*i;
        view1.frame = CGRectMake(0, initY, screenW, 39);
        
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(0, 0, screenW, 39);
        [button addTarget:self action:@selector(myBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setBackgroundImage:[UIImage imageNamed:@"menuFenge.png"] forState:UIControlStateHighlighted];
        button.tag = i;
        [view1 addSubview:button];
        
        UIImageView *line = [[UIImageView alloc]init];
        line.frame = CGRectMake(8, 38.5f, screenW-16, 0.5f);
        line.image = [UIImage imageNamed:@"menuFenge.png"];
        [view1 addSubview:line];
        
        NSString *imageName = [NSString stringWithFormat:@"my_list_icon_%d", i+1];
        UIImageView *icon = [[UIImageView alloc]init];
        icon.frame = CGRectMake(8, 9.5f, 20, 20);
        icon.image = [UIImage imageNamed:imageName];
        [view1 addSubview:icon];
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(41, 0, 90, 39);
        label.font = [UIFont systemFontOfSize:14.0f];
        if (0 == i) {
            label.text = @"我的快讯";
        }else if (1 == i){
            label.text = @"我的收藏";
        }else if (2 == i){
            label.text = @"我的评论";
        }else if (3 == i){
            label.text = @"我的积分";
        }
        [view1 addSubview:label];
        
        UIImageView *arrow = [[UIImageView alloc]init];
        arrow.frame = CGRectMake(screenW-16, 12.5f, 8, 14);
        arrow.image = [UIImage imageNamed:@"right_arrow.png"];
        [view1 addSubview:arrow];
        
        [self.view addSubview:view1];
    }
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 320, SCREEN_WIDTH, SCREEN_HEIGHT-363)];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = [UIColor clearColor];
    for (int i = 0; i < 5; i++) {
        int line = (int)i/3;
        int row = i%3;
        float itemX = (bottomView.frame.size.width/3)*row;
        float itemY = (bottomView.frame.size.height/2)*line;
        
        UIView *itemView = [[UIView alloc]initWithFrame:CGRectMake(itemX, itemY, bottomView.frame.size.width/3, bottomView.frame.size.height/2)];
        [bottomView addSubview:itemView];
        
        
        NSLog(@"itemX=%f", itemX);
        NSLog(@"itemY=%f", itemY);
        
        NSString *imageName = [NSString stringWithFormat:@"my_b_%i", i+1];
//        NSString *imageNameSel = [NSString stringWithFormat:@"my_b_s_%i", i+1];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((itemView.frame.size.width-45)/2, 25.5f, 45, 45)];
        
        button.tag = 4+i;
        
        [button addTarget:self action:@selector(myBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [itemView addSubview:button];
    }
}

- (void)myBtnClick:(UIButton *)button {
    if (0 == button.tag) {

    }else if (1 == button.tag){
        
    }else if (2 == button.tag){

    }else if (3 == button.tag){

    }else if (4 == button.tag){
        
    }else if (5 == button.tag){
        
    }else if (6 == button.tag){
        
    }else if (7 == button.tag){
        
    }else if (8 == button.tag){
        
    }
}

#pragma mark - UICollectionView


@end
