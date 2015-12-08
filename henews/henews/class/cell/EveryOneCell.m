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
        line.frame = CGRectMake(0, 95.5f, SCREEN_WIDTH, 0.5f);
        line.image = [UIImage imageNamed:@"menuFenge.png"];
        [self addSubview:line];
        _line = line;
        
        UIView *defaultView = [[UIView alloc]initWithFrame:CGRectMake(8, 15.0f, 84, 66)];
        defaultView.backgroundColor = DEFAULTCOLOR;
        
        UIImageView *defaultImage = [[UIImageView alloc]init];
        defaultImage.frame = CGRectMake(28.5f, 19.5f, 27, 27);
        [defaultImage setImage:[UIImage imageNamed:@"newsBigBg.png"]];
        [defaultView addSubview:defaultImage];
        [self addSubview:defaultView];
        
        UIImageView *pic = [[UIImageView alloc]init];
        pic.frame = CGRectMake(8, 15.0f, 84, 66);
        pic.contentMode = UIViewContentModeScaleAspectFill;
        [pic setContentScaleFactor:[[UIScreen mainScreen]scale]];
        pic.clipsToBounds  = YES;
        [self addSubview:pic];
        self.cellPic = pic;
        
        UILabel *name = [[UILabel alloc]init];
        name.font = [UIFont systemFontOfSize:15.0f];
        name.textColor = [UIColor colorWithRed:0.02 green:0.02 blue:0.02 alpha:1];
        name.frame = CGRectMake(101, 12, 211, 18);
        name.numberOfLines = 2;
        [self addSubview:name];
        self.cellName = name;
        
        UILabel *summary = [[UILabel alloc]init];
        summary.numberOfLines = 3;
        summary.font = [UIFont systemFontOfSize:12.5f];
        summary.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1];
        [self addSubview:summary];
        self.cellSummary = summary;
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
    self.cellSummary.text = data.newsIntro;
    if (isShort) {
        _line.frame = CGRectMake(8, 95.5f, SCREEN_WIDTH-16, 0.5f);
    }
    if (isWhite) {
        self.backgroundColor = [UIColor whiteColor];
    }else{
        self.backgroundColor = VIEWBACKGROUND_COLOR;
    }
    _line.hidden = hide;
    
    UIFont *fnt = self.cellName.font;
    NSDictionary *attribute = @{NSFontAttributeName: fnt};
    CGFloat height = TEXTHEIGHT(data.newsTitle, attribute, self.cellName.frame.size.width);
    if (height > 18) {
        self.cellName.frame = CGRectMake(101, 12, 211, 36);
        self.cellSummary.frame = CGRectMake(101, 50, 211, 32);
    }else{
        self.cellName.frame = CGRectMake(101, 12, 211, 18);
        self.cellSummary.frame = CGRectMake(101, 32, 211, 50);
    }
}


@end
