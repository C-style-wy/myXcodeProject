//
//  WebViewController.h
//  henews250
//
//  Created by 汪洋 on 16/9/19.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SubBaseViewController.h"

@interface WebViewController : SubBaseViewController<UIWebViewDelegate>

@property (nonatomic, assign) BOOL isWebLinkUrl;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign) BOOL hideShareButton;

@end
