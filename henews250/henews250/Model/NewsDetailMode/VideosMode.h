//
//  VideosMode.h
//  henews250
//
//  Created by 汪洋 on 2016/11/1.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"

@interface VideosMode : BaseMode

@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, strong) NSString * tags;
@property (nonatomic, strong) NSString * duration;
@property (nonatomic, strong) NSString * videoCode;

@end
