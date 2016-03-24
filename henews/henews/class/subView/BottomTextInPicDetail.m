//
//  BottomTextInPicDetail.m
//  henews
//
//  Created by 汪洋 on 16/3/22.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BottomTextInPicDetail.h"
#import "SHLUILabel.h"

@interface BottomTextInPicDetail ()
{
    UILabel *nameLabel;
    SHLUILabel *descLabel;
    
    UILabel *indexLabel;
    UILabel *totalLabel;
    
    int totalNum;
}

@end

@implementation BottomTextInPicDetail

- (id)initWithTotalNumPic:(int)num{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
        nameLabel.font = [UIFont systemFontOfSize:15.0f];
        nameLabel.numberOfLines = 0;
        [self addSubview:nameLabel];
        
//        descLabel = [[SHLUILabel alloc]init];
//        descLabel.textColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
//        descLabel.font = [UIFont systemFontOfSize:13.0f];
//        descLabel.textAlignment = NSTextAlignmentJustified;
//        descLabel.backgroundColor = [UIColor clearColor];
//        descLabel.numberOfLines = 0;
//        descLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        [self addSubview:descLabel];
        
        indexLabel = [[UILabel alloc]init];
        indexLabel.textColor = [UIColor whiteColor];
        indexLabel.numberOfLines = 1;
        indexLabel.font = [UIFont systemFontOfSize:17.0f];
        indexLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:indexLabel];
        
        totalLabel = [[UILabel alloc]init];
        totalLabel.textColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
        totalLabel.font = [UIFont systemFontOfSize:12.0f];
        totalLabel.numberOfLines = 1;
        [self addSubview:totalLabel];
        
        totalNum = num;
    }
    return self;
}

- (void)setTextPostion:(picDetailData *)data curIndex:(int)index title:(NSString *)title{
//    [UIView animateWithDuration:0.3f animations:^{
//        self.alpha = 0.0f;
//    }completion:^(BOOL finished) {
        UIFont *nameFnt = nameLabel.font;
        NSDictionary *nameAtr = @{NSFontAttributeName: nameFnt};
        CGFloat nameHeight = TEXTHEIGHT(title, nameAtr, SCREEN_WIDTH-8-61);
        
        nameLabel.text = title;
        nameLabel.frame = CGRectMake(8.0f, 4.0f, SCREEN_WIDTH-8-61, nameHeight);
    
        CGFloat descHeight = 0.0f;
        if (descLabel) {
            [descLabel removeFromSuperview];
            descLabel = nil;
        }
        if (data.desc && ![data.desc isEqualToString:@""]) {
            
            descLabel = [[SHLUILabel alloc]init];
            descLabel.textColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
            descLabel.font = [UIFont systemFontOfSize:13.0f];
            descLabel.textAlignment = NSTextAlignmentJustified;
            descLabel.backgroundColor = [UIColor clearColor];
            descLabel.numberOfLines = 0;
            descLabel.lineBreakMode = NSLineBreakByWordWrapping;
            [self addSubview:descLabel];
            descLabel.text = data.desc;
            descHeight = [descLabel getAttributedStringHeightWidthValue:SCREEN_WIDTH-16];
            descLabel.frame = CGRectMake(8.0f, nameLabel.frame.origin.y+nameLabel.frame.size.height+6.0f, SCREEN_WIDTH-16.0f, descHeight);
        }
        self.frame = CGRectMake(0, SCREEN_HEIGHT-(nameLabel.frame.size.height+descHeight+4+6+10), SCREEN_WIDTH, nameLabel.frame.size.height+descHeight+4+6+10);
        
        NSString *str = @"/";
        NSString *strTotal = [str stringByAppendingString:[NSString stringWithFormat:@"%d",totalNum]];
        totalLabel.text = strTotal;
        UIFont *fnt = totalLabel.font;
        NSDictionary *atr = @{NSFontAttributeName: fnt};
        CGFloat w = TEXTWIDTH(strTotal, atr, 17.0f);
        totalLabel.frame = CGRectMake(SCREEN_WIDTH-w-8, 6, w, 17);
        
        indexLabel.text = [NSString stringWithFormat:@"%d",index];
        indexLabel.frame = CGRectMake(totalLabel.frame.origin.x - 40, 5, 40, 18);
//    }];
    
//    [UIView animateWithDuration:0.5f animations:^{
//        self.alpha = 1.0f;
//    }];
}

@end
