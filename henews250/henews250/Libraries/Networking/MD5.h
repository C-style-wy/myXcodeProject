//
//  MD5.h
//  henews250
//
//  Created by 汪洋 on 16/7/12.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface MD5 : NSObject

+ (NSString *) encoding:(NSString *)str;

@end
