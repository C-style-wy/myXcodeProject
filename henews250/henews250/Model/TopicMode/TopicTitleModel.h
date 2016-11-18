//
//  TopicTitleModel.h
//  henews250
//
//  Created by 汪洋 on 2016/11/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "TopicModel.h"

@interface TopicTitleModel : BaseMode

@property (nonatomic, retain) NSString * topicIntro;
@property (nonatomic, retain) NSString * imageUrl;

- (TopicTitleModel *)initWithData:(TopicModel *)data;

@end
