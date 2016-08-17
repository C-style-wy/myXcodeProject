//
//  CityListCell.h
//  henews250
//
//  Created by 汪洋 on 16/8/16.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (weak, nonatomic) IBOutlet UIImageView *line;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setCityName:(NSString *)cityName hiddenLine:(BOOL)hidden;

@end
