//
//  NSBundle+MYRefresh.h
//  henews250
//
//  Created by 汪洋 on 16/10/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSBundle (MYRefresh)
+ (instancetype)my_refreshBundle;
+ (UIImage *)my_arrowImage;
+ (NSString *)my_localizedStringForKey:(NSString *)key value:(NSString *)value;
+ (NSString *)my_localizedStringForKey:(NSString *)key;
@end
