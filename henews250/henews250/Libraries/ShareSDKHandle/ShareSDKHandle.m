//
//  ShareSDKHandle.m
//  henews250
//
//  Created by 汪洋 on 2016/10/16.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "ShareSDKHandle.h"

@implementation ShareSDKHandle

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static ShareSDKHandle *handle;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [super allocWithZone:zone];
    });
    return handle;
}

//返回单例
+ (ShareSDKHandle *)sharedInstance{
    return [[super alloc]init];
}


//注册
- (void)registerApp {
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:shareSDKKey activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                                                            @(SSDKPlatformSubTypeWechatSession),
                                                            @(SSDKPlatformSubTypeWechatTimeline),
                                                            @(SSDKPlatformTypeQQ)] onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType) {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo){
         switch (platformType) {
             case SSDKPlatformTypeSinaWeibo:
                 [appInfo SSDKSetupSinaWeiboByAppKey:sinaWeiboKey
                                           appSecret:sinaweiboSecret
                                         redirectUri:sinaWeiboUri
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:weixinKey appSecret:weixinSecret];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:QQConnectID appKey:QQConnectSecret authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
}

//第三方登录
- (void)getUserInfoWithPlatform:(SSDKPlatformType)platform  success:(LoginSuccessBlock)success failure:(LoginFailureBlock)failure {
    
    [ShareSDK getUserInfo:platform
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
               if (state == SSDKResponseStateSuccess) {
                   NSLog(@"uid=%@",user.uid);
                   NSLog(@"%@",user.credential);
                   NSLog(@"token=%@",user.credential.token);
                   NSLog(@"nickname=%@",user.nickname);
                   [ShareSDK cancelAuthorize:platform];
                   if (success) {
                       success(user);
                   }
               } else {
                   if (failure) {
                       failure(state, error);
                   }
                   NSLog(@"%@",error);
               }
           }];
}

@end
