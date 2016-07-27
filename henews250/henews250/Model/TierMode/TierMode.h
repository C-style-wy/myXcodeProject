//
//  TierMode.h
//  henews250
//
//  Created by 汪洋 on 16/7/26.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"

@interface TierMode : BaseMode

@property (nonatomic, copy) NSString *nodeId;
@property (nonatomic, copy) NSString *nodeName;
@property (nonatomic, copy) NSString *isMore;
@property (nonatomic, copy) NSString *flag;
@property (nonatomic, copy) NSString *isHot;
@property (nonatomic, copy) NSString *isCity;
@property (nonatomic, copy) NSString *showAllTime;
@property (nonatomic, copy) NSString *url;

- (id)initWithData:(id)data;
@end
