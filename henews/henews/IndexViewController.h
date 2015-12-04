//
//  IndexViewController.h
//  henews
//
//  Created by 汪洋 on 15/10/15.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIStringMacros.h"
#import "ProgramaStructure.h"
#import "AdviceData.h"

@interface IndexViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, retain)UIView *adviceView;
@property (nonatomic, retain)AdviceData *adviceData;
@end
