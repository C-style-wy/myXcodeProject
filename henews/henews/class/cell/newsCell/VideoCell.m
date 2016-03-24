//
//  VideoCell.m
//  henews
//
//  Created by 汪洋 on 16/3/24.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "VideoCell.h"
#import "APIStringMacros.h"
#import "UIImageView+AFNetworking.h"

@implementation VideoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"VideoCell";
    // 1.缓存中取
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[VideoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
        UIImageView *line = [[UIImageView alloc]init];
        line.frame = CGRectMake(0, 216.5f, SCREEN_WIDTH, 0.5f);
        line.image = [UIImage imageNamed:@"menuFenge.png"];
        [self addSubview:line];
        _line = line;
        
        UIView *defaultView = [[UIView alloc]initWithFrame:CGRectMake(8, 35.5f, SCREEN_WIDTH-16, 146.5f)];
        defaultView.backgroundColor = DEFAULTCOLOR;
        
        UIImageView *defaultImage = [[UIImageView alloc]init];
        defaultImage.frame = CGRectMake((defaultView.frame.size.width-45)/2, (defaultView.frame.size.height - 45)/2, 45, 45);
        [defaultImage setImage:[UIImage imageNamed:@"newsBigBg.png"]];
        [defaultView addSubview:defaultImage];
        [self addSubview:defaultView];
        
        UIImageView *pic = [[UIImageView alloc]init];
        pic.frame = CGRectMake(8, 35.5f, SCREEN_WIDTH-16, 146.5f);
        pic.contentMode = UIViewContentModeScaleAspectFill;
        [pic setContentScaleFactor:[[UIScreen mainScreen]scale]];
        pic.clipsToBounds = YES;
        [self addSubview:pic];
        self.cellPic = pic;
        
        UIImageView *playIcon = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-38)/2, (217-38)/2, 38, 38)];
        playIcon.image = [UIImage imageNamed:@"playIconNew.png"];
        [self addSubview:playIcon];
        
        UILabel *name = [[UILabel alloc]init];
        name.font = [UIFont systemFontOfSize:15.0f];
        name.textColor = [UIColor colorWithRed:0.02 green:0.02 blue:0.02 alpha:1];
        name.numberOfLines = 1;
        [self addSubview:name];
        self.cellName = name;
        
        //底部时间和阅读书视图
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(8, (pic.frame.origin.y+pic.frame.size.height), SCREEN_WIDTH-18, 35)];
        [self addSubview:bottomView];
        
        UILabel *time = [[UILabel alloc]init];
        time.font = [UIFont systemFontOfSize:12.5f];
        time.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1];
        [bottomView addSubview:time];
        self.pubTime = time;
        
        UILabel *pv = [[UILabel alloc]init];
        pv.font = [UIFont systemFontOfSize:12.5f];
        pv.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1];
        pv.textAlignment = NSTextAlignmentRight;
        [bottomView addSubview:pv];
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

-(void)loadTableCell:(CellData*)data isShortLine:(BOOL)isShort isWhiteBg:(BOOL)isWhite isHideLine:(BOOL)hide{
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
    self.pubTime.frame = CGRectMake(0, 0, SCREEN_WIDTH-16, 35);
    self.pv.text = [data.pv stringByAppendingString:@"阅"];
    self.pv.frame = CGRectMake(0, 0, SCREEN_WIDTH-16, 35);
    if ([data.displayType isEqual:NEWS_EARLY_BUS]) {
        self.busIcon.hidden = NO;
    }else{
        self.busIcon.hidden = YES;
    }
    if (isShort) {
        _line.frame = CGRectMake(8, 216.5f, SCREEN_WIDTH-16, 0.5f);
    }
    if (isWhite) {
        self.backgroundColor = [UIColor whiteColor];
    }else{
        self.backgroundColor = VIEWBACKGROUND_COLOR;
    }
    _line.hidden = hide;
}

@end
