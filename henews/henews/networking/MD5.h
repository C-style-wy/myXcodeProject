//
//  MD5.h
//  henews
//
//  Created by 汪洋 on 15/12/4.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface MD5 : NSObject

+ (NSString *) encoding:(NSString *)str;

@end
