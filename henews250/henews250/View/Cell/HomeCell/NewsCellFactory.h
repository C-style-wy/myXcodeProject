//
//  NewsCellFactory.h
//  henews250
//
//  Created by 汪洋 on 16/7/20.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacroDefinition.h"
#import "NewsMode.h"
#import "BaseCell.h"
#import "BannerCell.h"
#import "NodeMode.h"

//新闻展示样式
#define OnlyWordNews        0     //只含文字
#define OneBigPicNews       1     //单张大图
#define ThreeSmallPicNews   3     //三张小图
#define EveryOneNews        5     //大家
#define SensibilityNews     6     //感性
#define OneSmallPicNews     11    //一张小图在左边（普通新闻）
#define OneMiddPicNews      22    //一张中图

//模块样式
#define WeatherMode         16    //天气模块
#define EditorRecommend     12    //普通模块类型


//新闻类型
#define TypeNews                0    //0:文字
#define TypeVideo               1    //1:视频
#define TypeVideoNews           2    //2:视频新闻
#define TypeTopic               3    //3:专题
#define TypePic                 4    //4:图集
#define TypeWeb                 5    //5:外链
#define TypeActivity            6    //6：活动
#define TypeLive                7    //7: 直播
#define TypeNews8               8    //8:文字
#define TypePinkActivity        9    //9: 活动类型3pink
#define TypeMagazine            10   //10: 杂志
#define TypePeriodical          11   //11: 期刊
#define TypeLanMu               12   //12:栏目
#define TypeAd                  13   //13:广告平台

@interface NewsCellFactory : NSObject

+ (BaseCell*)getCell:(NodeMode *)modul row:(NSInteger)row tableView:(UITableView *)tableView hiddenLine:(BOOL)hidden isShortLine:(BOOL)isShort;

+ (CGFloat)getHeightForRow:(NodeMode *)modul row:(NSInteger)row;

+ (NSInteger)getNumberOfRowsInSection:(NodeMode *)modul;

+ (void)didSelectRowAtIndexPath:(NodeMode *)modul row:(NSInteger)row navigation:(UINavigationController *)navigation;
@end
