//
//  UILabel+NeedWidthAndHeight.m
//  henews250
//
//  Created by 汪洋 on 16/7/22.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "UILabel+NeedWidthAndHeight.h"

@implementation UILabel (NeedWidthAndHeight)

- (CGFloat)needWidthWithText:(NSString*)text{
    UIFont *fnt = self.font;
    NSDictionary *attribute = @{NSFontAttributeName: fnt};
    CGFloat width = TEXTWIDTH(text, attribute, self.frame.size.height);
    return width;
}

- (CGFloat)needHeightWithText:(NSString*)text{
    UIFont *fnt = self.font;
    NSDictionary *attribute = @{NSFontAttributeName: fnt};
    CGFloat height = TEXTHEIGHT(text, attribute, self.frame.size.width);
    return height;
}

@end
