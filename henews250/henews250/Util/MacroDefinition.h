//
//  MacroDefinition.h
//  henews250
//
//  Created by 汪洋 on 16/7/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#ifndef MacroDefinition_h
#define MacroDefinition_h

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
#define iPhone4LaunchImage (@"LaunchImage-700")
#define iPhone5LaunchImage (@"LaunchImage-700-568h")
#define iPhone6LaunchImage (@"LaunchImage-800-667h")
#define iPhone6pLaunchImage (@"LaunchImage-800-Portrait-736h")

#pragma mark - NSString key
#define isNotFirstOpenKey (@"isNotFirstOpen")

#pragma mark - NSString value
#define isNotFirstOpenValue (@"1")


#endif /* MacroDefinition_h */
