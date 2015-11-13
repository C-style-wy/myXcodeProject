//
//  ClassDataStru.h
//  henews
//
//  Created by 汪洋 on 15/11/6.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassDataStru : NSObject

//表示是否已经有数据了，切换到当前目录是否需要主动刷新
@property (nonatomic, assign) BOOL needReflush;
//tableView当前位置(y值)
@property (nonatomic, assign) float curPosition;
//tableView需要加载的数据
@property (nonatomic, retain) NSMutableArray *data;
//刷新的Url
@property (nonatomic, retain) NSString *reflushUrl;
//加载更多的url
@property (nonatomic, retain) NSString *loadingMoreUrl;

@end
