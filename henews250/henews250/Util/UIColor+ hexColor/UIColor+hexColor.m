//
//  UIColor+hexColor.m
//  henews250
//
//  Created by 汪洋 on 16/7/13.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "UIColor+hexColor.h"

@implementation UIColor (hexColor)

+(UIColor *)colorWithHexColor:(NSString *)hexColor{
    
    NSRange range1 = [hexColor rangeOfString:@"#"];
    if (range1.length) {
        hexColor = [hexColor substringFromIndex:range1.location+1];
    }
    
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

@end
