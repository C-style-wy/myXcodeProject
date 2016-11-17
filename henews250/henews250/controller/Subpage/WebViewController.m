//
//  WebViewController.m
//  henews250
//
//  Created by 汪洋 on 16/9/19.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initPage {
    [super initPage];
    self.headView.title.text = @"和新闻";
    
    if (self.hideShareButton) {
        self.pageShareBtn.hidden = YES;
    }else{
        self.pageShareBtn.hidden = NO;
    }
    if (self.isWebLinkUrl) {
        //1.创建并加载远程网页
        //    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
        [self.activityIndicator startAnimating];
        NSURL *url = [NSURL URLWithString:self.url];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }else{
        [self.activityIndicator startAnimating];
        [NetworkManager postRequestJsonWithURL:self.url params:nil cacheBlock:^(NSDictionary *returnJson) {
            NSURL *url = [NSURL URLWithString:[[returnJson objectForKey:@"content"] objectForKey:@"realUrl"]];
            [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        } successBlock:^(NSDictionary *returnJson) {
            NSURL *url = [NSURL URLWithString:[[returnJson objectForKey:@"content"] objectForKey:@"realUrl"]];
            [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        } failureBlock:^(NSError *error) {
            [self.view makeToast:@"网络错误，稍后再试"];
        } showHUD:NO];
    }
}

#pragma mark - 懒加载
- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        loading.frame = CGRectMake(0.0f, 0.0f, 32.0f, 32.0f);
        loading.center = self.view.center;
        loading.hidesWhenStopped = YES;
        [self.view addSubview:loading];
        self.activityIndicator = loading;
    }
    return _activityIndicator;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, self.headView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-self.headView.frame.size.height)];
        [self.view addSubview:_webView];
        //是否支持交互
        [_webView setUserInteractionEnabled:YES];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor clearColor];
        //Opaque是不透明的意思
        [_webView setOpaque:NO];
        //自动缩放以适应屏幕
        [_webView setScalesPageToFit:YES];
    }
    return _webView;
}

- (void)pageBackBtnSelect {
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
    [self.activityIndicator startAnimating];
}
//网页加载完成的时候调用
- (void )webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityIndicator stopAnimating];
}
//网页加载错误的时候调用
- (void)webView:(UIWebView *)webView  didFailLoadWithError:(NSError *)error{
    [self.view makeToast:@"网络错误，稍后再试"];
}
@end
