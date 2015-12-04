//
//  AdviceData.h
//  henews
//
//  Created by 汪洋 on 15/12/2.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdviceData : NSObject

@property(nonatomic, retain) NSString *pic;
@property(nonatomic, retain) NSString *startTime;
@property(nonatomic, retain) NSString *endTime;
@property(nonatomic, retain) NSString *displayTime;

-(void)initWithData:(NSString*)pic start:(NSString*)sTime end:(NSString*)eTime showTime:(NSString*)time;

@end
