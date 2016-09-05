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
#import "HomeWeatherCell.h"

//新闻展示样式
#define OneBigPicNews       1     //单张大图
#define ThreeSmallPicNews   3     //三张小图
#define EveryOneNews        5     //大家
#define SensibilityNews     6     //感性
#define OneSmallPicNews     11    //一张小图在左边（普通新闻）
#define OneMiddPicNews      22    //一张中图

//模块样式
#define WeatherMode         16    //天气模块
#define EditorRecommend     12    //普通模块类型

@interface NewsCellFactory : NSObject

+ (BaseCell*)getCell:(NodeMode *)modul row:(NSInteger)row tableView:(UITableView *)tableView hiddenLine:(BOOL)hidden isShortLine:(BOOL)isShort;

+ (CGFloat)getHeightForRow:(NodeMode *)modul row:(NSInteger)row;

+ (NSInteger)getNumberOfRowsInSection:(NodeMode *)modul;

@end
