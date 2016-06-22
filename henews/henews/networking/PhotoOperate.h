//
//  PhotoOperate.h
//  henews
//
//  Created by 汪洋 on 16/4/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTTPRequestFinishedDelegate <NSObject>

@required
- (void)requestFinished:(NSDictionary *)dictionary tag:(NSInteger)tag;

@end

@interface PhotoOperate : NSObject
/*
 * 单例模式
 */
+ (id)sharePhotoOperate;
/*
 * 截图并且保存
 */
- (BOOL)screenshotAndSavePath:(NSString *) fileFullPath;
/*
 * 从指定路径上传图片到服务器
 */
- (BOOL)uploadPhotoWithDomain:(NSString *)domain URI:(NSString *)uri fileFullPath:(NSString *) fileFullPath target:(id<HTTPRequestFinishedDelegate>)target;
/*
 * 从服务器下载图片并存入指定路径
 */
- (BOOL)downloadPhotoWithDomain:(NSString *)domain URI:(NSString *)uri fileFullPath:(NSString *)fileFullPath target:(id<HTTPRequestFinishedDelegate>)target;
/*
 * 从服务器下载图片并存入指定路径(URL方式)
 */
- (BOOL)downloadPhotoWithURL:(NSString *)url fileFullPath:(NSString *)fileFullPath target:(id<HTTPRequestFinishedDelegate>)target;
/*
 *  传入子目录名字和文件名，生成一个文件的全路径
 */
- (NSString *)productFileFullPathWithSubDirectory:(NSString *)subDir fileName:(NSString *) fileName;
@end
