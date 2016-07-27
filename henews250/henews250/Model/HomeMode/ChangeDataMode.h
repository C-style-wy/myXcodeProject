//
//  ChangeDataMode.h
//  henews250
//
//  Created by 汪洋 on 16/7/25.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface ChangeDataMode : NSObject

@property (nonatomic, copy)NSString *nodeid;
@property (nonatomic, copy)NSString *page;
@property (nonatomic, copy)NSString *displayType;
@property (nonatomic, copy)NSString *changeUrl;

@property (strong, nonatomic) NSArray *banners;
@property (strong, nonatomic) NSArray *newsList;
@property (strong, nonatomic) NSArray *channelNav;

@end
