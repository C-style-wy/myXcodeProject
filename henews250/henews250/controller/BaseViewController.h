//
//  BaseViewController.h
//  henews250
//
//  Created by 汪洋 on 16/7/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MacroDefinition.h"
#import "NetworkManager.h"

#import "MJRefresh.h"
#import "HenewsRefreshHeader.h"

#import "UIImageView+WebCache.h"
#import "UIImageView+LoadFromWeb.h"
#import "UIView+SetAllSubViewHidden.h"
#import "UIColor+hexColor.h"
#import "TierManager.h"
#import "UIViewController+LoadFromStoryboard.h"

#import "CityManager.h"

#import "NetworkCache.h"

#import "MYPhoneParam.h"

#import "Dialog.h"

#import "UIView+Toast.h"

#import "AppDelegate.h"

#import "Masonry.h"

typedef enum {
    PushLinkTypeCommonnews = 1,    /**< 普通新闻 */
    PushLinkTypeVideo,             /**< 视频 */
    PushLinkTypeVideonews,         /**< 视频新闻 */
    PushLinkTypeTopic,             /**< 专题 */
    PushLinkTypePic,               /**< 图集 */
    PushLinkTypeWeb,               /**< 外链 二次请求 */
    PushLinkTypeActivity,          /**< 活动 */
    PushLinkTypeLive,              /**< 直播 */
    PushLinkTypeSystem,            /**< 系统消息 */
    PushLinkTypeCommentForMe,      /**< 评论我的 */
    PushLinkTypeOpenWeb,           /**< 外链 直接打开 */
    PushLinkTypePinkActivity,      /**< 活动类型 pink */
    PushLinkTypeMagazines,         /**< 杂志 */
    PushLinkTypePeriodical,        /**< 期刊 */
    PushLinkTypeCommentList        /**< 评论列表 */
}PushLinkType;

@interface BaseViewController : UIViewController<NetworkDelegate>

@property (nonatomic, assign) BOOL isViewVisable;

- (iPhoneType)returnIphoneType;
- (NSString*)getUserData:(NSString*)key;
- (void)setUserData:(NSString*)key value:(NSString*)value;
- (BOOL)earlierCurTimeWithTimeStr:(NSString*)timeStr;
- (BOOL)laterCurTimeWithTimeStr:(NSString*)timeStr;
- (NSString*)getCurSysTimeWithFormat:(NSString*)format;
@end
