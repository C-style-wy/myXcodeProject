//
//  SubContentMode.h
//  henews250
//
//  Created by 汪洋 on 2016/11/1.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "ImageInfoMode.h"

@interface SubContentMode : BaseMode

@property (nonatomic, strong) NSString * content;

@property (strong, nonatomic) NSArray *imageInfoList;

@end
