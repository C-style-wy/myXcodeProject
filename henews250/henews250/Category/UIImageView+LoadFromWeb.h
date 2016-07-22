//
//  UIImageView+LoadFromWeb.h
//  henews250
//
//  Created by 汪洋 on 16/7/19.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (LoadFromWeb)

- (void)loadFromWebWithUrlString:(NSString*)str animated:(BOOL)animated;

@end
