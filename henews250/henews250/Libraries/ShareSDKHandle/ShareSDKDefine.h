//
//  ShareSDKDefine.h
//  henews250
//
//  Created by 汪洋 on 2016/10/16.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"

#ifndef ShareSDKDefine_h
#define ShareSDKDefine_h

/* shareSDK key */
#define shareSDKKey @"72cbf12ab685"

/*wechat*/
#define weixinKey @"wx4a1c1004bf1c9430"
#define weixinSecret @"dbd404edee06f2fb4562f99ff51f42ba"

/*qq key*/
#define QQConnectID @"1101346724"
#define QQConnectSecret @"zsTsNyQYdnI2diDI"

/* sinaWeiBo */
#define sinaWeiboKey @"2113182497"
#define sinaweiboSecret @"f2cb947a3b5227b946407fb8c2a0117d"
#define sinaWeiboUri   @"http://api.weibo.com/oauth2/default.html"

/**
 *  登录成功返回
 *
 *  @param SSDKUser 回调block
 */
typedef void (^LoginSuccessBlock)(SSDKUser *user);
/**
 *  失败返回
 *
 *  @param SSDKResponseState 回调block
 *  @param NSError
 */
typedef void (^LoginFailureBlock)(SSDKResponseState state, NSError *error);

#endif /* ShareSDKDefine_h */
