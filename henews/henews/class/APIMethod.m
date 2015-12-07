//
//  APIMethod.m
//  henews
//
//  Created by 汪洋 on 15/12/7.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "APIMethod.h"

@implementation APIMethod

+(BOOL) greaterThanLine:(NSInteger)lineNum labelObject:(UILabel*)label content:(NSString *)contentStr{
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:label.frame];
    tempLabel.font = label.font;
//    tempLabel.lineBreakMode = UILineBreakModeWordWrap;
    
    tempLabel.numberOfLines = lineNum;
    tempLabel.text = contentStr;
    
    UIFont *fnt = label.font;
    NSDictionary *attribute = @{NSFontAttributeName: fnt};
    CGFloat height2 = TEXTHEIGHT(contentStr, attribute, label.frame.size.width);
    
    CGFloat height1 = tempLabel.frame.size.height;
    
    NSLog(@"height1=%f", height1);
    NSLog(@"height2=%f", height2);
    
    if (height2>height1) {
        return YES;
    }else{
        return NO;
    }
}

@end
