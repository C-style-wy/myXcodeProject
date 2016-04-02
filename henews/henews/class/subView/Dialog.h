//
//  Dialog.h
//  henews
//
//  Created by 汪洋 on 16/3/31.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Dialog : UIView
typedef void (^LeftBlock)();
typedef void (^RightBlock)();

+ (void)showWithTipText:(NSString *)tipText descText:(NSString *)descText LeftText:(NSString *)leftText rightText:(NSString *)rightText LeftBlock:(LeftBlock)leftBlock RightBlock:(RightBlock)rightBlock;
@end
