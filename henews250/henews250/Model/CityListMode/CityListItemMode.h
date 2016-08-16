//
//  CityListItemMode.h
//  henews250
//
//  Created by 汪洋 on 16/8/12.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"

@interface CityListItemMode : BaseMode

@property (nonatomic, copy)NSString *letter;
@property (nonatomic, copy)NSString *provinceName;
@property (strong, nonatomic) NSArray *cities;

@end
