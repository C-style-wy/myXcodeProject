//
//  TopicSectionView.m
//  henews250
//
//  Created by 汪洋 on 2016/11/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TopicSectionView.h"

@implementation TopicSectionView

- (IBAction)sectionBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(sectionBtnAction: name:)]) {
        [self.delegate sectionBtnAction:_specialNodeListModel.url name:_specialNodeListModel.nodeName];
    }
}

- (void)setSpecialNodeListModel:(SpecialNodeListModel *)specialNodeListModel {
    _specialNodeListModel = specialNodeListModel;
    if (_specialNodeListModel.isMore && [_specialNodeListModel.isMore isEqualToString:@"1"]) {
        self.sectionBtn.hidden = NO;
    }else{
        self.sectionBtn.hidden = YES;
    }
    self.sectionLabel.text = _specialNodeListModel.nodeName;
}
@end
