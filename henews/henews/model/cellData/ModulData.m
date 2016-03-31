//
//  ModulData.m
//  henews
//
//  Created by 汪洋 on 15/11/20.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "ModulData.h"

@implementation ModulData

-(id)init{
    self = [super init];
    if (self) {
        _nodeId = @"";
        _nodeName = @"";
        
        
        _displayType = @"";
        _changeUrl = @"";
        
        _isMore = @"";
        
        _linkNodeId = @"";
        _channelType = @"";
        
        _newsList = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)initWithData:(id)data{
    //模块id
    NSString *nodeId = [data objectForKey:@"nodeId"];
    if (nodeId && ![nodeId isEqual:@""]) {
        _nodeId = nodeId;
    }
    //模块名
    NSString *nodeName = [data objectForKey:@"nodeName"];
    if (nodeName && ![nodeName isEqual:@""]) {
        _nodeName = nodeName;
    }
    //模块展示类型
    NSString *displayType = [data objectForKey:@"displayType"];
    if (displayType && ![displayType isEqual:@""]) {
        _displayType = displayType;
    }
    //模块换一批url
    NSString *changeUrl = [data objectForKey:@"changeUrl"];
    if (changeUrl && ![changeUrl isEqual:@""]) {
        _changeUrl = changeUrl;
    }
    
    NSString *url = [data objectForKey:@"url"];
    if (url && ![url isEqual:@""]) {
        _changeUrl = url;
    }
    
    NSString *isMore = [data objectForKey:@"isMore"];
    if (isMore && ![isMore isEqual:@""]) {
        _isMore = isMore;
    }
    
    NSString *linkNodeId = [data objectForKey:@"_linkNodeId"];
    if (_linkNodeId && ![_linkNodeId isEqual:@""]) {
        _linkNodeId = linkNodeId;
    }
    NSArray *newsList = [data objectForKey:@"newsList"];
    if (newsList && newsList.count > 0) {
        for (int i = 0; i < newsList.count; i++) {
            CellData *cell = [[CellData alloc]init];
            [cell initWithData:[newsList objectAtIndex:i]];
            if (![cell.newsTitle isEqual:@""]) {
                [_newsList addObject:cell];
            }
        }
    }
}

@end
