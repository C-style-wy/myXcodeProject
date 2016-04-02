//
//  Dialog.m
//  henews
//
//  Created by 汪洋 on 16/3/31.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "Dialog.h"
#import <QuartzCore/QuartzCore.h>
#import "APIStringMacros.h"
#import "SHLUILabel.h"
#import "UIView+Screen.h"

@implementation Dialog{
    LeftBlock _leftBlock;
    RightBlock _rightBlock;
    BOOL _leftAction;
    UIImageView *_bgImageView;
}

+ (void)showWithTipText:(NSString *)tipText descText:(NSString *)descText LeftText:(NSString *)leftText rightText:(NSString *)rightText LeftBlock:(LeftBlock)leftBlock RightBlock:(RightBlock)rightBlock{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    Dialog *dialog = [[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
    dialog.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
    [keyWindow addSubview:dialog];
    //弹出框
    [dialog contentViewWithTipText:tipText descText:descText LeftText:leftText rightText:rightText leftBlock:leftBlock RightBlock:rightBlock];
}

- (void)contentViewWithTipText:(NSString *)tipText descText:(NSString *)descText LeftText:(NSString *)leftText rightText:(NSString *)rightText leftBlock:(LeftBlock)leftBlock RightBlock:(RightBlock)rightBlock{
    _leftBlock = leftBlock;
    _rightBlock = rightBlock;
    
    UIButton *bgBtn = [[UIButton alloc]initWithFrame:self.bounds];
    [self addSubview:bgBtn];
    bgBtn.backgroundColor = [UIColor clearColor];
    [bgBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    
    UIViewController *currentViewController = [self getCurrentVC];
    UIImage *fuzzyImage = [currentViewController.view getFuzzyImage:0.2];
    _bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _bgImageView.image = fuzzyImage;
    [self addSubview:_bgImageView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(31, 0, SCREEN_WIDTH-62, 103)];
    view.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    view.backgroundColor = [UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 6.0;
    [self addSubview:view];

    //提示部分
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, 28.5f)];
    headView.backgroundColor = [UIColor clearColor];
    [view addSubview:headView];
    
    UIView *redLine = [[UIView alloc]initWithFrame:CGRectMake(17.5f, headView.frame.size.height-2, headView.frame.size.width-2*17.5f, 2)];
    redLine.backgroundColor = ROSERED;
    [headView addSubview:redLine];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, headView.frame.size.width, headView.frame.size.height-2)];
    [headView addSubview:tipLabel];
    tipLabel.textColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00];
    tipLabel.font = [UIFont systemFontOfSize:13.5f];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = tipText;
    //描述部分
    float distance = 4;
    SHLUILabel *contentLab = [[SHLUILabel alloc] init];
    contentLab.font = [UIFont systemFontOfSize:16];;
    contentLab.text = descText;
    
    contentLab.textColor = [UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.00];
    contentLab.lineBreakMode = NSLineBreakByWordWrapping;
    contentLab.numberOfLines = 0;
    //根据字符串长度和Label显示的宽度计算出contentLab的高
    float labelHeight = [contentLab getAttributedStringHeightWidthValue:redLine.frame.size.width];
    contentLab.frame = CGRectMake(distance, 7, redLine.frame.size.width, labelHeight);
    
    float descScrollH = labelHeight + 14;
    if (descScrollH > 300) {
        descScrollH = 300;
    }
    
    UIScrollView *descScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(redLine.frame.origin.x-distance, CGRectGetMaxY(headView.frame), redLine.frame.size.width+2*distance, descScrollH)];
    descScroll.showsHorizontalScrollIndicator = NO;
    descScroll.showsVerticalScrollIndicator = YES;
    descScroll.pagingEnabled = NO;
    descScroll.bounces = YES;
    descScroll.contentSize = CGSizeMake(0, labelHeight + 14);
    
    [view addSubview:descScroll];
    [descScroll addSubview:contentLab];
    //按钮部分
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(descScroll.frame), view.frame.size.width, 37.0f)];
    [view addSubview:footView];
    view.frame = CGRectMake(31, 0, SCREEN_WIDTH-62, CGRectGetMaxY(footView.frame));
    view.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    
    UIView *horizontalLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, footView.frame.size.width, 1)];
    horizontalLine.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    [footView addSubview:horizontalLine];
    
    UIView *verticalLine = [[UIView alloc]initWithFrame:CGRectMake((footView.frame.size.width-1)/2, 0, 1, footView.frame.size.height)];
    verticalLine.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    [footView addSubview:verticalLine];
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, footView.frame.size.width/2, footView.frame.size.height)];
    [leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:leftBtn.bounds];
    [leftBtn addSubview:leftLabel];
    leftLabel.textColor = ROSERED;
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.font = [UIFont systemFontOfSize:16];
    leftLabel.text = leftText;
    [footView addSubview:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(footView.frame.size.width/2, 0, footView.frame.size.width/2, footView.frame.size.height)];
    [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *rightLabel = [[UILabel alloc]initWithFrame:rightBtn.bounds];
    [rightBtn addSubview:rightLabel];
    rightLabel.textColor = ROSERED;
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.font = [UIFont systemFontOfSize:16];
    rightLabel.text = rightText;
    [footView addSubview:rightBtn];
    
    view.alpha = 0;
    view.transform = CGAffineTransformMakeScale(0.01, 0.01);
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0];
    _bgImageView.alpha = 0;
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:15 options:UIViewAnimationOptionCurveEaseOut animations:^{
        view.alpha = 1.0;
        view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.99];
        _bgImageView.alpha = 0.9;
    } completion:^(BOOL finished) {
        
    }];
    _leftAction = YES;
}

- (void)leftBtnAction:(UIButton *)button{
    _leftAction = YES;
    [self closeView];
}

- (void)rightBtnAction:(UIButton *)button{
    _leftAction = NO;
    [self closeView];
}

-(void)closeView{
    [UIView animateWithDuration:0.3f animations:^{
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0];
        [self.subviews objectAtIndex:2].alpha = 0;
        [self.subviews objectAtIndex:2].transform = CGAffineTransformMakeScale(0.01, 0.01);
        _bgImageView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (_leftAction) {
            _leftBlock();
        }else{
            _rightBlock();
        }
    }];
}


//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
@end
