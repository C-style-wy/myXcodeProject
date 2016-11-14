//
//  RelateCommentModel.h
//  henews250
//
//  Created by 汪洋 on 2016/11/14.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"

@interface RelateCommentModel : BaseMode

@property (nonatomic, strong) NSString * addPraiseUrl;
@property (nonatomic, strong) NSString * contId;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * isEssence;
@property (nonatomic, strong) NSString * objectName;
@property (nonatomic, strong) NSString * pic;
@property (nonatomic, strong) NSString * praiseNum;
@property (nonatomic, strong) NSString * sName;
@property (nonatomic, assign) NSString * userDel;
@property (nonatomic, strong) NSString * userId;
@property (nonatomic, strong) NSString * userName;

@property (nonatomic, strong) NSArray * inheritCommentVo;

@end
