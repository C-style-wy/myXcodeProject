//
//  columStruct.m
//  henews
//
//  Created by 汪洋 on 15/11/5.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "columStruct.h"

@implementation columStruct


-(void)setData:(id)data{
    _nodeId = [data objectForKey:@"nodeId"];
    _nodeName = [data objectForKey:@"nodeName"];
    _isMore = [data objectForKey:@"isMore"];
    _flag = [data objectForKey:@"flag"];
    _isHot = [data objectForKey:@"isHot"];
    _isCity = [data objectForKey:@"isCity"];
    _showAllTime = [data objectForKey:@"showAllTime"];
    _url = [data objectForKey:@"url"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super init]) {
        _nodeId = [aDecoder decodeObjectForKey:@"nodeId"];
        _nodeName = [aDecoder decodeObjectForKey:@"nodeName"];
        
        _isMore = [aDecoder decodeObjectForKey:@"isMore"];
        _flag = [aDecoder decodeObjectForKey:@"flag"];
        
        _isHot = [aDecoder decodeObjectForKey:@"isHot"];
        _isCity = [aDecoder decodeObjectForKey:@"isCity"];
        
        _showAllTime = [aDecoder decodeObjectForKey:@"showAllTime"];
        _url = [aDecoder decodeObjectForKey:@"url"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_nodeId forKey:@"nodeId"];
    [aCoder encodeObject:_nodeName forKey:@"nodeName"];
    
    [aCoder encodeObject:_isMore forKey:@"isMore"];
    [aCoder encodeObject:_flag forKey:@"flag"];
    
    [aCoder encodeObject:_isHot forKey:@"isHot"];
    [aCoder encodeObject:_isCity forKey:@"isCity"];
    
    [aCoder encodeObject:_showAllTime forKey:@"showAllTime"];
    [aCoder encodeObject:_url forKey:@"url"];
}

@end
