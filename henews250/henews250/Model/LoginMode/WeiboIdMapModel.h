//
//  WeiboIdMapModel.h
//  henews250
//
//  Created by 汪洋 on 2016/10/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"

@interface WeiboIdMapModel : BaseMode

@property (nonatomic, strong) NSString * tENCENT;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
