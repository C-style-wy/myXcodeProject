//
//  BottomTextInPicDetail.h
//  henews
//
//  Created by 汪洋 on 16/3/22.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIStringMacros.h"
#import "picDetailData.h"

@interface BottomTextInPicDetail : UIView

- (id)initWithTotalNumPic:(int)num;

- (void)setTextPostion:(picDetailData *)data curIndex:(int)index title:(NSString *)title;
@end
