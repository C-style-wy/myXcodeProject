//
//  UIView+MYSnapshotView.m
//  henews250
//
//  Created by 汪洋 on 2016/10/20.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "UIView+MYSnapshotView.h"

@implementation UIView (MYSnapshotView)

- (UIView *)mySnapshotView {
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
        
        return [self snapshotViewAfterScreenUpdates:NO];
    }else{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0f);
        
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        return [[UIImageView alloc] initWithImage:image];
    }
}

@end
