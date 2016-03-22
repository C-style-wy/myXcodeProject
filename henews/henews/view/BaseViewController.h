//
//  BaseViewController.h
//  henews
//
//  Created by 汪洋 on 16/3/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageHead.h"
#import "APIStringMacros.h"
#import "Request.h"

@interface BaseViewController : UIViewController<PageHeadDelegate>
@property (nonatomic, retain)PageHead *head;
@end
