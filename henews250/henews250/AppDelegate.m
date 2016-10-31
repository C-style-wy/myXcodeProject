//
//  AppDelegate.m
//  henews250
//
//  Created by 汪洋 on 16/7/4.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "AppDelegate.h"
#import "ShareSDKManager.h"
#import "MYPhoneParam.h"
#import "Dialog.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //在AppDelegate获取ua，在index页面会黑屏
    NSString *ua = [MYPhoneParam sharedInstance].ua;
    ua = nil;
    //第三方登录和分享注册
    [ShareSDKManager registerApp];    
    //地图定位初始化
    [MPLocationManager installMapSDK];
    //百度地图定位
    [[MPLocationManager shareInstance] startBMKLocationWithReg:^(BMKUserLocation *loction, NSError *error) {
        if (error) {
            NSLog(@"定位失败,失败原因：%@",error);
        }else {
            NSLog(@"定位信息：%f,%f",loction.location.coordinate.latitude,loction.location.coordinate.longitude);
            
            CLGeocoder *geocoder=[[CLGeocoder alloc]init];
            [geocoder reverseGeocodeLocation:loction.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                //处理手机语言 获得城市的名称（中文）
                NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
                NSString *currentLanguage = [userDefaultLanguages objectAtIndex:0];
                //如果不是中文 则强制先转成中文 获得后再转成默认语言
                if (![currentLanguage isEqualToString:@"zh-Hans"]&&![currentLanguage isEqualToString:@"zh-Hans-CN"]) {
                    //IOS9前后区分
                    if (isIOS9) {
                        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-Hans-CN", nil] forKey:@"AppleLanguages"];
                    }
                    else
                    {
                        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-Hans", nil] forKey:@"AppleLanguages"];
                    }
                }
                //转换地理信息
                if (placemarks.count>0) {
                    CLPlacemark *placemark=[placemarks objectAtIndex:0];
                    //获取城市
                    NSString *city = placemark.locality;
                    if (!city) {
                        //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                        city = placemark.administrativeArea;
                    }
                    NSLog(@"百度当前城市：[%@]",city);
                    NSLog(@"百度当前省份：[%@]",placemark.administrativeArea);
                    [[CityManager shareInstance] setCurrentCity:city province:placemark.administrativeArea];
                    // 城市名传出去后,立即 Device 语言 还原为默认的语言
                    [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
                }
            }];
        }
    }];
    
    if (DeviceVersionFloat >= 10.0) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center setDelegate:self];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert |
                                                UNAuthorizationOptionBadge |
                                                UNAuthorizationOptionSound)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (granted) {
                                      NSLog(@"success");
                                  } else {
                                      NSLog(@"failed");
                                  }
        }];
    } else if (DeviceVersionFloat >= 8.0) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert |
                                                                                                    UIUserNotificationTypeSound |
                                                                                                    UIUserNotificationTypeBadge) categories:nil]];
    }
//    else {
//        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                         UIRemoteNotificationTypeAlert |
//                                                         UIRemoteNotificationTypeSound)];
//    }
    [application registerForRemoteNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    
    //  Apns注册成功，该方法没有没有变化。
    
    //  通过JPUSH上传设备Token.
    NTLog(@"deviceToken=====%@", deviceToken);
    NSString *token =[[deviceToken description]stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NTLog(@"token=====%@", token);
    NSString *url = [DEF_GetSendPushTokenUrl stringByAppendingString:token];
    url = [url stringByAppendingString:@"&operateType=add"];
    [NetworkManager postRequestJsonWithURL:url params:nil cacheBlock:^(NSDictionary *returnJson) {
        
    } successBlock:^(NSDictionary *returnJson) {
        NTLog(@"resultMsg===%@", [returnJson objectForKey:@"resultMsg"]);
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

// App在前台的时候收到推送执行的回调方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    NTLog(@"===userInfo==%@", userInfo);
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"pushNotificationKey" object:nil userInfo:@{@"1":@"123"}];
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}

// App在后台的时候，点击推送信息，进入App后执行的 回调方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    NTLog(@"==后台=userInfo==%@", userInfo);
    self.pushData = userInfo;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
