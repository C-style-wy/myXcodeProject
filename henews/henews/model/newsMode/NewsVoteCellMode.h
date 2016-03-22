//
//  NewsVoteCellMode.h
//  henews
//
//  Created by 汪洋 on 16/3/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NewsVoteCellMode : NSObject

@property (nonatomic, retain) NSString *voteUrl;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, retain) NSString *goodTimes;
@property (nonatomic, retain) NSString *badTimes;


- (void)initWithData:(NSString*)url goodTimes:(NSString *)good badTimes:(NSString *)bad;

@end
