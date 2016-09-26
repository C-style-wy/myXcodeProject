//
//  NewsDetailViewController.h
//  henews250
//
//  Created by 汪洋 on 16/9/7.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SubBaseViewController.h"
#import "HideDeleteMode.h"

@interface NewsDetailViewController : SubBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@property (nonatomic, retain) HideDeleteMode *deleteData;

@end
