//
//  OneBannerData.h
//  henews
//
//  Created by 汪洋 on 15/11/18.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneBannerData : NSObject

//newsId
@property (nonatomic, retain) NSString *newsId;
//标题
@property (nonatomic, retain) NSString *newsTitle;
//新闻类型
@property (nonatomic, retain) NSString *newsType;
//新闻tag
@property (nonatomic, retain) NSString *newsTag;
//图片Url
@property (nonatomic, retain) NSString *imageUrl;
//新闻url
@property (nonatomic, retain) NSString *url;

-(void)initWithData:(id)data;

@end
