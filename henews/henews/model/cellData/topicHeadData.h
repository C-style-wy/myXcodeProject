//
//  topicHeadData.h
//  henews
//
//  Created by 汪洋 on 16/3/30.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIStringMacros.h"
#import <UIKit/UIKit.h>

@interface topicHeadData : NSObject

//图片
@property (nonatomic, retain) NSString *images;
//摘要
@property (nonatomic, retain) NSString *topicIntro;
@property (nonatomic, assign) CGRect introFrame;
//cell高度
@property float height;

-(void)initWithPic:(NSString *)pic topicIntro:(NSString *)topicIntro;

@end
