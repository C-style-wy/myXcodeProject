//
//  AppDelegate.h
//  henews250
//
//  Created by 汪洋 on 16/7/4.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPLocationManager.h"
#import "MacroDefinition.h"
#import "CityManager.h"
#import "OneKeyLoginMode.h"
#import <UserNotifications/UserNotifications.h>
#import "NetworkManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) OneKeyLoginMode *onekeyLogin;

@property (nonatomic, retain) NSDictionary *pushData;
@end

