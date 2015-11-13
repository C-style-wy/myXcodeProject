//
//  IphoneParams.m
//  henews
//
//  Created by 汪洋 on 15/10/30.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "IphoneParams.h"

@implementation IphoneParams
{
    UIWebView *_webView;
    NSString *userAgent;
}

-(void)setIphoneParam
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"WD_VERSION==%@", [userDefaults stringForKey:@"WD_VERSION"]);
    if (![userDefaults stringForKey:@"isNotFirstOpen"]) {
        [userDefaults setObject:@"hxw" forKey:@"clientName"];
        [userDefaults setObject:@"123456" forKey:@"WD_UUID"];
        [userDefaults setObject:@"03" forKey:@"WD_CLIENT_TYPE"];
        
        [userDefaults setObject:[self getUserAgent] forKey:@"WD_UA"];
        
        UIDevice *device = [[UIDevice alloc] init];
        NSString *systemName = device.systemName;
        [userDefaults setObject:systemName forKey:@"WD_SYSTEM"];
        
        [userDefaults setObject:@"M201002" forKey:@"WD_CHANNEL"];
        
        CGFloat width = [[UIScreen mainScreen] bounds].size.width;
        CGFloat height = [[UIScreen mainScreen] bounds].size.height;
        CGFloat scale_screen = [UIScreen mainScreen].scale;
        NSString *wdresolution1 = [NSString stringWithFormat:@"%g",width*scale_screen];
        NSString *wdresolution2 = [NSString stringWithFormat:@"%g",height*scale_screen];
        NSString *wdresolution = [wdresolution1 stringByAppendingString:@"*"];
        wdresolution = [wdresolution stringByAppendingString:wdresolution2];
        [userDefaults setObject:wdresolution forKey:@"WD_RESOLUTION"];
        
        [userDefaults setObject:@"000000" forKey:@"WD_CP_ID"];
        
        NSDictionary *infoDictionary =[[NSBundle mainBundle]infoDictionary];
        NSString *version = [infoDictionary objectForKey:@"CFBundleVersion"];
        [userDefaults setObject:version forKey:@"WD_VERSION"];
        [userDefaults synchronize];
    }
}

-(NSString *) getUserAgent
{
    _webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.eoe.cn"]]];
    while (userAgent == nil) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    NSLog(@"UserAgent:%@", userAgent);
    return userAgent;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (webView == _webView) {
        userAgent = [request valueForHTTPHeaderField:@"User-Agent"];
        return NO;
    }
    return YES;
}

@end
