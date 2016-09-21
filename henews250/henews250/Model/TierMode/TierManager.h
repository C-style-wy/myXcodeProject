//
//  TierManager.h
//  henews250
//
//  Created by 汪洋 on 16/9/20.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "LocalTierMode.h"
#import "TierMode.h"
#import "CityManager.h"


#pragma mark - 栏目标示
#define Home (@"home")
#define News (@"news")
#define View (@"view")

@interface TierManager : BaseMode

//返回单例
+ (TierManager*)shareInstance;

//比较本地栏目数据，并存储到本地(使用NSUserDefaults存储)
- (void)compareAndSave:(NSArray*)serverData key:(NSString*)key;

//读取本地栏目数据
- (LocalTierMode*)readLocadTier:(NSString*)key;

//保存栏目到本地
- (void)saveData:(LocalTierMode*)mode Key:(NSString*)key;

//读取订阅栏目
- (NSMutableArray*)getOrderTierFromLocal:(NSString*)key;

//读取非订阅栏目
- (NSMutableArray*)getNotOrderTierFromLocal:(NSString*)key;

//保存订阅栏目到本地
- (void)saveOrderTierToLocal:(NSMutableArray*)orderTier Key:(NSString*)key;

//保存非订阅栏目到本地
- (void)saveNotOrderTierToLocal:(NSMutableArray*)notOrderTier Key:(NSString*)key;

//保存订阅和非订阅栏目到本地
- (void)saveOrderTierToLocal:(NSMutableArray*)orderTier notOrderTier:(NSMutableArray*)notOrderTier Key:(NSString*)key;
@end
