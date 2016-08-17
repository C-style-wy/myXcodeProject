//
//  CityMode.h
//  henews250
//
//  Created by 汪洋 on 16/8/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"

@interface CityMode : BaseMode

@property (nonatomic, copy)NSString *currentCity;
@property (nonatomic, copy)NSString *localCity;
@property (nonatomic, copy)NSString *choceCity;

@property (nonatomic, copy)NSString *currentProvince;

@property (strong, nonatomic) NSMutableArray *choceCityAry;


- (void)setCurrentCity:(NSString*)curCity province:(NSString*)curProvince;
- (NSString*)getCity;
- (NSString*)getLocalCity;
- (NSString*)getProvince;
- (NSMutableArray*)getChoceCityAry;

- (void)addChoseCity:(NSString*)choceCity;

- (void)write2UserData;
@end
