//
//  APIStringMacros.h
//  henews
//
//  Created by 汪洋 on 15/10/30.
//  Copyright © 2015年 汪洋. All rights reserved.
//
#import "UIColor+hexColor.h"

#ifndef APIStringMacros_h
#define APIStringMacros_h

//服务端主地址
#define GET_SERVER (@"http://wap.cmread.com/clt")
//index页loading地址
#define GET_INDEX_URL (@"/publish/clt/resource/portal/common/loading230.jsp?city=")
//home
#define GET_HOME_URL (@"/publish/clt/resource/portal/v230/home230.jsp?menu=shouye&city=")
//资讯页请求地址
#define GET_NEWS_URL (@"/publish/clt/resource/portal/v1/channelNav220.jsp?channelType=1&city=合肥")
//视界页请求地址
#define GET_VIEW_URL (@"/publish/clt/resource/portal/v1/channelNav220.jsp?channelType=2&city=合肥")

#pragma size
#define SCREEN_FRAME ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#pragma color
//页面背景色
#define VIEWBACKGROUND_COLOR [UIColor colorWithHexColor:@"#eeeeee"]
//和新闻主色调，玫红色
#define ROSERED [UIColor colorWithHexColor:@"#e40177"]
//页面标题字色值
#define VIEWTITLECOLOR [UIColor colorWithHexColor:@"#1e1e1e"]
//默认图背景色
#define DEFAULTCOLOR [UIColor colorWithHexColor:@"#dcdcdc"]

//#define HEX2RGB(string) [AppUtily hex2RGB:string]

#pragma textSize
//页面标题字体大小
#define VIEWTITLEFONT [UIFont systemFontOfSize:17.0f]
//新闻详情页，新闻标题大小
#define NEWS_TITLE_SIZE ([UIFont systemFontOfSize:17.5f])
//新闻内容字体大小
//#define NEWS_CONTENT_SIZE ([UIFont systemFontOfSize:17.0f])
#define NEWS_CONTENT_SIZE ([UIFont fontWithName:@"Helvetica" size:17])
//新闻内容的行间距
#define NEWS_CONTENT_DIS (0.0f)

//sizeWithFont已废弃，boundingRectWithSize代替
//#define TEXTWIDTH(str, fnt, h) ([(str) sizeWithFont:(fnt) constrainedToSize:CGSizeMake(MAXFLOAT, (h))]);
#define TEXTWIDTH(str, attribute, h) ([(str) boundingRectWithSize:CGSizeMake(MAXFLOAT, (h)) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.width)

#define TEXTHEIGHT(str, attribute, w) ([(str) boundingRectWithSize:CGSizeMake(w, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.height)


//新闻展示样式
//无图
#define ONLY_WORD (@"0")
//单张大图
#define ONE_BIG_PIC (@"1")
//单张小图在右边，现在不用了
#define ONE_SMALL_PIC_R (@"2")
//三张小图
#define THREE_SMALL_PIC (@"3")
//一张大图两张小图
#define ONEBIG_TWOSMALL_PIC (@"4")
//大家样式
#define EVERY_ONE (@"5")
//感性样式
#define EVERY_ONE_G (@"6")
//新闻早班车
#define NEWS_EARLY_BUS (@"7")
//一张小图
#define ONE_SMALL_PIC (@"11")

//模块样式
#define EditorRecommend (@"12")

#pragma mark - PI
#define PI (3.14159265358979323846264338327950288)

#pragma mark - 栏目存储名
#define NEWS_ORDER (@"newsOrder")
#define NEWS_NOT_ORDER (@"newsNotOrder")

#define VIEW_ORDER (@"viewOrder")
#define VIEW_NOT_ORDER (@"viewNotOrder")

#endif /* APIStringMacros_h */
