//
//  BaseViewController.h
//  henews250
//
//  Created by 汪洋 on 16/7/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MacroDefinition.h"

@interface BaseViewController : UIViewController


- (iPhoneType)returnIphoneType;
- (NSString*)getUserData:(NSString*)key;
- (void)setUserData:(NSString*)key value:(NSString*)value;
@end
