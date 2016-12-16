//
//  PicViewController.m
//  henews250
//
//  Created by 汪洋 on 16/9/19.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "PicViewController.h"

static NSString * const PicDetailTag = @"PicDetailTag";

@interface PicViewController ()

@end

@implementation PicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initPage{
    [super initPage];
    self.view.backgroundColor = [UIColor colorWithHexColor:@"#242020"];
    self.headView.hidden = YES;
    [NetworkManager postRequestJsonWithURL:self.url params:nil delegate:self tag:PicDetailTag msg:0 useCache:YES update:YES showHUD:YES];
}

#pragma mark - 网络返回
- (void)requestDidFinishLoading:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg{
    if ([tag isEqualToString:PicDetailTag]) {
        self.picDetailData = [NewsDetailMode mj_objectWithKeyValues:returnJson];
        [self handleDataBack];
    }
}

//缓存数据返回
- (void)requestDidCacheReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger) msg {
    
}

- (void)requestdidFailWithError:(NSError*)error tag:(NSString *)tag msg:(NSInteger)msg {
    
}

- (void)handleDataBack {
    NSArray *imageAry = self.picDetailData.content.images;
    CGFloat x = 0;
    for (ImagesMode *image in imageAry) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        x += SCREEN_WIDTH;
        [imageView loadFromWebWithUrlString:image.url animated:YES];
        [self.mainScrolView addSubview:imageView];
    }
    self.mainScrolView.contentSize = CGSizeMake(x, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)backBtnSelect:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
