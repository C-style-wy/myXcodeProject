//
//  PhotoOperate.m
//  henews
//
//  Created by 汪洋 on 16/4/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//  http://www.jianshu.com/p/11bb0d4dc649
//  http://my.oschina.net/iOSliuhui/blog/469276
//

#import "PhotoOperate.h"
#import <UIKit/UIKit.h>
#import <CoreGraphics/CGImage.h>
#import "AFNetworking.h"
//#import "AFHTTPRequestOperation.h"

static PhotoOperate *mPhotoOperate = nil;
@implementation PhotoOperate
/*
 *  单例模式
 */
+ (id)sharePhotoOperate{
    @synchronized (self) {
        if (nil == mPhotoOperate) {
            mPhotoOperate = [[self alloc] init];
        }
    }
    return mPhotoOperate;
}
/*
 *  截图并且保存
 */
- (BOOL)screenshotAndSavePath:(NSString *)fileFullPath{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(640, 960), YES, 0);
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContext(window.frame.size);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc]initWithCGImage:imageRefRect];
    
    //保存为png格式
    //    NSData *imageViewData = UIImagePNGRepresentation(sendImage);
    //保存为jpeg格式(此种格式可以压缩)
    NSData *imageViewData = UIImageJPEGRepresentation(sendImage, 1.0);
    BOOL ret = [imageViewData writeToFile:fileFullPath atomically:YES];
    return ret;
}

/*
 * 上传图片到服务器
 */
- (BOOL)uploadPhotoWithDomain:(NSString *)domain URI:(NSString *)uri fileFullPath:(NSString *)fileFullPath target:(id<HTTPRequestFinishedDelegate>)target{
    
//    UIImage *image = [UIImage imageWithContentsOfFile:fileFullPath];
//    NSData *data = UIImageJPEGRepresentation(image, 1.0);
//    
//    NSURL *nsurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", domain]];
    
    return YES;
}
/*
 * 从服务器下载图片并存入指定路径
 */
- (BOOL)downloadPhotoWithDomain:(NSString *)domain URI:(NSString *)uri fileFullPath:(NSString *)fileFullPath target:(id<HTTPRequestFinishedDelegate>)target{
    return YES;
}
/*
 * 从服务器下载图片并存入指定路径(URL方式)
 */
- (BOOL)downloadPhotoWithURL:(NSString *)url fileFullPath:(NSString *)fileFullPath target:(id<HTTPRequestFinishedDelegate>)target{
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.确定请求的URL地址
    NSURL *downUrl = [NSURL URLWithString:url];
    //3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:downUrl];
    //下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL URLWithString:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
    }];
    //开始启动任务
    [task resume];
    return YES;
}
/*
 *  传入子目录名字和文件名，生成一个文件的全路径
 */
- (NSString *)productFileFullPathWithSubDirectory:(NSString *)subDir fileName:(NSString *) fileName{
    return @"ss";
}
@end
