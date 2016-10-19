//
//  CityMode.m
//  henews250
//
//  Created by 汪洋 on 16/8/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "CityMode.h"
#import "MYPhoneParam.h"

@implementation CityMode

- (id)init{
    self = [super init];
    if (self) {
        self.currentCity = DefaultCity;
        self.currentProvince = DefaultCity;
        self.localCity = DefaultCity;
        self.choceCityAry = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)setCurrentCity:(NSString*)curCity province:(NSString*)curProvince {
    self.currentCity = [self getSubString:curCity];
    self.currentProvince = [self getSubString:curProvince];
    [self write2UserData];
}

- (NSString*)getCity {
    if (_currentCity && ![_currentCity isEqualToString:@""]
        && ![_currentCity isEqualToString:_localCity]) {
        _localCity = _currentCity;
        [self write2UserData];
        return _currentCity;
    }else{
        if (_choceCity && ![_choceCity isEqualToString:@""]) {
            return _choceCity;
        }else{
            return _localCity;
        }
    }
}

- (NSString*)getLocalCity {
    return _localCity;
}

- (NSString*)getProvince {
    return _currentProvince;
}

- (NSMutableArray*)getChoceCityAry {
    return _choceCityAry;
}

- (void)addChoseCity:(NSString*)choceCity {
    self.choceCity = choceCity;
    BOOL have = NO;
    for (int i=0; i<_choceCityAry.count; i++) {
        if ([choceCity isEqualToString:[_choceCityAry objectAtIndex:i]]) {
            have = YES;
        }
    }
    if (![_localCity isEqualToString:choceCity] && !have) {
        if (!_choceCityAry) {
            _choceCityAry = [[NSMutableArray alloc]init];
        }
        if (_choceCityAry && _choceCityAry.count == 3) {
            [_choceCityAry removeObjectAtIndex:2];
        }
        [_choceCityAry insertObject:choceCity atIndex:0];
    }
    [self write2UserData];
}

- (void)write2UserData {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *tokenObject = [NSKeyedArchiver archivedDataWithRootObject:self];
    [userDefaults setObject:tokenObject forKey:CityKey];
    [userDefaults synchronize];
}

- (NSString*)getSubString:(NSString*)str {
    if ([str rangeOfString:@"省"].location != NSNotFound) {
        str = [str stringByReplacingOccurrencesOfString:@"省" withString:@""];
    }
    if ([str rangeOfString:@"市"].location != NSNotFound) {
        str = [str stringByReplacingOccurrencesOfString:@"市" withString:@""];
    }
    if ([str rangeOfString:@"县"].location != NSNotFound) {
        str = [str stringByReplacingOccurrencesOfString:@"县" withString:@""];
    }
    if ([str rangeOfString:@"区"].location != NSNotFound) {
        str = [str stringByReplacingOccurrencesOfString:@"区" withString:@""];
    }
    return str;
}

@end
