//
//  OneBigPicCell.m
//  henews
//
//  Created by 汪洋 on 15/11/10.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "OneBigPicCell.h"
#import "APIStringMacros.h"
#import "UIImageView+AFNetworking.h"

@implementation OneBigPicCell

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
    static NSString *identifier = @"oneBigPicCell";
    // 1.缓存中取
    OneBigPicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[OneBigPicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
        UIImageView *line = [[UIImageView alloc]init];
        line.frame = CGRectMake(0, 170.5f, SCREEN_WIDTH, 0.5f);
        line.image = [UIImage imageNamed:@"menuFenge.png"];
        [self addSubview:line];
        
        UIView *defaultView = [[UIView alloc]initWithFrame:CGRectMake(8, 35.5f, SCREEN_WIDTH-16, 101)];
        defaultView.backgroundColor = DEFAULTCOLOR;
        
        UIImageView *defaultImage = [[UIImageView alloc]init];
        defaultImage.frame = CGRectMake((SCREEN_WIDTH-61)/2, 28, 45, 45);
        [defaultImage setImage:[UIImage imageNamed:@"newsBigBg.png"]];
        [defaultView addSubview:defaultImage];
        [self addSubview:defaultView];
        
        UIImageView *pic = [[UIImageView alloc]init];
        pic.frame = CGRectMake(8, 35.0f, SCREEN_WIDTH-16, 101);
        pic.contentMode = UIViewContentModeScaleAspectFill;
        [pic setContentScaleFactor:[[UIScreen mainScreen]scale]];
        pic.clipsToBounds  = YES;
        [self addSubview:pic];
        self.cellPic = pic;
        
        UILabel *name = [[UILabel alloc]init];
        name.font = [UIFont systemFontOfSize:15.0f];
        name.textColor = [UIColor colorWithRed:0.02 green:0.02 blue:0.02 alpha:1];
        name.numberOfLines = 1;
        [self addSubview:name];
        self.cellName = name;
        
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
        
        UIImageView *icon = [[UIImageView alloc]init];
        [icon setImage:[UIImage imageNamed:@"newsearlybus_icon.png"]];
        icon.frame = CGRectMake(17.5, 115, 31, 31);
        icon.contentMode = UIViewContentModeScaleAspectFill;
        [icon setContentScaleFactor:[[UIScreen mainScreen]scale]];
        icon.clipsToBounds  = YES;
        [self addSubview:icon];
        self.busIcon = icon;
    }
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    return self;
}

-(void)loadTableCell:(CellData*)data{
    [self.cellPic setImage:[UIImage imageNamed:@""]];
    if (![data.images isEqual:@""]) {
        [self.cellPic setImageWithURL:[NSURL URLWithString:data.images]];
    }
    self.cellName.text = data.newsTitle;
    self.cellName.frame = CGRectMake(8, 0, SCREEN_WIDTH-16, 35.0f);
    NSString *strs;
    if ([data.source isEqual:@""]) {
        strs = data.createTime;
    }else{
        strs = [data.source stringByAppendingString:@"  "];
        strs = [strs stringByAppendingString:data.createTime];
    }
    self.pubTime.text = strs;
    self.pubTime.frame = CGRectMake(8, 136, SCREEN_WIDTH-16, 35);
    self.pv.text = [data.pv stringByAppendingString:@"阅"];
    self.pv.frame = CGRectMake(8, 136, SCREEN_WIDTH-16, 35);
    if ([data.displayType isEqual:NEWS_EARLY_BUS]) {
        self.busIcon.hidden = NO;
    }else{
        self.busIcon.hidden = YES;
    }
}

@end
