//
//  ShareMode.m
//  henews
//
//  Created by 汪洋 on 16/3/16.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "ShareMode.h"

@implementation ShareMode

- (id)initWithTitle:(NSString *)title text:(NSString *)text url:(NSString *)url image:(NSString *)image{
    self = [super init];
    if (self) {
        self.shareTitle = title;
        self.shareText = text;
        self.shareUrl = url;
        self.shareImage = image;
    }
    return self;
}

@end
