//
//  MacroDefinition.h
//  henews250
//
//  Created by 汪洋 on 16/7/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//
#import "UIColor+hexColor.h"


#ifndef MacroDefinition_h
#define MacroDefinition_h

#pragma mark - PI
#define PI (3.14159265358979323846264338327950288)
#define NullString (@"")

#define DeviceVersionFloat      ([[[UIDevice currentDevice]systemVersion]floatValue])
// 是否大于等于IOS7
#define isIOS7                  ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
// 是否IOS6
#define isIOS6                  ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0)
// 是否大于等于IOS8
#define isIOS8                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=8.0)
// 是否大于IOS9
#define isIOS9                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=9.0)
// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#pragma mark - 手机宽高
#define SCREEN_FRAME ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#pragma mark - iphone 手机型号
#define isIPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)

#define isIPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

typedef enum _iPhoneType {
    iPhone4 = 0,
    iPhone5,
    iPhone6,
    iPhone6p
}iPhoneType;

#pragma mark - 各个手机型号的启动图
#define iPhone4LaunchImage       (@"LaunchImage-700")
#define iPhone5LaunchImage       (@"LaunchImage-700-568h")
#define iPhone6LaunchImage       (@"LaunchImage-800-667h")
#define iPhone6pLaunchImage      (@"LaunchImage-800-Portrait-736h")

#pragma mark - NSString key
#define isNotFirstOpenKey        (@"isNotFirstOpen")
#define WD_CLIENTNAME            (@"clientName")
#define WD_UUID                  (@"WD_UUID")
#define WD_CLIENT_TYPE           (@"WD_CLIENT_TYPE")
#define WD_UA                    (@"WD_UA")
#define WD_SYSTEM                (@"WD_SYSTEM")
#define WD_CHANNEL               (@"WD_CHANNEL")
#define WD_RESOLUTION            (@"WD_RESOLUTION")
#define WD_CP_ID                 (@"WD_CP_ID")
#define WD_VERSION               (@"WD_VERSION")
#define WD_ENCRYPT               (@"encrypt")

#pragma mark - NSString value
// 自定义高效率的 NSLog
#ifdef DEBUG
#define LRLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define LRLog(...)
#endif

#ifdef DEBUG
#define LRString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent

#define Log(...) printf("%s 第%d行: %s\n", [LRString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else
#define Log(...)
#endif

// 设置随机颜色
#define LRRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

// clear背景颜色
#define LRClearColor [UIColor clearColor]

#define ReadColor [UIColor colorWithHexColor:@"#999999"]

#define MainColor ([UIColor colorWithHexColor:@"#e40177"])

#define TEXTWIDTH(str, attribute, h) ([(str) boundingRectWithSize:CGSizeMake(MAXFLOAT, (h)) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.width)

#define TEXTHEIGHT(str, attribute, w) ([(str) boundingRectWithSize:CGSizeMake(w, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.height)



#define DegreeCelsius (@"℃")


static CGFloat const headerHeight = 53.0f;
#endif /* MacroDefinition_h */
