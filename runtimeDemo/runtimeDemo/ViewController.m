//
//  ViewController.m
//  runtimeDemo
//
//  Created by 汪洋 on 16/4/15.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (NSURLSession*)session{
    NSLog(@"session====");
    if (!_session) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
}
- (IBAction)startDown:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (self.task == nil) {
        if (self.resumeData) {
            [self resume];
        }else{
            [self start];
        }
    }else{
        [self pause];
    }
}

- (void)start{
    /**
     *开始下载的两个步骤
     */
    NSURL *url = [NSURL URLWithString:@"http://wap.cmread.com/newspush/apk/hxw230/heNews_M801004A.apk?type=up&channel=M801004A"];
    self.task = [self.session downloadTaskWithURL:url];
    [self.task resume];
}
/**
 *继续下载任务
 */
- (void)resume{
    /**
     *继续下载的三个步骤
     */
    self.task = [self.session downloadTaskWithResumeData:self.resumeData];
    [self.task resume];
    self.resumeData = nil;
}

- (void)pause{
    /**
     *强引用嵌套，将self进行弱引用
     */
    __weak typeof(self) weakSelf = self;
    [self.task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        weakSelf.resumeData = resumeData;
        weakSelf.task = nil;
    }];
}

#pragma mark - NSURLSessionDownLoadDelegate代理方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location{
    //1---拿到caches文件夹的路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //2---拿到caches文件夹和文件名
    NSString *file = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    NSFileManager *manager = [NSFileManager defaultManager];
    //3---移动下载好的文件到指定的文件夹
    [manager moveItemAtPath:location.path toPath:file error:nil];
    NSLog(@"location.path===%@", location.path);
    NSLog(@"file===%@", file);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    self.progressView.progress = (double)totalBytesWritten/totalBytesExpectedToWrite;
}

#pragma mark - 
//- (void)alerView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 1) {
//        self.progressView.progress = 0.0f;
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
