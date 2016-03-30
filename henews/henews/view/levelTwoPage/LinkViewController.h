//
//  LinkViewController.h
//  henews
//
//  Created by 汪洋 on 16/3/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseViewController.h"

@interface LinkViewController : BaseViewController<UIWebViewDelegate>

@property (nonatomic, retain)NSString *linkUrl;
@property (nonatomic, retain)UIWebView *webView;
@property (nonatomic, retain)UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign)BOOL showShareButton;
@property (nonatomic, assign)BOOL shouldRequstAgain;

@end
