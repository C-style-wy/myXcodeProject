//
//  HomeMode.h
//  henews250
//
//  Created by 汪洋 on 16/7/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface HomeMode : NSObject

@property (nonatomic, copy)NSString *indexNodeId;
@property (nonatomic, copy)NSString *adapterHomeType;
@property (nonatomic, copy)NSString *contIdStr;

@property (nonatomic, strong)NSArray *banners;
@property (nonatomic, strong)NSArray *nodes;

@end
