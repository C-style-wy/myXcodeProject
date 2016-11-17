//
//  NewsSectionMode.h
//  henews250
//
//  Created by 汪洋 on 2016/11/2.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "NewsDetailMode.h"
#import "NewsSectionConst.h"

#import "NewsTitleMode.h"
#import "SpotMode.h"
#import "DetailShareMode.h"
#import "LinkReadMode.h"

@interface NewsSectionMode : BaseMode

@property (nonatomic, assign) SectionType sectionType;
@property (nonatomic, retain) NSMutableArray *newsSectionAry;

- (NewsSectionMode *)initWithData:(NewsDetailMode *)data;

- (NewsSectionMode *)initWithCommentData:(NewsDetailMode *)data;

- (NewsSectionMode *)initWithRelateContsData:(NewsDetailMode *)data;

@end
