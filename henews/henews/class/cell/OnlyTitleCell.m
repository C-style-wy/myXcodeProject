//
//  OnlyTitleCell.m
//  henews
//
//  Created by 汪洋 on 15/11/3.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "OnlyTitleCell.h"
#import "APIStringMacros.h"

@implementation OnlyTitleCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // NSLog(@"cellForRowAtIndexPath");
    static NSString *identifier = @"OnlyTitleCell";
    // 1.缓存中取
    OnlyTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[OnlyTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
        UIImageView *line = [[UIImageView alloc]init];
        line.frame = CGRectMake(0, 79.5f, SCREEN_WIDTH, 0.5f);
        line.image = [UIImage imageNamed:@"menuFenge.png"];
        [self addSubview:line];
        
        UILabel *name = [[UILabel alloc]init];
        name.font = [UIFont systemFontOfSize:15.0f];
        name.textColor = [UIColor colorWithRed:0.02 green:0.02 blue:0.02 alpha:1];
        name.numberOfLines = 2;
        [self addSubview:name];
        self.cellName = name;
        
        UILabel *summary = [[UILabel alloc]init];
        summary.font = [UIFont systemFontOfSize:12.5f];
        summary.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1];
        [self addSubview:summary];
        self.cellSummary = summary;
        
        UILabel *time = [[UILabel alloc]init];
        time.font = [UIFont systemFontOfSize:12.5f];
        time.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1];
        [self addSubview:time];
        self.pubTime = time;
        
        UILabel *pv = [[UILabel alloc]init];
        pv.font = [UIFont systemFontOfSize:12.5f];
        pv.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1];
        pv.textAlignment = NSTextAlignmentRight;
        [self addSubview:pv];
        self.pv = pv;
    }
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    return self;
}

-(void)loadTableCell:(CellData*)data{
    self.cellName.text = data.newsTitle;
    self.cellName.frame = CGRectMake(8, 11, SCREEN_WIDTH-16, 18);
    
    self.cellSummary.text = data.newsIntro;
    self.cellSummary.frame = CGRectMake(8, 32, SCREEN_WIDTH-16, 15);
    NSString *strs;
    if ([data.source isEqual:@""]) {
        strs = data.createTime;
    }else{
        strs = [data.source stringByAppendingString:@"  "];
        strs = [strs stringByAppendingString:data.createTime];
    }
    self.pubTime.text = strs;
    self.pubTime.frame = CGRectMake(8, 55, SCREEN_WIDTH-16, 15);
    NSString *pvLabel = [data.pv stringByAppendingString:@"阅"];
    self.pv.frame = CGRectMake(8, 55, SCREEN_WIDTH-18, 15);
    self.pv.text = pvLabel;
}

@end
