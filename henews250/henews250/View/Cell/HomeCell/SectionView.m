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
}

- (id)initWithData:(NodeMode *)nodeMode section:(NSInteger)section{
    self = [super init];
    if (self) {
        _nodeMode = nodeMode;
        if (_nodeMode && _nodeMode.nodeName && ![_nodeMode.nodeName isEqualToString:@""]) {
            _modulNameWidth.constant = [_modulName neetWidthWithText:_nodeMode.nodeName];
            _modulName.text = _nodeMode.nodeName;
        }
    }
    return self;
}
- (IBAction)moreBtnSelect:(id)sender {
    NSLog(@"moreBtnSelect====");
}
- (IBAction)changeBtnSelect:(id)sender {
    NSLog(@"changeBtnSelect====");
}

@end
