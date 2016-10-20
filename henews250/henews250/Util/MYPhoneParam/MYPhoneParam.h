//
//  MYPhoneParam.h
//  henews250
//
//  Created by 汪洋 on 2016/10/19.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYPhoneParamDefine.h"
#import "OpenUDID.h"

@interface MYPhoneParam : UIView<UIWebViewDelegate>

@property (nonatomic, retain) NSUserDefaults *userDefaults;

@property (nonatomic, assign) BOOL isFirstOpen;
@property (nonatomic, retain) NSString *clientName;
@property (nonatomic, retain) NSString *uuid;
@property (nonatomic, retain) NSString *clientType;
@property (nonatomic, retain) NSString *ua;
@property (nonatomic, retain) NSString *system;
@property (nonatomic, retain) NSString *channel;
@property (nonatomic, retain) NSString *resolution;
@property (nonatomic, retain) NSString *cpId;
@property (nonatomic, retain) NSString *version;
@property (nonatomic, retain) NSString *saltKey;


//返回单例
+ (MYPhoneParam *)sharedInstance;

@end
