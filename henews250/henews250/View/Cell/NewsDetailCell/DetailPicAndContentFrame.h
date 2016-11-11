//
//  DetailPicAndContentFrame.h
//  henews250
//
//  Created by 汪洋 on 2016/11/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SubContentMode.h"
#import "SHLUILabel.h"
#import "MacroDefinition.h"

#define ContentFont [UIFont systemFontOfSize:16.5f]
#define ContentPicSpace 15.0f
#define ContentLineSpace 0

@interface DetailPicAndContentFrame : NSObject

/**
 * image frame
 */
@property (nonatomic, assign) CGRect imageFrame;
/**
 * text frame
 */
@property (nonatomic, assign) CGRect textFrame;
/**
 *  行高
 */
@property (nonatomic, assign) CGFloat cellHeight;
/**
 * 数据
 */
@property (nonatomic, retain) SubContentMode *contentMode;

@end
