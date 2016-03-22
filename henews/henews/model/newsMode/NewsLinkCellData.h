//
//  NewsLinkCellData.h
//  henews
//
//  Created by 汪洋 on 16/3/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIStringMacros.h"
#import <UIKit/UIKit.h>

@interface NewsLinkCellData : NSObject

@property (nonatomic, retain) NSString *linkUrl;
@property (nonatomic, assign) CGFloat height;

-(void)initWithData:(NSString*)url;

@end
