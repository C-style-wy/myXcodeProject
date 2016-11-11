//
//  NewsTitleFrame.h
//  henews250
//
//  Created by 汪洋 on 2016/11/9.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SHLUILabel.h"
#import "NewsTitleMode.h"
#import "MacroDefinition.h"
#import "UILabel+NeedWidthAndHeight.h"

#define TitleFont [UIFont systemFontOfSize:18]
#define SourceAndTimeFont [UIFont systemFontOfSize:12]
#define TitleLineSpace 0

@interface NewsTitleFrame : NSObject

/**
 * 新闻标题Label frame
 */
@property (nonatomic, assign) CGRect titleFrame;
/**
 * 新闻来源Label frame
 */
@property (nonatomic, assign) CGRect sourceFrame;
/**
 * 新闻时间Label frame
 */
@property (nonatomic, assign) CGRect timeFrame;
/**
 *  行高
 */
@property (nonatomic, assign) CGFloat cellHeight;
/**
 * 数据
 */
@property (nonatomic, retain) NewsTitleMode *newsTitle;

@end
