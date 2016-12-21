//
//  CommentListViewController.m
//  henews250
//
//  Created by 汪洋 on 2016/11/14.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "CommentListViewController.h"

static NSString * const CommentListTag = @"CommentListTag";

@interface CommentListViewController ()

@end

@implementation CommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initPage {
    [super initPage];
    self.pageTitle.text = @"评论列表";
    self.headView.shareBtn.hidden = YES;
    
    
    
    [NetworkManager postRequestJsonWithURL:self.url params:nil delegate:self tag:CommentListTag msg:0 useCache:YES update:YES showHUD:NO];
}

#pragma mark - 网络返回
- (void)requestDidFinishLoading:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg{
    if ([tag isEqualToString:CommentListTag]) {
        self.commentList = [CommentListMode mj_objectWithKeyValues:returnJson];
        CommentMode *testMode = [self.commentList.hotCommentList objectAtIndex:0];
        NSLog(@"hotCommentList====%@", testMode.objectName);
        
    }
}

//缓存数据返回
- (void)requestDidCacheReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger) msg {
    
}

- (void)requestdidFailWithError:(NSError*)error tag:(NSString *)tag msg:(NSInteger)msg {
    
}

@end
