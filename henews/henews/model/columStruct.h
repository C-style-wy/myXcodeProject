//
//  columStruct.h
//  henews
//
//  Created by 汪洋 on 15/11/5.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface columStruct : NSObject<NSCoding>


@property (nonatomic, retain) NSString *nodeId;
@property (nonatomic, retain) NSString *nodeName;
@property (nonatomic, retain) NSString *isMore;
@property (nonatomic, retain) NSString *flag;
@property (nonatomic, retain) NSString *isHot;
@property (nonatomic, retain) NSString *isCity;
@property (nonatomic, retain) NSString *showAllTime;
@property (nonatomic, retain) NSString *url;

-(void)setData:(id)data;
@end
