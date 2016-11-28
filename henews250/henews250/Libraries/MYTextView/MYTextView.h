//
//  MYTextView.h
//  henews250
//
//  Created by 汪洋 on 2016/11/25.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RechTextRegex.h"

@interface MYTextView : UITextView

@property(nonatomic,assign) CGFloat characterSpacing;
@property(nonatomic,assign) CGFloat paragraphSpacing;
@property(nonatomic,assign) long    linesSpacing;

@property(nonatomic,strong) NSMutableAttributedString *attributedString;
/*
 *绘制前获取label高度
 */
- (int)getAttributedStringHeightWidthValue:(int)width;

- (void) initAttributedString;

@end
