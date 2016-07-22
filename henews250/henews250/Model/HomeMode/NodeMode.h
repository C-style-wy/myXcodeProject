//
//  NodeMode.h
//  henews250
//
//  Created by 汪洋 on 16/7/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface NodeMode : NSObject

@property (nonatomic, copy)NSString *nodeId;
@property (nonatomic, copy)NSString *isCity;
@property (nonatomic, copy)NSString *showAllTime;
@property (nonatomic, copy)NSString *nodeName;
@property (nonatomic, copy)NSString *selectNodeId;
@property (nonatomic, copy)NSString *orderimgPagesize;
@property (nonatomic, copy)NSString *orderimgDataobjid;
@property (nonatomic, copy)NSString *orderimgNodeId;
@property (nonatomic, copy)NSString *orderimgSuppleNodeId;
@property (nonatomic, copy)NSString *useLocalSourceNews;
@property (nonatomic, copy)NSString *homeCityNode;
@property (nonatomic, copy)NSString *isMore;
@property (nonatomic, copy)NSString *isHot;
@property (nonatomic, copy)NSString *linkNodeId;
@property (nonatomic, copy)NSString *channelType;
@property (nonatomic, copy)NSString *suppleFlagNodeId;
@property (nonatomic, copy)NSString *displayType;
@property (nonatomic, copy)NSString *changeUrl;
@property (nonatomic, copy)NSString *url;

//@property (nonatomic, strong) NSArray *selectData;
//@property (nonatomic, strong) NSArray *channelNav;
@property (nonatomic, strong) NSArray *newsList;
@end
