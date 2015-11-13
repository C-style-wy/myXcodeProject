//
//  NewsContentCellData.h
//  henews
//
//  Created by 汪洋 on 15/11/11.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "APIStringMacros.h"

@interface NewsContentCellData : NSObject

//标题
@property (nonatomic, retain) NSString *content;
//cell高度
@property float height;
//content frame
@property CGRect contentFrame;

-(void)initWithData:(NSString*)content;

@end
