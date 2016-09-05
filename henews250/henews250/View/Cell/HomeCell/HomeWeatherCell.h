//
//  HomeWeatherCell.h
//  henews250
//
//  Created by 汪洋 on 16/9/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"

@interface HomeWeatherCell : BaseCell
@property (weak, nonatomic) IBOutlet UIImageView *todayImg;
@property (weak, nonatomic) IBOutlet UILabel *todayWenDuLable;
@property (weak, nonatomic) IBOutlet UILabel *fengLi;
@property (weak, nonatomic) IBOutlet UILabel *todayweatherLable;

@property (weak, nonatomic) IBOutlet UILabel *time1;
@property (weak, nonatomic) IBOutlet UIImageView *weatherimg1;
@property (weak, nonatomic) IBOutlet UILabel *wendu1;

@property (weak, nonatomic) IBOutlet UILabel *time2;
@property (weak, nonatomic) IBOutlet UIImageView *weatherimg2;
@property (weak, nonatomic) IBOutlet UILabel *wendu2;

@property (weak, nonatomic) IBOutlet UILabel *time3;
@property (weak, nonatomic) IBOutlet UIImageView *weatherimg3;
@property (weak, nonatomic) IBOutlet UILabel *wendu3;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setNews:(BOOL)hidden;

@end
