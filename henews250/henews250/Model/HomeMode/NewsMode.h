//
//  NewsMode.h
//  henews250
//
//  Created by 汪洋 on 16/7/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface NewsMode : NSObject

@property (nonatomic, copy)NSString *newsId;
@property (nonatomic, copy)NSString *isHighlight;
@property (nonatomic, copy)NSString *newsTitle;
@property (nonatomic, copy)NSString *newsType;
@property (nonatomic, copy)NSString *duration;
@property (nonatomic, copy)NSString *pubTime;
@property (nonatomic, copy)NSString *createTime;
@property (nonatomic, copy)NSString *displayType;
@property (nonatomic, copy)NSString *bigImgDisplayType;
@property (nonatomic, copy)NSString *newsIntro;
@property (nonatomic, copy)NSString *realPv;
@property (nonatomic, copy)NSString *pv;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSString *source;

@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSArray *newsTags;

@end
