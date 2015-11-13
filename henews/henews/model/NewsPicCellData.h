//
//  NewsPicCellData.h
//  henews
//
//  Created by 汪洋 on 15/11/11.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "APIStringMacros.h"

@interface NewsPicCellData : NSObject

//图片Url
@property (nonatomic, retain) NSString *picUrl;
//cell高度
@property float height;
//content frame
@property CGRect picFrame;

-(void)initWithData:(id)data;

@end
