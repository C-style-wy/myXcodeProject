//
//  ClassInfoMode.h
//  henews250
//
//  Created by 汪洋 on 16/9/27.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "TierMode.h"

@interface ClassInfoMode : BaseMode

@property (nonatomic, retain) TierMode *tier;
//tableView当前位置(y值)
@property (nonatomic, assign) float curPosition;
//tableView需要加载的数据
@property (nonatomic, retain) NSMutableArray *loadData;
//加载更多的url
@property (nonatomic, assign) BOOL isLastPage;
@property (nonatomic, retain) NSString *loadingMoreUrl;

@property (nonatomic, assign) BOOL needReflush;
@end
