//
//  MyPageControl.m
//  henews250
//
//  Created by 汪洋 on 16/7/22.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "MyPageControl.h"

@implementation MyPageControl

- (id)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.backgroundColor = [UIColor clearColor];
    self.pointSize = 4.0f;
    self.currentPointSize = 5.0f;
    self.distanceOfPoint = 8.0f;
    self.pagePointColor = [UIColor colorWithHexColor:@"#c8c8c8"];
    self.currentPagePointColor = [UIColor colorWithHexColor:@"#969696"];
    self.currentPage = 0;
    [self layoutIfNeeded];
}

-(CGSize)sizeForNumberOfPages:(NSInteger)pages{
    return CGSizeMake((_distanceOfPoint*(pages-1)+_pointSize*pages)+(_currentPointSize-_pointSize), _currentPointSize);
}

-(void)setNumberOfPages:(NSInteger)pages {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _numberOfPages = pages;
    for (int i = 0; i < _numberOfPages; i++) {
        UIView *pointView = [[UIView alloc]initWithFrame:CGRectMake((_distanceOfPoint+_pointSize)*i, (self.frame.size.height-_pointSize)/2, _pointSize, _pointSize)];
        
        pointView.backgroundColor = _pagePointColor;
        pointView.layer.cornerRadius = _pointSize/2;
        [self addSubview:pointView];
    }
}

-(void)setCurrentPage:(NSInteger)page {
//    if (_currentPage != page) {
        _currentPage = page;
        NSInteger countOfPages = [self.subviews count];
        
        for (NSUInteger subviewIndex = 0; subviewIndex < countOfPages; subviewIndex++) {
            UIView* subview = [self.subviews objectAtIndex:subviewIndex];
            if (subviewIndex == page) {
                subview.backgroundColor = _currentPagePointColor;
                subview.frame = CGRectMake(subview.frame.origin.x, (self.frame.size.height-_currentPointSize)/2, _currentPointSize, _currentPointSize);
                subview.layer.cornerRadius = _currentPointSize/2;
            }else{
                subview.backgroundColor = _pagePointColor;
                subview.frame = CGRectMake(subview.frame.origin.x, (self.frame.size.height-_pointSize)/2, _pointSize, _pointSize);
                subview.layer.cornerRadius = _pointSize/2;
            }
        }
//    }
}

//-(void)setPointSize:(float)size {
//    self.pointSize = size;
//}
@end
