/*************************************
**  RICHUILabel.m
**  henews
**
**  Created by 汪洋 on 16/4/20.
*** Copyright © 2016年 汪洋. All rights reserved.
***/

#import "RICHUILabel.h"

@implementation RICHUILabel

- (id)init{
    //初始化字间距、行间距
    if(self =[super init]){
        _characterSpacing = 0.5f;
        _linesSpacing = 2.0f;
        _paragraphSpacing = 2.0f;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    //初始化字间距、行间距
    if(self =[super initWithFrame:frame]){
        _characterSpacing = 0.5f;
        _linesSpacing = 2.0f;
        _paragraphSpacing = 2.0f;
    }
    return self;
}

//外部调用设置字间距
-(void)setCharacterSpacing:(CGFloat)characterSpacing{
    NSLog(@"setCharacterSpacing===");
    _characterSpacing = characterSpacing;
    [self setNeedsDisplay];
}

/*
 *开始绘制
 */
- (void)drawTextInRect:(CGRect)requestedRect{
    NSLog(@"drawTextInRect====");
    [super drawTextInRect:requestedRect];
}

@end
