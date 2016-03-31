//
//  topicHeadData.m
//  henews
//
//  Created by 汪洋 on 16/3/30.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "topicHeadData.h"
#import "SHLUILabel.h"

@implementation topicHeadData

-(id)init{
    self = [super init];
    if (self) {
        self.images = @"";
        self.topicIntro = @"";
        self.height = 0;
        self.introFrame = CGRectZero;
    }
    return self;
}

-(void)initWithPic:(NSString *)pic topicIntro:(NSString *)topicIntro{
    if (pic && ![pic isEqualToString:@""]) {
        self.images = pic;
    }
    if (topicIntro && ![topicIntro isEqualToString:@""]) {
        self.topicIntro = topicIntro;
        
        SHLUILabel *contentLab = [[SHLUILabel alloc] init];
        contentLab.font = [UIFont systemFontOfSize:13.5f];
        contentLab.text = topicIntro;
        
        //设置字体颜色
        contentLab.lineBreakMode = NSLineBreakByWordWrapping;
        contentLab.numberOfLines = 0;
        //根据字符串长度和Label显示的宽度计算出contentLab的高
        float labelHeight = [contentLab getAttributedStringHeightWidthValue:SCREEN_WIDTH-16];
        self.height = labelHeight+146+12;
        
        self.introFrame = CGRectMake(8, 146+6, SCREEN_WIDTH-16, labelHeight);
    }
}
@end
