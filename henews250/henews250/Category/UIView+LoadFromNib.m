//
//  UIView+LoadFromNib.m
//  henews250
//
//  Created by 汪洋 on 16/7/7.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "UIView+LoadFromNib.h"

@implementation UIView (LoadFromNib)

+ (id)loadFromNib {
    NSString *xibName = NSStringFromClass([self class]);
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:xibName owner:self options:nil];
    return [nib objectAtIndex:0];
}

@end


