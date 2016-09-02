//
//  NetworkDelegate.h
//  henews250
//
//  Created by 汪洋 on 16/8/29.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
@class NetworkItem;
/**
 *   AFN 请求封装的代理协议
 */
@protocol NetworkDelegate <NSObject>

@optional
/**
 *   请求结束
 *
 *   @param returnData 返回的数据
 */
//- (void)requestDidFinishLoading:(NSDictionary*)returnData;
- (void)requestDidFinishLoading:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger) msg isCacheReturn:(BOOL)flag;
/**
 *   请求失败
 *
 *   @param error 失败的 error
 */
- (void)requestdidFailWithError:(NSError*)error tag:(NSString *)tag msg:(NSInteger)msg;

/**
 *   网络请求项即将被移除掉
 *
 *   @param itme 网络请求项
 */
- (void)netWorkWillDealloc:(NetworkItem*)itme;

@end
