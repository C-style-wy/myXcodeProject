//
//  RechTextRegex.m
//  henews250
//
//  Created by 汪洋 on 2016/11/23.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "RechTextRegex.h"
#import <CoreText/CoreText.h>
#import "UIColor+hexColor.h"

@implementation RechTextRegex

+ (RechTextRegex *)sharedInstance {
    static RechTextRegex *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[RechTextRegex alloc] init];
    });
    return handler;
}

#pragma mark - 懒加载
- (NSMutableArray *)regexAry {
    if (!_regexAry) {
        _regexAry = [[NSMutableArray alloc]init];
        NSString *regex1 = [regexBLeft copy];
        [_regexAry addObject:regex1];
        
        NSString *regex2 = [regexBRight copy];
        [_regexAry addObject:regex2];
        
        NSString *regex3 = [regexULeft copy];
        [_regexAry addObject:regex3];
        
        NSString *regex4 = [regexURight copy];
        [_regexAry addObject:regex4];
        
        NSString *regex5 = [regexColorLeft copy];
        [_regexAry addObject:regex5];
        
        NSString *regex6 = [regexColorRight copy];
        [_regexAry addObject:regex6];
        
        NSString *regex7 = [regexPicStr copy];
        [_regexAry addObject:regex7];
        
        NSString *regex8 = [regexLinkLeft copy];
        [_regexAry addObject:regex8];
        
        NSString *regex9 = [regexLinkRight copy];
        [_regexAry addObject:regex9];
    }
    return _regexAry;
}

- (NSMutableAttributedString *)getAttributedStringWithString:(NSString *)str font:(UIFont *)font color:(UIColor *)color{
    self.textFont = font;
    self.textColor = color;
    self.orginalString = str;
    return _attr;
}

- (void)setOrginalString:(NSString *)orginalString {
    _orginalString = orginalString;
    
    NSRegularExpression *regExp;
    _showText = _orginalString;
    _splitText = _orginalString;
    _picText = _orginalString;
    for (NSString *regexString in self.regexAry) {
        regExp = [[NSRegularExpression alloc] initWithPattern:regexString
                                                      options:NSRegularExpressionCaseInsensitive
                                                        error:nil];
        _showText = [regExp stringByReplacingMatchesInString:_showText
                                                     options:NSMatchingReportProgress
                                                       range:NSMakeRange(0, _showText.length)
                                                withTemplate:@""];
        
        if (![regexString isEqualToString:regexPicStr]) {
            _splitText = [regExp stringByReplacingMatchesInString:_splitText
                                                          options:NSMatchingReportProgress
                                                            range:NSMakeRange(0, _splitText.length)
                                                     withTemplate:splitSymbol];
            
            _picText = [regExp stringByReplacingMatchesInString:_picText
                                                          options:NSMatchingReportProgress
                                                            range:NSMakeRange(0, _picText.length)
                                                     withTemplate:@""];
        }else{
            // 去掉待分割字符串中的图片
            _splitText = [regExp stringByReplacingMatchesInString:_splitText
                                                          options:NSMatchingReportProgress
                                                            range:NSMakeRange(0, _splitText.length)
                                                     withTemplate:@""];
        }
    }
//    NSArray *splitAry = [_splitText componentsSeparatedByString:splitSymbol];
    
    _attr = [[NSMutableAttributedString alloc]initWithString:_showText];
    // 基本处理
    _attr = [self handleBaseRegex:_attr];
    if (![_showText isEqualToString:_orginalString]) {
        // 处理图片
        //    _attr = [self handlePicRegex:_attr];
        // 处理加粗
        _attr = [self handleBRegex:_attr];
        // 处理下划线
        _attr = [self handleURegex:_attr];
        // 处理颜色
        _attr = [self handleColorRegex:_attr];
        // 处理链接
        _attr = [self handleLinkRegex:_attr];
    }
}
- (NSMutableAttributedString *)handleBaseRegex:(NSMutableAttributedString *)attributedString {
    CTFontRef helveticaBold = CTFontCreateWithName((CFStringRef)self.textFont.fontName,self.textFont.pointSize,NULL);
    [attributedString addAttribute:(id)kCTFontAttributeName value:(__bridge id)helveticaBold range:NSMakeRange(0,[_showText length])];
    
    [attributedString addAttribute:(id)kCTForegroundColorAttributeName value:(id)(self.textColor.CGColor) range:NSMakeRange(0, [attributedString length])];
    return attributedString;
}

- (NSMutableAttributedString *)handleBRegex:(NSMutableAttributedString *)attributedString {
    NSArray *splitAry = [_splitText componentsSeparatedByString:splitSymbol];
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexBStr options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *resultAry = [regex matchesInString:_orginalString options:0 range:NSMakeRange(0, [_orginalString length])];
    if (resultAry && resultAry.count > 0) {
        for (NSTextCheckingResult *result in resultAry) {
            NSString *bStr = [_orginalString substringWithRange:result.range];
            NSInteger left = 0;
            
            for (NSString *splitStr in splitAry) {
                if (![splitStr isEqualToString:@""]) {
                    if ([bStr rangeOfString:splitStr].location != NSNotFound) {
                        [attributedString addAttribute:(id)kCTFontAttributeName value:[UIFont boldSystemFontOfSize:self.textFont.pointSize] range:NSMakeRange(left, [splitStr length])];
                    }
                    left = left + splitStr.length;
                }
            }
        }
    }
    return attributedString;
}

- (NSMutableAttributedString *)handleURegex:(NSMutableAttributedString *)attributedString {
    NSArray *splitAry = [_splitText componentsSeparatedByString:splitSymbol];
        
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexUStr options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *resultAry = [regex matchesInString:_orginalString options:0 range:NSMakeRange(0, [_orginalString length])];
    if (resultAry && resultAry.count > 0) {
        for (NSTextCheckingResult *result in resultAry) {
            NSString *uStr = [_orginalString substringWithRange:result.range];
            NSInteger left = 0;
            
            for (NSString *splitStr in splitAry) {
                if (![splitStr isEqualToString:@""]) {
                    if ([uStr rangeOfString:splitStr].location != NSNotFound) {
                        
                        [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(left, [splitStr length])];
                    }
                    left = left + splitStr.length;
                }
            }
        }
    }
    return attributedString;
}

- (NSMutableAttributedString *)handleColorRegex:(NSMutableAttributedString *)attributedString {
    NSArray *splitAry = [_splitText componentsSeparatedByString:splitSymbol];
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexColorStr options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *resultAry = [regex matchesInString:_orginalString options:0 range:NSMakeRange(0, [_orginalString length])];
    if (resultAry && resultAry.count > 0) {
        for (NSTextCheckingResult *result in resultAry) {
            NSString *cStr = [_orginalString substringWithRange:result.range];
            NSInteger left = 0;
            
            NSRegularExpression *colorRegex = [NSRegularExpression regularExpressionWithPattern:@"<C:[a-zA-Z\\d]{6}>" options:NSRegularExpressionCaseInsensitive error:&error];
            NSTextCheckingResult *colorStrResult = [colorRegex firstMatchInString:cStr options:0 range:NSMakeRange(0, [cStr length])];
            NSString *colorStr = [cStr substringWithRange:colorStrResult.range];
            colorStr = [colorStr stringByReplacingOccurrencesOfString:@"<C:" withString:@"#"];
            colorStr = [colorStr stringByReplacingOccurrencesOfString:@">" withString:@""];
            
            for (NSString *splitStr in splitAry) {
                if (![splitStr isEqualToString:@""]) {
                    if ([cStr rangeOfString:splitStr].location != NSNotFound) {
//                        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColor:colorStr] range:NSMakeRange(left, [splitStr length])];
                        
                        [attributedString addAttribute:(id)kCTForegroundColorAttributeName value:(id)[UIColor colorWithHexColor:colorStr].CGColor range:NSMakeRange(left, [splitStr length])];
                    }
                    left = left + splitStr.length;
                }
            }
        }
    }
    return attributedString;
}

- (NSMutableAttributedString *)handleLinkRegex:(NSMutableAttributedString *)attributedString {
    NSArray *splitAry = [_splitText componentsSeparatedByString:splitSymbol];
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexLinkStr options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *resultAry = [regex matchesInString:_orginalString options:0 range:NSMakeRange(0, [_orginalString length])];
    if (resultAry && resultAry.count > 0) {
        for (NSTextCheckingResult *result in resultAry) {
            NSString *lStr = [_orginalString substringWithRange:result.range];
            NSInteger left = 0;
            
            NSRegularExpression *linkRegex = [NSRegularExpression regularExpressionWithPattern:@"text_normal=[a-zA-Z\\d]{6}" options:NSRegularExpressionCaseInsensitive error:&error];
            NSTextCheckingResult *colorStrResult = [linkRegex firstMatchInString:lStr options:0 range:NSMakeRange(0, [lStr length])];
            NSString *linkNorStr = [lStr substringWithRange:colorStrResult.range];
            linkNorStr = [linkNorStr stringByReplacingOccurrencesOfString:@"text_normal=" withString:@"#"];
            
            for (NSString *splitStr in splitAry) {
                if (![splitStr isEqualToString:@""]) {
                    if ([lStr rangeOfString:splitStr].location != NSNotFound) {
                        if (linkNorStr && ![linkNorStr isEqualToString:@""]) {
                            [attributedString addAttribute:(id)kCTForegroundColorAttributeName value:(id)[UIColor colorWithHexColor:linkNorStr].CGColor range:NSMakeRange(left, [splitStr length])];
                        }
                        
                        [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(left, [splitStr length])];
                        
                        [attributedString addAttribute:NSLinkAttributeName
                                       value:@"username://@www.apple.com/"
                                       range:NSMakeRange(left, [splitStr length])];
                    }
                    left = left + splitStr.length;
                }
            }
        }
    }
    return attributedString;
}

- (NSMutableAttributedString *)handlePicRegex:(NSMutableAttributedString *)attributedString {
    NSError *error = NULL;
    NSRegularExpression *regexPic = [NSRegularExpression regularExpressionWithPattern:regexPicStr options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *resultPicAry = [regexPic matchesInString:_picText options:0 range:NSMakeRange(0, [_picText length])];
    if (resultPicAry && resultPicAry.count > 0) {
        NSInteger leftOffset = 0;
        for (NSTextCheckingResult *result in resultPicAry) {
//            NSLog(@"====wy======%li", result.range.location - leftOffset);
//            NSString *picInfo = [_picText substringWithRange:result.range];
            
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            attch.image = [UIImage imageNamed:@"welfare_score"];
//            attch.bounds = CGRectMake(0, 0, _textFont.pointSize, _textFont.pointSize);
            attch.bounds = CGRectMake(0, 0, 30, 30);
            
            // <image:src=file://image/h001.png;rect=0,0,30,30>
            NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
            [attributedString insertAttributedString:string atIndex:result.range.location - leftOffset];
            leftOffset = leftOffset + result.range.length;
        }
    }
    
    return attributedString;
}

@end
