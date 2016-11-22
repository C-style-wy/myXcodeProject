//
//  SHLUILabel.m
//  MyLabel
//
//  Created by showhillLee on 14-3-16.
//  Copyright (c) 2014年 showhilllee. All rights reserved.
//

#import "SHLUILabel.h"
#import <CoreText/CoreText.h>

//#define BoldRegular (@"<B>.</B>")

@interface SHLUILabel ()
{
@private
    NSMutableAttributedString *attributedString;
//    CGFloat characterSpacing
}
- (void) initAttributedString;
@end

@implementation SHLUILabel

@synthesize characterSpacing = characterSpacing_;

@synthesize linesSpacing = linesSpacing_;

@synthesize paragraphSpacing = _paragraphSpacing;


- (id)initWithFrame:(CGRect)frame{
    //初始化字间距、行间距
    if(self =[super initWithFrame:frame]){
        self.characterSpacing = 0.5f;
        self.linesSpacing = 2.0f;
        self.paragraphSpacing = 2.0f;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//外部调用设置字间距
-(void)setCharacterSpacing:(CGFloat)characterSpacing{
    characterSpacing_ = characterSpacing;
    [self setNeedsDisplay];
}
//外部调用设置行间距
-(void)setLinesSpacing:(long)linesSpacing{
    linesSpacing_ = linesSpacing;
    [self setNeedsDisplay];
}

#pragma mark - wy
- (NSMutableAttributedString*)handleAttributedString {
    NSString *labelString = self.text;
    
    NSMutableArray *strAry = [[NSMutableArray alloc]init];
    [strAry removeAllObjects];
    if ([labelString rangeOfString:@"<B>\n</B>"].location != NSNotFound) {
        labelString = [labelString stringByReplacingOccurrencesOfString:@"<B>\n</B>" withString:@"\n"];
    }
    while ([labelString rangeOfString:@"\n\n"].location != NSNotFound) {
        labelString = [labelString stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
    }
    if (([labelString rangeOfString:@"<B>"].location != NSNotFound) ||
        ([labelString rangeOfString:@"<b>"].location != NSNotFound)) {
        
        labelString = [labelString stringByReplacingOccurrencesOfString:@"<b>" withString:@"<B>"];
        labelString = [labelString stringByReplacingOccurrencesOfString:@"</b>" withString:@"</B>"];
        
        NSArray *ary = [labelString componentsSeparatedByString:@"<B>"];
        
        
        for (int i = 0; i < ary.count; i++) {
            NSString *subStr = [ary objectAtIndex:i];
            if ([subStr rangeOfString:@"</B>"].location != NSNotFound) {
                subStr = [@"<B>" stringByAppendingString:subStr];
                NSArray *bAry = [subStr componentsSeparatedByString:@"</B>"];
                for (int j = 0; j < bAry.count; j++) {
                    [strAry addObject:[bAry objectAtIndex:j]];
                }
            }else{
                [strAry addObject:subStr];
            }
        }
//        for (int m = 0; m < strAry.count; m++) {
//            NSLog(@"str====%@", [strAry objectAtIndex:m]);
//        }
    }
    NSMutableAttributedString *attr;
    if (strAry.count > 0) {
        NSString *showStr = @"";
        for (int m = 0; m < strAry.count; m++) {
            NSString *tempStr = [[NSString alloc]initWithString:[strAry objectAtIndex:m]];
            if ([tempStr rangeOfString:@"<B>"].location != NSNotFound) {
                tempStr = [tempStr stringByReplacingOccurrencesOfString:@"<B>" withString:@""];
            }
            showStr = [showStr stringByAppendingString:tempStr];
        }
        attr = [[NSMutableAttributedString alloc]initWithString:showStr];
        NSString *leftStr = @"";
        for (int n = 0; n < strAry.count; n++) {
            NSString *tempStr = [strAry objectAtIndex:n];
            if (![tempStr isEqualToString:@""]) {
                if ([tempStr rangeOfString:@"<B>"].location != NSNotFound) {
                    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"<B>" withString:@""];
                    
                    [attr addAttribute:(id)kCTFontAttributeName value:[UIFont boldSystemFontOfSize:self.font.pointSize] range:NSMakeRange([leftStr length], [tempStr length])];
                    
                }else{
                    CTFontRef helveticaBold = CTFontCreateWithName((CFStringRef)self.font.fontName,self.font.pointSize,NULL);
                    [attr addAttribute:(id)kCTFontAttributeName value:(__bridge id)helveticaBold range:NSMakeRange([leftStr length], [tempStr length])];
                }
                leftStr = [leftStr stringByAppendingString:tempStr];
            }
        }
    }else{
        attr = [[NSMutableAttributedString alloc]initWithString:labelString];
        CTFontRef helveticaBold = CTFontCreateWithName((CFStringRef)self.font.fontName,self.font.pointSize,NULL);
        [attr addAttribute:(id)kCTFontAttributeName value:(__bridge id)helveticaBold range:NSMakeRange(0, [labelString length])];
    }
    
    return attr;
}

/*
 *初始化AttributedString并进行相应设置
 */
- (void)initAttributedString{
    if(attributedString == nil){
//        NSString *labelString = self.text;
        //创建AttributeString
//        attributedString =[[NSMutableAttributedString alloc]initWithString:labelString];
        attributedString = [self handleAttributedString];
        //设置字体及大小
//        CTFontRef helveticaBold = CTFontCreateWithName((CFStringRef)self.font.fontName,self.font.pointSize,NULL);
//        [attributedString addAttribute:(id)kCTFontAttributeName value:(__bridge id)helveticaBold range:NSMakeRange(0,[attributedString length])];
        //设置字间距
        long number = self.characterSpacing;
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
        [attributedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedString length])];
        CFRelease(num);
        /*
         if(self.characterSpacing)
         {
         long number = self.characterSpacing;
         CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
         [attributedString addAttribute:(id)kCTKernAttributeName value:(id)num range:NSMakeRange(0,[attributedString length])];
         CFRelease(num);
         }
         */
        //设置字体颜色
        [attributedString addAttribute:(id)kCTForegroundColorAttributeName value:(id)(self.textColor.CGColor) range:NSMakeRange(0,[attributedString length])];
        
        //创建文本对齐方式
        CTTextAlignment alignment = kCTTextAlignmentJustified;
        if(self.textAlignment == NSTextAlignmentCenter)
        {
            alignment = kCTTextAlignmentJustified;
        }
        if(self.textAlignment == NSTextAlignmentRight)
        {
            alignment = kCTTextAlignmentJustified;
        }
        
        CTParagraphStyleSetting alignmentStyle;
        
        alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment;
        
        alignmentStyle.valueSize = sizeof(alignment);
        
        alignmentStyle.value = &alignment;
        
        //设置文本行间距
        /*
         CGFloat lineSpace = self.linesSpacing;
         */
        CGFloat lineSpace = self.linesSpacing;
        CTParagraphStyleSetting lineSpaceStyle;
        lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
        lineSpaceStyle.valueSize = sizeof(lineSpace);
        lineSpaceStyle.value =&lineSpace;
        
        //设置文本段间距
        CGFloat paragraphSpacings = self.paragraphSpacing;
        CTParagraphStyleSetting paragraphSpaceStyle;
        paragraphSpaceStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
        paragraphSpaceStyle.valueSize = sizeof(CGFloat);
        paragraphSpaceStyle.value = &paragraphSpacings;
        
        //创建设置数组
        CTParagraphStyleSetting settings[ ] ={alignmentStyle,lineSpaceStyle,paragraphSpaceStyle};
        CTParagraphStyleRef style = CTParagraphStyleCreate(settings ,3);
        
        //给文本添加设置
        [attributedString addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)style range:NSMakeRange(0 , [attributedString length])];
//        CFRelease(helveticaBold);
    }
}

/*
 *覆写setText方法
 */
- (void) setText:(NSString *)text{
    [super setText:text];
    [self initAttributedString];
}
/*
 *开始绘制
 */
-(void) drawTextInRect:(CGRect)requestedRect{
    [self initAttributedString];
    //排版
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    
    CGMutablePathRef leftColumnPath = CGPathCreateMutable();
    
    CGPathAddRect(leftColumnPath, NULL ,CGRectMake(0 , 0 ,self.bounds.size.width , self.bounds.size.height));
    
    CTFrameRef leftFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, 0), leftColumnPath , NULL);
    
    //翻转坐标系统（文本原来是倒的要翻转下）
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
    
    CGContextTranslateCTM(context , 0 ,self.bounds.size.height);
    
    CGContextScaleCTM(context, 1.0 ,-1.0);
    
    //画出文本
    
    CTFrameDraw(leftFrame,context);
    
    //释放
    
    CGPathRelease(leftColumnPath);
    
    CFRelease(framesetter);
    
    UIGraphicsPushContext(context);
}

/*
 *绘制前获取label高度
 */
- (int)getAttributedStringHeightWidthValue:(int)width{
    [self initAttributedString];
    
    int total_height = 0;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);    //string 为要计算高度的NSAttributedString
    CGRect drawingRect = CGRectMake(0, 0, width, 100000);  //这里的高要设置足够大
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    int line_y = (int) origins[[linesArray count] -1].y;  //最后一行line的原点y坐标
    
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    total_height = 100000 - line_y + (int) descent +1;//+1为了纠正descent转换成int小数点后舍去的值
    
    CFRelease(textFrame);
    
    return total_height + 3;
}
@end
