//
//  ChannelMode.h
//  henews250
//
//  Created by 汪洋 on 16/7/25.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface ChannelMode : NSObject

@property (nonatomic, copy)NSString *nodeId;
@property (nonatomic, copy)NSString *isUGCType;
@property (nonatomic, copy)NSString *isHot;
@property (nonatomic, copy)NSString *isCurrent;
@property (nonatomic, copy)NSString *channelType;
@property (nonatomic, copy)NSString *linkNodeId;
@property (nonatomic, copy)NSString *url;
@property (strong, nonatomic) NSArray *banners;
@property (strong, nonatomic) NSArray *newsList;

@end
