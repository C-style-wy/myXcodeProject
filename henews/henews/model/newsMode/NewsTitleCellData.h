//
//  NewsTitleCellData.h
//  henews
//
//  Created by 汪洋 on 15/11/11.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "APIStringMacros.h"

@interface NewsTitleCellData : NSObject

//标题
@property (nonatomic, retain) NSString *title;
//来源和发布时间
@property (nonatomic, retain) NSString *sourceAndTime;
//cell高度
@property float height;
//titleLabel frame
@property CGRect titleFrame;
//sourceAndTime frame
@property CGRect timeFrame;

-(void)initWithData:(NSString*)newsTitle source:(NSString*)newsSource time:(NSString*)time;

@end
