//
//  IndexViewController.m
//  henews250
//
//  Created by 汪洋 on 16/7/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "IndexViewController.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

#pragma mark - viewDiaLoad,viewWillAppear,viewDidAppear,viewWillDisappear,viewDidDisappear
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置各个分辨率的启动底图
    [self settingLaunchImage];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - menory warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置启动图函数
- (void)settingLaunchImage{
    switch ([self returnIphoneType]) {
        case iPhone4:
            self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
            break;
        case iPhone5:
            self.launchImageView.image = [UIImage  imageNamed:@"LaunchImage-700-568h"];
            break;
        case iPhone6:
            self.launchImageView.image = [UIImage  imageNamed:@"LaunchImage-800-667h"];
            break;
        case iPhone6p:
            self.launchImageView.image = [UIImage  imageNamed:@"LaunchImage-800-Portrait-736h"];
            break;
        default:
            self.launchImageView.image = [UIImage  imageNamed:@"LaunchImage-700-568h"];
            break;
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
