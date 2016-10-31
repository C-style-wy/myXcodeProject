//
//  PushInfoMode.h
//  henews250
//
//  Created by 汪洋 on 2016/10/31.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "ApsModel.h"

@interface PushInfoMode : BaseMode

@property (nonatomic, strong) ApsModel * aps;
@property (nonatomic, strong) NSString * contId;
@property (nonatomic, strong) NSString * linkType;
@property (nonatomic, strong) NSString * msgId;

@end
