//
//  MYPhoneParam.m
//  henews250
//
//  Created by 汪洋 on 2016/10/19.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "MYPhoneParam.h"

@implementation MYPhoneParam{
    UIWebView *_webView;
    NSString *userAgent;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static MYPhoneParam *handle;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [super allocWithZone:zone];
    });
    return handle;
}

//返回单例
+ (MYPhoneParam *)sharedInstance{
    return [[super alloc]init];
}

#pragma mark - 懒加载
- (NSUserDefaults *)userDefaults {
    if (!_userDefaults) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDefaults;
}

- (BOOL)isFirstOpen {
    NSString *isOrNoFirstStr = [self.userDefaults stringForKey:FirstOpenKey];
    if (isOrNoFirstStr) {
        if ([isOrNoFirstStr isEqualToString:@"NO"]) {
            return NO;
        }else{
            return YES;
        }
    }else {
        return DefaultFirstOpen;
    }
}

- (void)setIsFirstOpen:(BOOL)isFirstOpen {
    if (isFirstOpen) {
        [self.userDefaults setObject:@"YES" forKey:FirstOpenKey];
    }else{
        [self.userDefaults setObject:@"NO" forKey:FirstOpenKey];
    }
}

//客户端名
- (NSString *)clientName {
    if (!_clientName) {
        NSString *name = [self.userDefaults stringForKey:WD_CLIENTNAME];
        if (name) {
            _clientName = name;
        }else{
            [self.userDefaults setObject:DefaultClientName forKey:WD_CLIENTNAME];
            _clientName = DefaultClientName;
        }
    }
    return _clientName;
}

//设备唯一标示udid
- (NSString *)uuid {
    if (!_uuid) {
        NSString *uuid = [self.userDefaults stringForKey:WD_UUID];
        if (uuid) {
            _uuid = uuid;
        }else{
            uuid = [self getOpenUDID];
            _uuid = uuid;
            [self.userDefaults setObject:uuid forKey:WD_UUID];
        }
    }
    return _uuid;
}

//客户端类型
- (NSString *)clientType {
    if (!_clientType) {
        NSString *clientType = [self.userDefaults stringForKey:WD_CLIENT_TYPE];
        if (clientType) {
            _clientType = clientType;
        }else{
            [self.userDefaults setObject:DefaultClientName forKey:WD_CLIENT_TYPE];
            _clientType = DefaultClientType;
        }
    }
    return _clientType;
}

//ua
- (NSString *)ua {
    if (!_ua) {
        NSString *ua = [self.userDefaults stringForKey:WD_UA];
        if (ua) {
            _ua = ua;
        }else{
            ua = [self getUserAgent];
            _ua = ua;
            [self.userDefaults setObject:ua forKey:WD_UA];
        }
    }
    return _ua;
}

//系统
- (NSString *)system {
    if (!_system) {
        NSString *sys = [self.userDefaults stringForKey:WD_SYSTEM];
        if (sys) {
            _system = sys;
        }else{
            sys = [UIDevice currentDevice].systemName;
            _system = sys;
            [self.userDefaults setObject:sys forKey:WD_SYSTEM];
        }
    }
    return _system;
}

//渠道号
- (NSString *)channel {
    if (!_channel) {
        NSString *ch = [self.userDefaults stringForKey:WD_CHANNEL];
        if (ch) {
            _channel = ch;
        }else{
            [self.userDefaults setObject:DefaultChannel forKey:WD_CHANNEL];
            _channel = DefaultChannel;
        }
    }
    return _channel;
}

//分辨率
- (NSString *)resolution {
    if (!_resolution) {
        NSString *re = [self.userDefaults stringForKey:WD_RESOLUTION];
        if (re) {
            _resolution = re;
        }else{
            re = [self getResolution];
            _resolution = re;
            [self.userDefaults setObject:re forKey:WD_RESOLUTION];
        }
    }
    return _resolution;
}

//cp
- (NSString *)cpId {
    if (!_cpId) {
        NSString *cp = [self.userDefaults stringForKey:WD_CP_ID];
        if (cp) {
            _cpId = cp;
        }else{
            [self.userDefaults setObject:DefaultCp forKey:WD_CP_ID];
            _cpId = DefaultCp;
        }
    }
    return _cpId;
}

//版本号
- (NSString *)version {
    if (!_version) {
        NSString *vs = [self.userDefaults stringForKey:WD_VERSION];
        if (vs) {
            _version = vs;
        }else{
            vs = [self getVersion];
            _version = vs;
            [self.userDefaults setObject:vs forKey:WD_VERSION];
        }
    }
    return _version;
}

- (NSString *)saltKey {
    return DefaultSaltKey;
}
#pragma mark - 获取参数
//获取OpenUDID
- (NSString*)getOpenUDID {
    return [OpenUDID value];
}

//获取ua
-(NSString *)getUserAgent {
    _webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.eoe.cn"]]];
    while (userAgent == nil) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    return userAgent;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (webView == _webView) {
        userAgent = [request valueForHTTPHeaderField:@"User-Agent"];
        return NO;
    }
    return YES;
}

//获取分辨率
- (NSString *)getResolution{
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    NSString *wdresolution1 = [NSString stringWithFormat:@"%g", [UIScreen mainScreen].bounds.size.width*scale_screen];
    NSString *wdresolution2 = [NSString stringWithFormat:@"%g", [UIScreen mainScreen].bounds.size.height*scale_screen];
    NSString *wdresolution = [wdresolution1 stringByAppendingString:@"*"];
    return [wdresolution stringByAppendingString:wdresolution2];
}

//获取版本号
- (NSString *)getVersion {
    NSDictionary *infoDictionary =[[NSBundle mainBundle]infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}
@end
