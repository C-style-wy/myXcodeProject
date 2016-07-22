//
//  BannerMode.h
//  henews250
//
//  Created by 汪洋 on 16/7/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface BannerMode : NSObject

@property (nonatomic, copy)NSString *nodeId;
@property (nonatomic, copy)NSString *newsTitle;
@property (nonatomic, copy)NSString *newsType;
@property (nonatomic, copy)NSString *duration;
@property (nonatomic, copy)NSString *pubTime;
@property (nonatomic, copy)NSString *imageUrl;
@property (nonatomic, copy)NSString *url;
@property (strong, nonatomic) NSArray *newsTags;

@end
