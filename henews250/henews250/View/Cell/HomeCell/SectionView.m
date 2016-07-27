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
    theAnimation.delegate = self;
    theAnimation.fromValue = [NSNumber numberWithFloat:0];
    theAnimation.toValue = [NSNumber numberWithFloat:2*PI];
    [_changeIcon.layer addAnimation:theAnimation forKey:@"animateTransform"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self addAnimation];
}
@end
