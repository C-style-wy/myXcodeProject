//
//  ReadRecordManage.h
//  henews250
//
//  Created by 汪洋 on 2016/11/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadRecordManage : NSObject

+ (instancetype)shareInstance;

- (void)saveReadNewsWithId:(NSString *)newsId;
- (BOOL)isAlreadyReadWithId:(NSString *)newsId;

@end
