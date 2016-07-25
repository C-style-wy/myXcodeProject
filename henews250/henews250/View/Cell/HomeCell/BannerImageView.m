//
//  BannerImageView.m
//  henews250
//
//  Created by 汪洋 on 16/7/22.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BannerImageView.h"

@implementation BannerImageView {
    BannerMode *_banner;
}

- (id)initWithData:(BannerMode *)banner {
    self = [super init];
    if (self) {
        if (banner) {
            _banner = banner;
            if (_banner.imageUrl && ![_banner.imageUrl isEqualToString:@""]) {
                [self.image loadFromWebWithUrlString:_banner.imageUrl animated:YES];
            }
        }
    }
    return self;
}

@end
