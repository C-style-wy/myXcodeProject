//
//  CellData.m
//  henews
//
//  Created by 汪洋 on 15/11/10.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "CellData.h"

@implementation CellData

-(id)init{
    self = [super init];
    if (self) {
        _newsId = @"";
        _newsType = @"";
        _images = @"";
        _images2 = @"";
        _images3 = @"";
        
        _newsTitle = @"";
        _newsTags = @"";
        _displayType = @"0";
        _pv = @"";
        _createTime = @"";
        _source = @"";
        _newsIntro = @"";
        _url = @"";
        _height = 80.0f;
    }
    return self;
}

-(void)initWithData:(id)data{
    //新闻id
    NSString *newsId = [data objectForKey:@"newsId"];
    if (newsId && ![newsId isEqual:@""]) {
        _newsId = newsId;
    }
    //新闻类型
    NSString *newsType = [data objectForKey:@"newsType"];
    if (newsType && ![newsType isEqual:@""]) {
        _newsType = newsType;
    }
    //标题
    NSString *newsTitle = [data objectForKey:@"newsTitle"];
    if (newsTitle && ![newsTitle isEqual:@""]) {
        _newsTitle = newsTitle;
    }
    //标签
    NSArray *tempAry = [data objectForKey:@"newsTags"];
    if (tempAry && tempAry.count > 0) {
        NSString *tag = [[tempAry objectAtIndex:0] objectForKey:@"tag"];
        if (tag&&![tag isEqual:@""]) {
            _newsTags = tag;
        }
    }
    //展示样式
    NSString *displayType = [data objectForKey:@"displayType"];
    if (displayType && ![displayType isEqual:@""]) {
        _displayType = displayType;
    }
    //阅读数
    NSString *pv = [data objectForKey:@"pv"];
    if (pv && ![pv isEqual:@""]) {
        _pv = pv;
    }
    //发布时间
    NSString *createTime = [data objectForKey:@"createTime"];
    if (createTime && ![createTime isEqual:@""]) {
        _createTime = createTime;
    }
    //来源
    NSString *source = [data objectForKey:@"source"];
    if (source && ![source isEqual:@""]) {
        _source = source;
    }
    //url
    NSString *url = [data objectForKey:@"url"];
    if (url && ![url isEqual:@""]) {
        _url = url;
    }
    //摘要
    NSString *newsIntro = [data objectForKey:@"newsIntro"];
    if (newsIntro && ![newsIntro isEqual:@""]) {
        _newsIntro = newsIntro;
    }
    //图片
    NSArray *tempAry2 = [data objectForKey:@"images"];
    if (tempAry2 && tempAry2.count >= 1) {
        NSString *imageUrl = [[tempAry2 objectAtIndex:0] objectForKey:@"imageUrl"];
        if (imageUrl&&![imageUrl isEqual:@""]) {
            _images = imageUrl;
        }
    }
    if (tempAry2 && tempAry2.count >= 2) {
        NSString *imageUrl = [[tempAry2 objectAtIndex:1] objectForKey:@"imageUrl"];
        if (imageUrl&&![imageUrl isEqual:@""]) {
            _images2 = imageUrl;
        }
    }
    if (tempAry2 && tempAry2.count >= 3) {
        NSString *imageUrl = [[tempAry2 objectAtIndex:2] objectForKey:@"imageUrl"];
        if (imageUrl&&![imageUrl isEqual:@""]) {
            _images3 = imageUrl;
        }
    }
    //cell高度
    if ([_displayType isEqual:ONLY_WORD]) {  //无图--
        _height = 80.0f;
    }else if ([_displayType isEqual:ONE_BIG_PIC]){  //单张大图--
        _height = 171.0f;
    }else if ([_displayType isEqual:ONE_SMALL_PIC_R]){  //单张小图在右边，现在不用了
        _height = 88.0f;
    }else if ([_displayType isEqual:THREE_SMALL_PIC]){  //三张小图
        _height = 146.0f;
    }else if ([_displayType isEqual:ONEBIG_TWOSMALL_PIC]){  //一张大图两张小图
        _height = 216.0f;
    }else if ([_displayType isEqual:EVERY_ONE]){  //大家样式--
        _height = 81.0f;
    }else if ([_displayType isEqual:EVERY_ONE_G]){  //感性样式--
        _height = 81.0f;
    }else if ([_displayType isEqual:NEWS_EARLY_BUS]){  //新闻早班车--
        _height = 171.0f;
    }else if ([_displayType isEqual:ONE_SMALL_PIC]){  //一张小图--
        _height = 88.0f;
    }else{
        _height = 80.0f;
    }
}
@end
