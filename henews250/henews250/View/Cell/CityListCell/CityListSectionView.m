//
//  CityListSectionView.m
//  henews250
//
//  Created by 汪洋 on 16/8/16.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "CityListSectionView.h"

@implementation CityListSectionView

- (id)initWithSectionName:(NSString *)sectionName {
    self = [super init];
    if (self) {
        self.letter.text = sectionName;
    }
    return self;
}

@end
