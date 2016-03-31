//
//  BannersData.m
//  henews
//
//  Created by 汪洋 on 15/11/18.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "BannersData.h"

@implementation BannersData

-(id)init{
    self = [super init];
    if (self) {
        _bannersAry = [[NSMutableArray alloc]init];
        _height = 196.0f;
    }
    return self;
}

-(void)initWithData:(NSArray*)data{
    if (data && [data count] > 0) {
        for (int i = 0; i < [data count]; i++) {
            OneBannerData *oneBanner = [[OneBannerData alloc]init];
            [oneBanner initWithData:[data objectAtIndex:i]];
            if (![oneBanner.imageUrl isEqual:@""]) {
                [_bannersAry addObject:oneBanner];
            }
        }
    }
}

@end
