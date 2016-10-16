//
//  SubBaseViewController.h
//  henews250
//
//  Created by 汪洋 on 16/8/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseViewController.h"
#import "SubPageHeadView.h"
#import "CityManager.h"
#import "NetworkManager.h"
#import "UILabel+NeedWidthAndHeight.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

@interface SubBaseViewController : BaseViewController<SubPageHeadViewDelegate, NetworkDelegate>

@property (nonatomic, retain) SubPageHeadView *headView;

@property (nonatomic, retain) UILabel *pageTitle;
@property (nonatomic, retain) UIButton *pageShareBtn;

@property (nonatomic, retain) NSString *url;

- (void)initPage NS_REQUIRES_SUPER;
@end
