//
//  PicViewController.h
//  henews250
//
//  Created by 汪洋 on 16/9/19.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SubBaseViewController.h"
#import "NewsDetailMode.h"

@interface PicViewController : SubBaseViewController
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrolView;

@property (weak, nonatomic) IBOutlet UIView *picHead;
@property (weak, nonatomic) IBOutlet UIView *picFoot;

@property (nonatomic, retain) NewsDetailMode *picDetailData;

@end
