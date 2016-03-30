//
//  LinkViewController.m
//  henews
//
//  Created by 汪洋 on 16/3/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "LinkViewController.h"

@interface LinkViewController ()

@end

@implementation LinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"linkUrl=%@", self.linkUrl);
    self.head.pageTitle.text = @"和新闻";
    if (!self.showShareButton) {
        self.head.shareButton.hidden = YES;
    }
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loading.frame = CGRectMake(0.0f, 0.0f, 32.0f, 32.0f);
    loading.center = self.view.center;
    loading.hidesWhenStopped = YES;
    [self.view addSubview:loading];
    self.activityIndicator = loading;
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, self.head.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-self.head.frame.size.height)];
    [self.view addSubview:self.webView];
    //是否支持交互
    [self.webView setUserInteractionEnabled:YES];
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor clearColor];
    //Opaque是不透明的意思
    [self.webView setOpaque:NO];
    //自动缩放以适应屏幕
    [self.webView setScalesPageToFit:YES];
    //加载网页的方式
    if (self.shouldRequstAgain) {
        [Request requestPostForJSON:@"linkData" url:self.linkUrl delegate:self paras:nil msg:0 useCache:YES];
    }else{
        //1.创建并加载远程网页
        //    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
        NSURL *url = [NSURL URLWithString:self.linkUrl];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
    
}

-(void)requestDidReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg isCacheReturn:(BOOL)flag{
    [self.activityIndicator stopAnimating];
    if ([tag isEqual:@"linkData"]) {
        NSURL *url = [NSURL URLWithString:[[returnJson objectForKey:@"content"] objectForKey:@"realUrl"]];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PageHeadDelegate
- (void)pageHead:(PageHead *)head shareButton:(UIButton *)button{
    
}

- (void)pageHead:(PageHead*)head backButton:(UIButton *)button{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

//网页开始加载的时候调用
- (void )webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad====");
    
    [self.activityIndicator startAnimating];
}
//网页加载完成的时候调用
- (void )webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad====");
    [self.activityIndicator stopAnimating];
//    [self.activityIndicator removeFromSuperview];
}
//网页加载错误的时候调用
- (void)webView:(UIWebView *)webView  didFailLoadWithError:(NSError *)error{
    
}

@end
