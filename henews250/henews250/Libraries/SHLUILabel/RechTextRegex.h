//
//  RechTextRegex.h
//  henews250
//
//  Created by 汪洋 on 2016/11/23.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 加粗正则
static NSString * const regexBStr = @"<B>([\\s\\S]*?)</B>";
static NSString * const regexBLeft = @"<B>";
static NSString * const regexBRight = @"</B>";

// 下划线正则
static NSString * const regexUStr = @"<U>([\\s\\S]*?)</U>";
static NSString * const regexULeft = @"<U>";
static NSString * const regexURight = @"</U>";

// 颜色正则
static NSString * const regexColorStr = @"<C:[a-zA-Z\\d]{6}>([\\s\\S]*?)<N>";
static NSString * const regexColorLeft = @"<C:[a-zA-Z\\d]{6}>";
static NSString * const regexColorRight = @"<N>";

// 图片正则
static NSString * const regexPicStr = @"<image:src=([\\s\\S]*?);rect=[\\d]*,[\\d]*,[\\d]*,[\\d]*>";

// 外链正则
// <node:text_normal=006496;text_selecteing=00ff00;text_selected=969696;data=0,5134630,http://211.140.7.174:8001/clt/publish/clt/resource/portal/v1/commonNews.jsp?c=5134630,0,1,内链.....苯酚;OnMouseUp=nodeOnMouseUp>内链.....苯酚</node>
static NSString * const regexLinkStr = @"<node:(text_normal=[a-zA-Z\\d]{6};){0,1}text_selecteing=[a-zA-Z\\d]{6};text_selected=[a-zA-Z\\d]{6};data=([\\s\\S]*?);OnMouseUp=nodeOnMouseUp>([\\s\\S]*?)</node>";
static NSString * const regexLinkLeft = @"<node:(text_normal=[a-zA-Z\\d]{6};){0,1}text_selecteing=[a-zA-Z\\d]{6};text_selected=[a-zA-Z\\d]{6};data=([\\s\\S]*?);OnMouseUp=nodeOnMouseUp>";
static NSString * const regexLinkRight = @"</node>";


static NSString * const splitSymbol = @"&&&@&&#&&&";

@interface RechTextRegex : NSObject
/**
 *  单例
 *
 *  @return BMNetworkHandler的单例对象
 */
+ (RechTextRegex *)sharedInstance;

@property (nonatomic, retain) NSString *orginalString;
@property (nonatomic, retain) NSString *showText;
@property (nonatomic, retain) NSString *splitText;
@property (nonatomic, retain) NSString *picText;

@property (nonatomic, retain) UIFont *textFont;
@property (nonatomic, retain) UIColor *textColor;

@property (nonatomic, retain) NSMutableArray *regexAry;

@property (nonatomic, retain) NSMutableAttributedString *attr;

- (NSMutableAttributedString *)getAttributedStringWithString:(NSString *)str font:(UIFont *)font color:(UIColor *)color;
@end
