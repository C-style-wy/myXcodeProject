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


@interface BaseViewController : UIViewController<NetworkDelegate>


- (iPhoneType)returnIphoneType;
- (NSString*)getUserData:(NSString*)key;
- (void)setUserData:(NSString*)key value:(NSString*)value;
- (BOOL)earlierCurTimeWithTimeStr:(NSString*)timeStr;
- (BOOL)laterCurTimeWithTimeStr:(NSString*)timeStr;
- (NSString*)getCurSysTimeWithFormat:(NSString*)format;
@end
