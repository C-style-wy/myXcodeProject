//
//  picDetailData.h
//  henews
//
//  Created by 汪洋 on 15/12/14.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface picDetailData : NSObject

@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *tags;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;

-(void)initWithData:(id)data;
@end
