//
//  NetworkUrl.h
//  henews250
//
//  Created by 汪洋 on 16/8/19.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#ifndef NetworkUrl_h
#define NetworkUrl_h

/**
 *  正式环境
 */
#define API_HOST @"http://wap.cmread.com/clt"
#define API_PUSH_HOST @"http://wap.cmread.com/newspush"

/**
 *   开发环境
 */
//#define API_HOST @"http://60.174.236.108:8091/clt"
//#define API_PUSH_HOST @"http://60.174.236.108:8091/newspush"
/**
 *   测试环境
 */
//#define API_HOST @"http://211.140.7.174:8001/clt"
//#define API_PUSH_HOST @"http://211.140.7.174:8001/newspush"

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
/**
 *      推送token上报接口
 */
#define DEF_GetSendPushTokenUrl    PATH(@"%@/clt/operateApnUser.msp?token=")

/**
 *      普通新闻详情页接口
 */
#define DEF_GetCommonnewsUrl    PATH(@"%@/publish/clt/resource/portal/v1/commonNews.jsp?c=")
/**
 *      视频详情页接口
 */
#define DEF_GetVideoUrl    PATH(@"%@/publish/clt/resource/portal/v1/commonNews.jsp?c=")
/**
 *      视频新闻详情页接口
 */
#define DEF_GetVideonewsUrl    PATH(@"%@/publish/clt/resource/portal/v1/commonNews.jsp?c=")
/**
 *      专题接口
 */
#define DEF_GetTopicUrl    PATH(@"%@/publish/clt/resource/portal/v1/special.jsp?c=")
/**
 *      图集接口
 */
#define DEF_GetPicUrl    PATH(@"%@/publish/clt/resource/portal/v1/commonNews.jsp?c=")
/**
 *      外链(二次请求)接口
 */
#define DEF_GetWebUrl    PATH(@"%@/publish/clt/resource/portal/v1/commonNews.jsp?c=")
/**
 *      活动接口
 */
#define DEF_GetActivityUrl    PATH(@"%@/publish/clt/resource/portal/v1/ugcList.jsp?c=")
/**
 *      直播接口
 */
#define DEF_GetLiveUrl    PATH(@"%@/publish/clt/resource/portal/v1/liveNewsList.jsp?c=")
/**
 *      外链(直接打开)接口
 */
#define DEF_GetOpenWebUrl    PATH(@"%@/publish/clt/pzx/share/pushDetail/index.jsp?c=")
/**
 *      pink活动接口
 */
#define DEF_GetPinkActivityUrl    PATH(@"%@/publish/clt/resource/portal/v1/ugcList.jsp?c=")
/**
 *      杂志接口
 */
#define DEF_GetMagazinesUrl    PATH(@"%@/publish/clt/resource/portal/v240/magazinesDetail.jsp?c=")
/**
 *      期刊接口
 */
#define DEF_GetPeriodicalUrl    PATH(@"%@/publish/clt/resource/portal/v240/periodicalDetail.jsp?c=")
/**
 *      评论列表接口
 */
#define DEF_GetCommentListUrl    PATH(@"%@/publish/clt/resource/portal/v2/commentList.jsp?objectId=")
/**
 *      我的收藏接口
 */
#define DEF_GetMyCollectionUrl    PATH(@"%@/clt/getFavoriteList.msp?page=1&limit=10&isSynchronized=1")

#endif /* NetworkUrl_h */
