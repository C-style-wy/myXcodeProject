//
//  NetworkUrl.h
//  henews250
//
//  Created by 汪洋 on 16/8/19.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#ifndef NetworkUrl_h
#define NetworkUrl_h

///**
// *  正式环境
// */
#define API_HOST @"http://wap.cmread.com/clt"

///**
// *   开发环境
// */
//#define API_HOST @"http://60.174.236.108:8091/clt"

//      接口路径全拼
#define PATH(_path)             [NSString stringWithFormat:_path, API_HOST]
/**
 *      启动页
 */
#define DEF_GetIndexpage         PATH(@"%@/publish/clt/resource/portal/common/loading230.jsp?city=")
/**
 *      首页
 */
#define DEF_GetHomepage         PATH(@"%@/publish/clt/resource/portal/v230/home230.jsp?menu=shouye&city=")
/**
 *      资讯
 */
#define DEF_GetNewspage         PATH(@"%@/publish/clt/resource/portal/v1/channelNav220.jsp?channelType=1&city=")
/**
 *      视界
 */
#define DEF_GetViewpage         PATH(@"%@/publish/clt/resource/portal/v1/channelNav220.jsp?channelType=2&city=")
/**
 *      福利
 */
#define DEF_GetWelfarepage         PATH(@"%@/publish/clt/resource/portal/v240/fuliList.jsp?menu=fuli")
/**
 *      城市选择页
 */
#define DEF_GetCitypage         PATH(@"%@/publish/clt/resource/portal/v2/cityLetter.jsp?city=")
/**
 *      天气接口
 */
#define DEF_GetWeatherurl         PATH(@"%@/publish/clt/resource/portal/v2/weatherInfo.jsp?city=")

/**
 *      第三方登录接口
 */
#define DEF_GetThirdPartyLoginUrl    PATH(@"%@/clt/societyFromSDK.msp?weiboType=")
/**
 *      普通登录接口
 */
#define DEF_GetLoginUrl    PATH(@"%@/clt/loginNew.msp?loginName=")
/**
 *      退出登录接口
 */
#define DEF_GetLogOutUrl    PATH(@"%@/clt/logout.msp")
/**
 *      一键登录接口
 */
#define DEF_GetOneKeyLoginUrl    PATH(@"%@/clt/loginWithMobile.msp?simsi=")
/**
 *      一键登录间隔时间接口
 */
#define DEF_GetOneKeyLoginTimeUrl    PATH(@"%@/clt/getTokenIdleTime.msp?")


#endif /* NetworkUrl_h */
