//
//  SpecialNodeListModel.h
//  henews250
//
//  Created by 汪洋 on 2016/11/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "NewsMode.h"

@interface SpecialNodeListModel : BaseMode

@property (nonatomic, strong) NSString * isMore;
@property (nonatomic, strong) NSString * nodeId;
@property (nonatomic, strong) NSString * nodeName;
@property (nonatomic, strong) NSString * url;

@property (nonatomic, strong) NSArray * newsList;

@end
