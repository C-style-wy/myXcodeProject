//
//  CommentListMode.h
//  henews250
//
//  Created by 汪洋 on 2016/12/20.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "CommentMode.h"

@interface CommentListMode : BaseMode

@property (nonatomic, strong) NSString * count;
@property (nonatomic, strong) NSString * isLastPage;
@property (nonatomic, strong) NSString * nextUrl;
@property (nonatomic, strong) NSString * resultCode;
@property (nonatomic, strong) NSString * resultMsg;

@property (nonatomic, strong) NSArray * hotCommentList;
@property (nonatomic, strong) NSArray * commentList;

@end
