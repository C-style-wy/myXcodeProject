//
//  Request.h
//  henews250
//
//  Created by 汪洋 on 16/7/12.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
#import "MD5.h"

@protocol RequestDelegate <NSObject>

@required
- (void)requestDidReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg isCacheReturn:(BOOL)flag;

@end

@interface Request : NSObject

+(void)requestPostForJSON:(NSString*)tag url:(NSString*)urlString delegate:(id)delegate paras:(NSDictionary*)paras msg:(NSInteger)msg useCache:(BOOL)use;

+(void)requestPostForJSON:(NSString*)tag url:(NSString*)urlString delegate:(id)delegate paras:(NSDictionary*)paras msg:(NSInteger)msg useCache:(BOOL)use update:(BOOL)update;

@end
