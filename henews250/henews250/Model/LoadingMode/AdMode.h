//
//  AdMode.h
//  henews250
//
//  Created by 汪洋 on 16/7/15.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface AdMode : NSObject

@property (copy, nonatomic) NSString *contType;
@property (copy, nonatomic) NSString *nodeTab;
@property (copy, nonatomic) NSString *relationNodeId;
@property (copy, nonatomic) NSString *subscribeData;
@property (copy, nonatomic) NSString *pic;
@property (copy, nonatomic) NSString *picName;
@property (copy, nonatomic) NSString *fullScreen;
@property (copy, nonatomic) NSString *startTime;
@property (copy, nonatomic) NSString *endTime;
@property (copy, nonatomic) NSString *wrapUrl;
@property (copy, nonatomic) NSString *displayTime;

@end
