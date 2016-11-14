//
//  CommentRelateMode.h
//  henews250
//
//  Created by 汪洋 on 2016/11/14.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "RelateCommentModel.h"

@interface CommentRelateMode : BaseMode

@property (nonatomic, strong) NSString * badTimes;
@property (nonatomic, strong) NSString * commentNum;
@property (nonatomic, strong) NSString * goodTimes;
@property (nonatomic, strong) NSString * isFavorited;
@property (nonatomic, strong) NSString * resultCode;
@property (nonatomic, strong) NSString * resultMsg;

@property (nonatomic, strong) NSArray * relateCommentList;

@end
