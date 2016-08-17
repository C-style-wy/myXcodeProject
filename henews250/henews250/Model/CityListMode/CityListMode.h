//
//  CityListMode.h
//  henews250
//
//  Created by 汪洋 on 16/8/12.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "CityListItemMode.h"

@interface CityListMode : BaseMode

@property (nonatomic, copy)NSString *resultCode;
@property (nonatomic, copy)NSString *resultMsg;
@property (strong, nonatomic) NSMutableArray *cityList;

@end
