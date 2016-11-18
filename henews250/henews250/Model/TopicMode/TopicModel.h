//
//  TopicModel.h
//  henews250
//
//  Created by 汪洋 on 2016/11/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "SpecialNodeListModel.h"

@interface TopicModel : BaseMode

@property (nonatomic, strong) NSString * imageUrl;
@property (nonatomic, strong) NSString * navShowNum;
@property (nonatomic, strong) NSString * newsId;
@property (nonatomic, strong) NSString * newsIntro;
@property (nonatomic, strong) NSString * newsTitle;
@property (nonatomic, strong) NSString * shareIconUrl;
@property (nonatomic, strong) NSString * sharePic;
@property (nonatomic, strong) NSString * sharePreText;
@property (nonatomic, strong) NSString * shareToUrl;
@property (nonatomic, strong) NSString * shareUrl;
@property (nonatomic, strong) NSString * weiboShareText;

@property (nonatomic, strong) NSArray * specialNodeList;

@end
