//
//  CDPButton.m
//  henews
//
//  Created by 汪洋 on 16/3/25.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "CDPButton.h"

@implementation CDPButton{
    CGRect _imageRect;
    CGRect _titleRect;
}

-(instancetype)initWithFrame:(CGRect)frame imageRect:(CGRect)imageRect titleRect:(CGRect)titleRect{
    if (self=[super initWithFrame:frame]) {
        _imageRect=imageRect;
        _titleRect=titleRect;
    }
    return self;
}
//设置image的范围
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return _imageRect;
}
//设置title的范围
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return _titleRect;
}

@end
