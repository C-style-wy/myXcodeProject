//
//  CityListCell.m
//  henews250
//
//  Created by 汪洋 on 16/8/16.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "CityListCell.h"

@implementation CityListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifer = @"CityListCell";
    CityListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CityListCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)prepareForReuse {
    [super prepareForReuse];
}

- (void)setCityName:(NSString *)cityName hiddenLine:(BOOL)hidden {
    self.line.hidden = hidden;
    self.cityName.text = cityName;
}
@end
