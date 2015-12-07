//
//  APIMethod.h
//  henews
//
//  Created by 汪洋 on 15/12/7.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIStringMacros.h"
#import <UIKit/UIKit.h>

@interface APIMethod : NSObject

+(BOOL) greaterThanLine:(NSInteger)lineNum labelObject:(UILabel*)label content:(NSString*)contentStr;

@end
