//
//  UIImageView+LoadFromWeb.m
//  henews250
//
//  Created by 汪洋 on 16/7/19.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "UIImageView+LoadFromWeb.h"

@implementation UIImageView (LoadFromWeb)

- (void)loadFromWebWithUrlString:(NSString*)str animated:(BOOL)animated {
    BOOL isExists = [[SDWebImageManager sharedManager] diskImageExistsForURL:[NSURL URLWithString:str]];
    [self sd_setImageWithURL:[NSURL URLWithString:str] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!isExists && animated) {
            self.alpha = 0;
            [UIView animateWithDuration:0.5f animations:^{
                self.alpha = 1.0f;
            }];
        }
    }];
}

@end
