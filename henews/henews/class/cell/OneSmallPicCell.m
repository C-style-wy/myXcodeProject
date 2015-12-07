//
//  OneSmallPicCell.m
//  henews
//
//  Created by 汪洋 on 15/11/2.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "OneSmallPicCell.h"
#import "APIStringMacros.h"
#import "UIImageView+AFNetworking.h"

@implementation OneSmallPicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
     static NSString *identifier = @"oneSmallPic";
     // 1.缓存中取
     OneSmallPicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
     // 2.创建
     if (cell == nil) {
         cell = [[OneSmallPicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
     }
     return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
         self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
         UIImageView *line = [[UIImageView alloc]init];
         line.frame = CGRectMake(0, 87.5f, SCREEN_WIDTH, 0.5f);
         line.image = [UIImage imageNamed:@"menuFenge.png"];
         [self addSubview:line];
         _line = line;
         
         UIView *defaultView = [[UIView alloc]initWithFrame:CGRectMake(8, 11, 85, 66)];
         defaultView.backgroundColor = DEFAULTCOLOR;
         
         UIImageView *defaultImage = [[UIImageView alloc]init];
         defaultImage.frame = CGRectMake(29, 19.5f, 27, 27);
         [defaultImage setImage:[UIImage imageNamed:@"newsBigBg.png"]];
         [defaultView addSubview:defaultImage];
         [self addSubview:defaultView];
         
         UIImageView *pic = [[UIImageView alloc]init];
         pic.frame = CGRectMake(8, 11, 85, 66);
         pic.contentMode = UIViewContentModeScaleAspectFill;
         [pic setContentScaleFactor:[[UIScreen mainScreen]scale]];
         pic.clipsToBounds  = YES;
         [self addSubview:pic];
         self.cellPic = pic;
         
         UILabel *name = [[UILabel alloc]init];
         name.font = [UIFont systemFontOfSize:15.0f];
         name.textColor = [UIColor colorWithRed:0.02 green:0.02 blue:0.02 alpha:1];
         name.frame = CGRectMake(101, 10.5f, 211, 18);
         name.numberOfLines = 2;
         [self addSubview:name];
         self.cellName = name;
         
         UILabel *summary = [[UILabel alloc]init];
         summary.font = [UIFont systemFontOfSize:12.5f];
         summary.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1];
         summary.frame = CGRectMake(101, 31, 211, 18);
         summary.numberOfLines = 2;
         [self addSubview:summary];
         self.summary = summary;
         
         UILabel *time = [[UILabel alloc]init];
         time.font = [UIFont systemFontOfSize:12.5f];
         time.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1];
         time.frame = CGRectMake(101, 63, 211, 15);
         [self addSubview:time];
         self.pubTime = time;
         
         UILabel *pv = [[UILabel alloc]init];
         pv.font = [UIFont systemFontOfSize:12.5f];
         pv.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1];
         pv.frame = CGRectMake(101, 63, 211, 15);
         pv.textAlignment = NSTextAlignmentRight;
         [self addSubview:pv];
         self.pv = pv;
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
    self.summary.text = data.newsIntro;
    
    NSString *strs;
    if ([data.source isEqual:@""]) {
        strs = data.createTime;
    }else{
        strs = [data.source stringByAppendingString:@"  "];
        strs = [strs stringByAppendingString:data.createTime];
    }
    self.pubTime.text = strs;
    
    self.pv.text = [data.pv stringByAppendingString:@"阅"];
    if (isShort) {
        _line.frame = CGRectMake(8, 87.5f, SCREEN_WIDTH-16, 0.5f);
    }
    if (isWhite) {
        self.backgroundColor = [UIColor whiteColor];
    }else{
        self.backgroundColor = VIEWBACKGROUND_COLOR;
    }
    _line.hidden = hide;
}

@end
