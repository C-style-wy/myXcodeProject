//
//  CellData.h
//  henews
//
//  Created by 汪洋 on 15/11/10.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIStringMacros.h"

@interface CellData : NSObject

//新闻id
@property (nonatomic, retain) NSString *newsId;
//新闻类型
@property (nonatomic, retain) NSString *newsType;
//图片
@property (nonatomic, retain) NSString *images;

@property (nonatomic, retain) NSString *images2;
@property (nonatomic, retain) NSString *images3;
//标题
@property (nonatomic, retain) NSString *newsTitle;
//标签
@property (nonatomic, retain) NSString *newsTags;
//展示样式
@property (nonatomic, retain) NSString *displayType;
//阅读数
@property (nonatomic, retain) NSString *pv;
//发布时间
@property (nonatomic, retain) NSString *createTime;
//来源
@property (nonatomic, retain) NSString *source;
//摘要
@property (nonatomic, retain) NSString *newsIntro;
//url
@property (nonatomic, retain) NSString *url;
//cell高度
@property float height;

-(void)initWithData:(id)data;

@end
