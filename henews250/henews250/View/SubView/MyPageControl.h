//
//  MyPageControl.h
//  henews250
//
//  Created by 汪洋 on 16/7/22.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+hexColor.h"

@interface MyPageControl : UIView

@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) float pointSize;
@property (nonatomic, assign) float currentPointSize;
@property (nonatomic, assign) float distanceOfPoint;
@property (nonatomic, retain) UIColor *currentPagePointColor;
@property (nonatomic, retain) UIColor *pagePointColor;


- (CGSize)sizeForNumberOfPages:(NSInteger)pages;

-(void)setNumberOfPages:(NSInteger)pages;
-(void)setCurrentPage:(NSInteger)page;

//-(void)setPointSize:(float)size;
@end
