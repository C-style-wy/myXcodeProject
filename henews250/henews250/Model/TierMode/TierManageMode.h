//
//  TierManageMode.h
//  henews250
//
//  Created by 汪洋 on 16/7/26.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "LocalTierMode.h"
#import "TierMode.h"

@interface TierManageMode : BaseMode

//比较本地栏目数据，并存储到本地(使用NSUserDefaults存储)
+ (void)compareAndSave:(NSArray*)serverData key:(NSString*)key;
//读取本地栏目数据
+ (LocalTierMode*)readLocadTier:(NSString*)key;
//保存栏目到本地
+ (void)saveData:(LocalTierMode*)mode Key:(NSString*)key;
@end
