//
//  BannersData.h
//  henews
//
//  Created by 汪洋 on 15/11/18.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneBannerData.h"

@interface BannersData : NSObject

@property (nonatomic, retain)NSMutableArray *bannersAry;

@property (nonatomic, assign) float height;

-(void)initWithData:(NSArray*)data;

@end
