//
//  HomeController.h
//  henews250
//
//  Created by 汪洋 on 16/7/7.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface HomeController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;

@property (weak, nonatomic) IBOutlet UIButton *setBtn;
@property (weak, nonatomic) IBOutlet UILabel *cityName;


@end
