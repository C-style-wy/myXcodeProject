//
//  LoadingMode.h
//  henews250
//
//  Created by 汪洋 on 16/7/15.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdMode.h"
#import "SingleColMode.h"
#import "MJExtension.h"

@interface LoadingMode : NSObject

@property (copy, nonatomic) NSString *loading_nodeId;
@property (copy, nonatomic) NSString *custom_city_nodeId;
@property (copy, nonatomic) NSString *adapt_city_root_nodeid;
//广告
@property (strong, nonatomic) AdMode *adInfo;

@property (copy, nonatomic) NSString *mySubscribesUrl;
@property (copy, nonatomic) NSString *goodSubscribesUrl;
//资讯栏目
@property (strong, nonatomic) NSArray *hNewsNodes;
//视界栏目
@property (strong, nonatomic) NSArray *videoNodes;

@property (copy, nonatomic) NSString *version;
@property (copy, nonatomic) NSString *downloadUrl;
@property (copy, nonatomic) NSString *flag;
@property (copy, nonatomic) NSString *resultMsg;
@property (copy, nonatomic) NSString *commonLuaMD5;
@property (copy, nonatomic) NSString *isSmsLogin;
@property (copy, nonatomic) NSString *chinaMobile;
@property (copy, nonatomic) NSString *chinaNet;
@property (copy, nonatomic) NSString *chinaUnicom;
@property (copy, nonatomic) NSString *resultCode;
@property (copy, nonatomic) NSString *defaultCity;
@property (copy, nonatomic) NSString *province;
@property (copy, nonatomic) NSString *isCustom;
@end
