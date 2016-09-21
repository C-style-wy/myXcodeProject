//
//  SectionView.m
//  henews250
//
//  Created by 汪洋 on 16/7/21.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SectionView.h"
#import "UILabel+NeedWidthAndHeight.h"

@implementation SectionView {
    NodeMode *_nodeMode;
    NSInteger _section;
}

- (id)initWithData:(NodeMode *)nodeMode section:(NSInteger)section{
    self = [super init];
    if (self) {
        _nodeMode = nodeMode;
        if (_nodeMode && _nodeMode.nodeName && ![_nodeMode.nodeName isEqualToString:@""]) {
            _modulNameWidth.constant = [_modulName needWidthWithText:_nodeMode.nodeName];
            _modulName.text = _nodeMode.nodeName;
            if ([_nodeMode.displayType intValue] == WeatherMode) {
                _changeBtn.hidden = YES;
                _changeIcon.hidden = YES;
                _changeLabel.hidden = YES;
                
                _timeLabel.hidden = NO;
                _timeLabel.text = [self getWeek];
            }else{
                _changeBtn.hidden = NO;
                _changeIcon.hidden = NO;
                _changeLabel.hidden = NO;
                
                _timeLabel.hidden = YES;
            }
        }
        _section = section;
    }
    return self;
}
- (IBAction)moreBtnSelect:(id)sender {
    if ([self.delegate respondsToSelector:@selector(jumpToMore:)]) {
        [self.delegate jumpToMore:_nodeMode];
    }
}
- (IBAction)changeBtnSelect:(id)sender {
    if ([self.delegate respondsToSelector:@selector(requestSectionChange:section:)]) {
        [self addAnimation];
        
        [self.delegate requestSectionChange:_nodeMode.changeUrl section:_section];
    }
}


-(void)addAnimation{
    //加按钮的旋转动画
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    theAnimation.duration=0.3f;
    theAnimation.removedOnCompletion = NO;
//    theAnimation.delegate = self;
    theAnimation.fromValue = [NSNumber numberWithFloat:0];
    theAnimation.toValue = [NSNumber numberWithFloat:2*PI];
    [_changeIcon.layer addAnimation:theAnimation forKey:@"animateTransform"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self addAnimation];
}

- (NSString *)getWeek
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    now = [NSDate date];
    comps = [calendar components:unitFlags fromDate:[NSDate date]];
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSString *weekDayString = [NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:[comps weekday] - 1]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    NSString *dateString = [dateFormatter stringFromDate:now];
    
    return [[dateString stringByAppendingString:@" "] stringByAppendingString:weekDayString];
}
@end
