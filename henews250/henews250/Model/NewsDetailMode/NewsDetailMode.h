//
//  NewsDetailMode.h
//  henews250
//
//  Created by 汪洋 on 2016/11/1.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "ContentMode.h"
#import "NewsMode.h"
#import "ReadContentArrayMode.h"

@interface NewsDetailMode : BaseMode

@property (nonatomic, strong) NSString * resultMsg;
@property (nonatomic, strong) NSString * testurl;
@property (nonatomic, strong) NSString * resultCode;
@property (nonatomic, strong) NSString * systemTime;
@property (nonatomic, strong) NSString * showNum;
@property (nonatomic, strong) NSString * shareToUrl;
@property (nonatomic, strong) NSString * contentVoteUrl;
@property (nonatomic, strong) NSString * getContentVoteCountUrl;
@property (nonatomic, strong) NSString * phoneNewsDowndloadImg;
@property (nonatomic, strong) NSString * phoneNewsDowndloadUrl;
@property (nonatomic, strong) NSString * phoneNewsAppleID;
@property (nonatomic, strong) NSString * phoneNewsDowndloadWords;
@property (nonatomic, strong) NSString * commentUrl;
@property (nonatomic, strong) NSString * commentListUrl;
@property (nonatomic, strong) NSString * isFavoriteUrl;
@property (nonatomic, strong) NSString * addFavoriteUrl;
@property (nonatomic, strong) NSString * deleteFavoriteUrl;
@property (nonatomic, strong) NSString * newsDetailDataUrl;
@property (nonatomic, strong) NSString * getPlayUrl;
@property (nonatomic, strong) NSString * imageSetPvUrl;
@property (nonatomic, strong) NSString * imageSetRecommendListUrl;
@property (nonatomic, strong) NSString * commentNumUrl;

@property (strong, nonatomic) NSArray *relateConts;
@property (strong, nonatomic) NSArray *readContentArray;

@property (strong, nonatomic) ContentMode *content;

@end
