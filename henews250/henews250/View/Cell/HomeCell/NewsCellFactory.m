//
//  NewsCellFactory.m
//  henews250
//
//  Created by 汪洋 on 16/7/20.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NewsCellFactory.h"

#import "OnlyWordCell.h"
#import "OneSmallPicCell.h"
#import "EveryOneCell.h"
#import "ThreeSmallPicCell.h"
#import "OneBigPicCell.h"
#import "HomeWeatherCell.h"

@implementation NewsCellFactory
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static NewsCellFactory *_factory;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _factory = [super allocWithZone:zone];
    });
    return _factory;
}

//返回单例
+ (instancetype)shareInstance {
    return [[super alloc]init];
}


- (BaseCell*)getCell:(NodeMode *)modul row:(NSInteger)row tableView:(UITableView *)tableView hiddenLine:(BOOL)hidden isShortLine:(BOOL)isShort{
    if ([modul.displayType intValue] == WeatherMode) {
        HomeWeatherCell *cell = [HomeWeatherCell cellWithTableView:tableView];
        [cell setNews:hidden];
        return cell;
    }else{
        NewsMode *news = [modul.newsList objectAtIndex:row];
        return [self getCell:news tableView:tableView hiddenLine:hidden isShortLine:isShort];
    }
}

- (BaseCell*)getCell:(NewsMode*)news tableView:(UITableView *)tableView hiddenLine:(BOOL)hidden isShortLine:(BOOL)isShort {
    switch ([news.displayType intValue]) {
            //只含文字
        case OnlyWordNews:{
            OnlyWordCell *cell = [OnlyWordCell cellWithTableView:tableView];
            [cell setNews:news hiddenLine:hidden isShortLine:isShort];
            return cell;
            break;
        }
            //一张大图
        case OneBigPicNews:{
            OneBigPicCell *cell = [OneBigPicCell cellWithTableView:tableView];
            [cell setNews:news hiddenLine:hidden isShortLine:isShort];
            return cell;
            break;
        }
            //三张小图
        case ThreeSmallPicNews:{
            ThreeSmallPicCell *cell = [ThreeSmallPicCell cellWithTableView:tableView];
            [cell setNews:news hiddenLine:hidden isShortLine:isShort];
            return cell;
            break;
        }
            //大家
        case EveryOneNews:{
            EveryOneCell *cell = [EveryOneCell cellWithTableView:tableView];
            [cell setNews:news hiddenLine:hidden isShortLine:isShort];
            return cell;
            break;
        }
            //感性
        case SensibilityNews:{
            EveryOneCell *cell = [EveryOneCell cellWithTableView:tableView];
            [cell setNews:news hiddenLine:hidden isShortLine:isShort];
            return cell;
            break;
        }
            //左小图
        case OneSmallPicNews:{
            OneSmallPicCell *cell = [OneSmallPicCell cellWithTableView:tableView];
            [cell setNews:news hiddenLine:hidden isShortLine:isShort];
            return cell;
            break;
        }
            //中图
        case OneMiddPicNews:{
            OneBigPicCell *cell = [OneBigPicCell cellWithTableView:tableView];
            [cell setNews:news hiddenLine:hidden isShortLine:isShort];
            return cell;
            break;
        }
        default:{
            OneSmallPicCell *cell = [OneSmallPicCell cellWithTableView:tableView];
            [cell setNews:news hiddenLine:hidden isShortLine:isShort];
            return cell;
            break;
        }
    }
}

- (CGFloat)getHeightForRow:(NodeMode *)modul row:(NSInteger)row {
    if ([modul.displayType intValue] == WeatherMode) {
        return 160.0f;
    }else{
        NewsMode *news = [modul.newsList objectAtIndex:row];
        return [self getHeightForRow:news];
    }
}

- (CGFloat)getHeightForRow:(NewsMode*)news {
    switch ([news.displayType intValue]) {
            //只含文字
        case OnlyWordNews:{
            return SCREEN_WIDTH*80.0f/320.0f;
            break;
        }
            //一张大图
        case OneBigPicNews:{
            return SCREEN_WIDTH*218.0f/320.0f;
            break;
        }
            //三张小图
        case ThreeSmallPicNews:{
            return SCREEN_WIDTH*146.0f/320.0f;
            break;
        }
            //大家
        case EveryOneNews:{
            return SCREEN_WIDTH*98.0f/320.0f;
            break;
        }
            //感性
        case SensibilityNews:{
            return SCREEN_WIDTH*98.0f/320.0f;
            break;
        }
            //左小图
        case OneSmallPicNews:{
            return SCREEN_WIDTH*88.0f/320.0f;
            break;
        }
            //中图
        case OneMiddPicNews:{
            return SCREEN_WIDTH*171.0f/320.0f;
            break;
        }
        default:{
            return SCREEN_WIDTH*88.0f/320.0f;
            break;
        }
    }
}


- (NSInteger)getNumberOfRowsInSection:(NodeMode *)modul {
    if ([modul.displayType intValue] == WeatherMode) {
        return 1;
    }else{
        if (modul.newsList && modul.newsList.count > 0) {
            return modul.newsList.count;
        }else{
            return 0;
        }
    }
}

- (void)didSelectRowAtIndexPath:(NodeMode *)modul row:(NSInteger)row navigation:(UINavigationController *)navigation{
    if ([modul.displayType intValue] != WeatherMode) {
        NewsMode *news = [modul.newsList objectAtIndex:row];
        [self didSelectRowAtIndexPath:news navigation:navigation];
    }
}

- (void)goNewPageWithType:(int)newsType url:(NSString *)url param:(id)param navigation:(UINavigationController *)navigation {
    switch (newsType) {
            //0:文字
        case TypeNews:{
            NewsDetailViewController *newsDetail = [NewsDetailViewController loadFromStoryboard];
            newsDetail.url = url;
            [navigation pushViewController:newsDetail animated:YES];
            break;
        }
            //1:视频
        case TypeVideo:{
            VideoViewController *videoDetail = [VideoViewController loadFromStoryboard];
            videoDetail.url = url;
            [navigation pushViewController:videoDetail animated:YES];
            break;
        }
            //2:视频新闻
        case TypeVideoNews:{
            NewsDetailViewController *newsDetail = [NewsDetailViewController loadFromStoryboard];
            newsDetail.url = url;
            [navigation pushViewController:newsDetail animated:YES];
            break;
        }
            //3:专题
        case TypeTopic:{
            TopicViewController *topicDetail = [TopicViewController loadFromStoryboard];
            topicDetail.url = url;
            [navigation pushViewController:topicDetail animated:YES];
            break;
        }
            //4:图集
        case TypePic:{
            PicViewController *picDetail = [PicViewController loadFromStoryboard];
            picDetail.url = url;
            [navigation pushViewController:picDetail animated:YES];
            break;
        }
            //5:外链
        case TypeWeb:{
            WebViewController *webDetail = [WebViewController loadFromStoryboard];
            webDetail.url = url;
            [navigation pushViewController:webDetail animated:YES];
            break;
        }
            //6：活动
        case TypeActivity:{
            ActivityViewController *activityDetail = [ActivityViewController loadFromStoryboard];
            activityDetail.url = url;
            [navigation pushViewController:activityDetail animated:YES];
            break;
        }
            //7: 直播
        case TypeLive:{
            LiveViewController *liveDetail = [LiveViewController loadFromStoryboard];
            liveDetail.url = url;
            [navigation pushViewController:liveDetail animated:YES];
            break;
        }
            //8:文字
        case TypeNews8:{
            NewsDetailViewController *newsDetail = [NewsDetailViewController loadFromStoryboard];
            newsDetail.url = url;
            [navigation pushViewController:newsDetail animated:YES];
            break;
        }
            //9: 活动类型3pink
        case TypePinkActivity:{
            PinkactivityViewController *pinkDetail = [PinkactivityViewController loadFromStoryboard];
            pinkDetail.url = url;
            [navigation pushViewController:pinkDetail animated:YES];
            break;
        }
            //10: 杂志
        case TypeMagazine:{
            MagazineViewController *magazineDetail = [MagazineViewController loadFromStoryboard];
            magazineDetail.url = url;
            [navigation pushViewController:magazineDetail animated:YES];
            break;
        }
            //11: 期刊
        case TypePeriodical:{
            PeriodicalViewController *periodicalDetail = [PeriodicalViewController loadFromStoryboard];
            periodicalDetail.url = url;
            [navigation pushViewController:periodicalDetail animated:YES];
            break;
        }
            //12:栏目
        case TypeLanMu:{
            break;
        }
            //13:广告平台
        case TypeAd:{
            break;
        }
    }
}

- (void)didSelectRowAtIndexPath:(NewsMode*)news navigation:(UINavigationController *)navigation {
    [self goNewPageWithType:[news.newsType intValue] url:news.url param:nil navigation:navigation];
}
@end
