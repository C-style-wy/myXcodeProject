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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getUrl:(NSString *)urlString{
//    [Request requestPostForJSON:@"detailData" url:urlString delegate:self paras:nil msg:0];
    NSLog(@"picDetail=======");
}

-(void)requestDidReturn:(NSString*)tag returnStr:(NSString*)returnStr returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg isCacheReturn:(BOOL)flag{
    if ([tag isEqual:@"detailData"]) {
//        [self dealDetailDataBack:returnJson];
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
