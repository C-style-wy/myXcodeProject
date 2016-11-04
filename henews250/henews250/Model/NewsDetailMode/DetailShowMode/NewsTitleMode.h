//
//  NewsTitleMode.h
//  henews250
//
//  Created by 汪洋 on 2016/11/4.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "NewsDetailMode.h"

@interface NewsTitleMode : BaseMode

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * source;
@property (nonatomic, strong) NSString * pubTime;

- (NewsTitleMode *)initWithData:(NewsDetailMode *)data;

@end
