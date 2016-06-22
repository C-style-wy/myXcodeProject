//
//  ViewController.h
//  runtimeDemo
//
//  Created by 汪洋 on 16/4/15.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLSessionDownloadDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/**
 * 下载任务
 */
@property (nonatomic, strong)NSURLSessionDownloadTask *task;
/**
 * 记录上次暂停下载返回的纪录
 */
@property (nonatomic, strong)NSData *resumeData;
/**
 * 创建下载任务的属性
 */
@property (nonatomic, strong)NSURLSession *session;
@end

