//
//  LinkReadMode.h
//  henews250
//
//  Created by 汪洋 on 2016/11/16.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"
#import "NewsDetailMode.h"

@interface LinkReadMode : BaseMode

@property (nonatomic, retain) NSString *linkUrl;

- (LinkReadMode *)initWithData:(NewsDetailMode *)data;

@end
