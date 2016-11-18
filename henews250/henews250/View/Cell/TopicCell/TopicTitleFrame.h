//
//  TopicTitleFrame.h
//  henews250
//
//  Created by 汪洋 on 2016/11/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TopicTitleModel.h"
#import "MacroDefinition.h"
#import "SHLUILabel.h"

#define IntroFont [UIFont fontWithName:@"KaiTi_GB2312" size:14.0f]
#define IntroPicSpace 8.0f
#define IntroLineSpace 4.0f

@interface TopicTitleFrame : NSObject

/**
 * image frame
 */
@property (nonatomic, assign) CGRect topicImageFrame;
/**
 * text frame
 */
@property (nonatomic, assign) CGRect topicIntroFrame;
/**
 *  行高
 */
@property (nonatomic, assign) CGFloat cellHeight;
/**
 * 数据
 */
@property (nonatomic, retain) TopicTitleModel *topicTitleModel;

@end
