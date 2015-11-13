//
//  EveryOneCell.m
//  henews
//
//  Created by 汪洋 on 15/11/10.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "EveryOneCell.h"
#import "APIStringMacros.h"
#import "UIImageView+AFNetworking.h"

@implementation EveryOneCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"EveryOneCell";
    // 1.缓存中取
    EveryOneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[EveryOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
        UIImageView *line = [[UIImageView alloc]init];
        line.frame = CGRectMake(0, 80.5f, SCREEN_WIDTH, 0.5f);
        line.image = [UIImage imageNamed:@"menuFenge.png"];
        [self addSubview:line];
        
        UIView *defaultView = [[UIView alloc]initWithFrame:CGRectMake(8, 11.5f, 72, 58)];
        defaultView.backgroundColor = DEFAULTCOLOR;
        
        UIImageView *defaultImage = [[UIImageView alloc]init];
        defaultImage.frame = CGRectMake(22.5f, 15.5f, 27, 27);
        [defaultImage setImage:[UIImage imageNamed:@"newsBigBg.png"]];
        [defaultView addSubview:defaultImage];
        [self addSubview:defaultView];
        
        UIImageView *pic = [[UIImageView alloc]init];
        pic.frame = CGRectMake(8, 11.5f, 72, 58);
        pic.contentMode = UIViewContentModeScaleAspectFill;
        [pic setContentScaleFactor:[[UIScreen mainScreen]scale]];
        pic.clipsToBounds  = YES;
        [self addSubview:pic];
        self.cellPic = pic;
        
        UILabel *name = [[UILabel alloc]init];
        name.font = [UIFont systemFontOfSize:15.0f];
        name.textColor = [UIColor colorWithRed:0.02 green:0.02 blue:0.02 alpha:1];
        name.frame = CGRectMake(101, 12, 211, 36);
        name.numberOfLines = 2;
        [self addSubview:name];
        self.cellName = name;
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
    NSString *strs;
    if ([data.source isEqual:@""]) {
        strs = data.createTime;
    }else{
        strs = [data.source stringByAppendingString:@"  "];
        strs = [strs stringByAppendingString:data.createTime];
    }
}


@end
