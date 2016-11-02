//
//  ContentMode.h
//  henews250
//
//  Created by 汪洋 on 2016/11/1.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "SubContentMode.h"
#import "VideosMode.h"
#import "ImagesMode.h"

@interface ContentMode : BaseMode

@property (nonatomic, strong) NSString * contId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * summary;
@property (nonatomic, strong) NSString * author;
@property (nonatomic, strong) NSString * pubTime;
@property (nonatomic, strong) NSString * contType;
@property (nonatomic, strong) NSString * contTypeDesc;
@property (nonatomic, strong) NSString * link;
@property (nonatomic, strong) NSString * source;
@property (nonatomic, strong) NSString * sourceImageUrl;
@property (nonatomic, strong) NSString * commentNum;
@property (nonatomic, strong) NSString * readNum;
@property (nonatomic, strong) NSString * qaNum;
@property (nonatomic, strong) NSString * nodeInfo;
@property (nonatomic, strong) NSString * isTrack;
@property (nonatomic, strong) NSString * isTracked;
@property (nonatomic, strong) NSString * trackKeyWord;
@property (nonatomic, strong) NSString * tags;
@property (nonatomic, strong) NSString * shareUrl;
@property (nonatomic, strong) NSString * realUrl;
@property (nonatomic, strong) NSString * sharePic;
@property (nonatomic, strong) NSString * shareIconUrl;
@property (nonatomic, strong) NSString * sharePreText;
@property (nonatomic, strong) NSString * weiboShareText;

@property (strong, nonatomic) NSArray *content;
@property (strong, nonatomic) NSArray *videos;
@property (strong, nonatomic) NSArray *images;

@end
