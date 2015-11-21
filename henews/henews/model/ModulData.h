//
//  ModulData.h
//  henews
//
//  Created by 汪洋 on 15/11/20.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellData.h"

@interface ModulData : NSObject

@property (nonatomic, retain) NSString *nodeId;
@property (nonatomic, retain) NSString *nodeName;


@property (nonatomic, retain) NSString *displayType;
@property (nonatomic, retain) NSString *changeUrl;

@property (nonatomic, retain) NSString *isMore;

@property (nonatomic, retain) NSString *linkNodeId;
@property (nonatomic, retain) NSString *channelType;

@property (nonatomic, retain) NSMutableArray *newsList;

-(void)initWithData:(id)data;
@end
