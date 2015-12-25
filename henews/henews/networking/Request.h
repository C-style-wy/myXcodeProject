//
//  Request.h
//  henews
//
//  Created by 汪洋 on 15/10/29.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIStringMacros.h"
#import "MD5.h"

@protocol RequestDelegate<NSObject>

@required
-(void)requestDidReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger) msg isCacheReturn:(BOOL)flag;

@end

@interface Request : NSObject{
    
}


+(void)requestPostForJSON:(NSString*)tag url:(NSString*)urlString delegate:(id)delegate paras:(NSDictionary*)paras msg:(NSInteger)msg useCache:(BOOL)use;

@end
