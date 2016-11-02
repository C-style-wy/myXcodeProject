//
//  ImageInfoMode.h
//  henews250
//
//  Created by 汪洋 on 2016/11/1.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"

@interface ImageInfoMode : BaseMode

@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, strong) NSString * tags;
@property (nonatomic, strong) NSString * width;
@property (nonatomic, strong) NSString * height;
@property (nonatomic, strong) NSString * videoUrl;
@property (nonatomic, strong) NSString * contenttype;
@property (nonatomic, strong) NSString * contentid;
@property (nonatomic, strong) NSString * columnid;
@property (nonatomic, strong) NSString * isneedlogin;
@property (nonatomic, strong) NSString * outerurl;

@end
