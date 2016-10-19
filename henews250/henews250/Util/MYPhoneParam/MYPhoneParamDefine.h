//
//  MYPhoneParamDefine.h
//  henews250
//
//  Created by 汪洋 on 2016/10/19.
//  Copyright © 2016年 汪洋. All rights reserved.
//


#ifndef MYPhoneParamDefine_h
#define MYPhoneParamDefine_h
//城市
#define CityKey (@"city")
//是否首次打开和默认值
#define FirstOpenKey (@"isFirstOpen")
//客户端名
#define WD_CLIENTNAME            (@"clientName")
//openUdid
#define WD_UUID                  (@"WD_UUID")
//设备类型
#define WD_CLIENT_TYPE           (@"WD_CLIENT_TYPE")
//ua
#define WD_UA                    (@"WD_UA")
//系统
#define WD_SYSTEM                (@"WD_SYSTEM")
//渠道号
#define WD_CHANNEL               (@"WD_CHANNEL")
//分辨率
#define WD_RESOLUTION            (@"WD_RESOLUTION")
//cpId
#define WD_CP_ID                 (@"WD_CP_ID")
static NSString * const DefaultCp = @"000000";
//版本号
#define WD_VERSION               (@"WD_VERSION")
//鉴权key
#define SaltKey                  (@"salt")

#define WD_ENCRYPT               (@"encrypt")
#define LoginName                (@"loginName")
#define RealName                 (@"realName")
#define UserId                   (@"userId")
#define PlatForm                 (@"platForm")
#define AccountType              (@"accountType")

#pragma mark - 默认值
static NSString * const DefaultCity = @"北京";
//是否首次打开
static BOOL const DefaultFirstOpen = YES;
//客户端名
static NSString * const DefaultClientName = @"hxw";
//设备类型
static NSString * const DefaultClientType = @"03";
//渠道号
static NSString * const DefaultChannel = @"M201002";
//鉴权key
static NSString * const DefaultSaltKey = @"3d6809f2373db28c";

#endif /* MYPhoneParamDefine_h */
