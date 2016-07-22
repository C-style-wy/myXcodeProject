//
//  UILabel+NeedWidthAndHeight.h
//  henews250
//
//  Created by 汪洋 on 16/7/22.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TEXTWIDTH(str, attribute, h) ([(str) boundingRectWithSize:CGSizeMake(MAXFLOAT, (h)) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.width)

#define TEXTHEIGHT(str, attribute, w) ([(str) boundingRectWithSize:CGSizeMake(w, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.height)

@interface UILabel (NeedWidthAndHeight)

- (CGFloat)neetWidthWithText:(NSString*)text;

- (CGFloat)neetHeightWithText:(NSString*)text;

@end
