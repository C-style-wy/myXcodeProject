//
//  ThreePicCell.m
//  henews
//
//  Created by 汪洋 on 15/11/10.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "ThreePicCell.h"
#import "APIStringMacros.h"
#import "UIImageView+AFNetworking.h"

@implementation ThreePicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"ThreePicCell";
    // 1.缓存中取
    ThreePicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[ThreePicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
        UIImageView *line = [[UIImageView alloc]init];
        line.frame = CGRectMake(0, 145.5f, SCREEN_WIDTH, 0.5f);
        line.image = [UIImage imageNamed:@"menuFenge.png"];
        [self addSubview:line];
        
        float picW = (SCREEN_WIDTH - 34)/3;
        
        UIView *defaultView1 = [[UIView alloc]initWithFrame:CGRectMake(8, 35, picW, 76.5f)];
        defaultView1.backgroundColor = DEFAULTCOLOR;
        
        UIImageView *defaultImage1 = [[UIImageView alloc]init];
        defaultImage1.frame = CGRectMake((picW-27)/2, 24.5f, 27, 27);
        [defaultImage1 setImage:[UIImage imageNamed:@"newsBigBg.png"]];
        [defaultView1 addSubview:defaultImage1];
        [self addSubview:defaultView1];
        
        UIView *defaultView2 = [[UIView alloc]initWithFrame:CGRectMake(picW+8+9, 35, picW, 76.5f)];
        defaultView2.backgroundColor = DEFAULTCOLOR;
        
        UIImageView *defaultImage2 = [[UIImageView alloc]init];
        defaultImage2.frame = CGRectMake((picW-27)/2, 24.5f, 27, 27);
        [defaultImage2 setImage:[UIImage imageNamed:@"newsBigBg.png"]];
        [defaultView2 addSubview:defaultImage2];
        [self addSubview:defaultView2];
        
        UIView *defaultView3 = [[UIView alloc]initWithFrame:CGRectMake(2*picW+8+9+9, 35, picW, 76.5f)];
        defaultView3.backgroundColor = DEFAULTCOLOR;
        
        UIImageView *defaultImage3 = [[UIImageView alloc]init];
        defaultImage3.frame = CGRectMake((picW-27)/2, 24.5f, 27, 27);
        [defaultImage3 setImage:[UIImage imageNamed:@"newsBigBg.png"]];
        [defaultView3 addSubview:defaultImage3];
        [self addSubview:defaultView3];
        
        UIImageView *pic1 = [[UIImageView alloc]init];
        pic1.frame = CGRectMake(8, 35, picW, 76.5f);
        pic1.contentMode = UIViewContentModeScaleAspectFill;
        [pic1 setContentScaleFactor:[[UIScreen mainScreen]scale]];
        pic1.clipsToBounds  = YES;
        [self addSubview:pic1];
        self.cellPic1 = pic1;
        
        UIImageView *pic2 = [[UIImageView alloc]init];
        pic2.frame = CGRectMake(picW+8+9, 35, picW, 76.5f);
        pic2.contentMode = UIViewContentModeScaleAspectFill;
        [pic2 setContentScaleFactor:[[UIScreen mainScreen]scale]];
        pic2.clipsToBounds  = YES;
        [self addSubview:pic2];
        self.cellPic2 = pic2;
        
        UIImageView *pic3 = [[UIImageView alloc]init];
        pic3.frame = CGRectMake(2*picW+8+9+9, 35, picW, 76.5f);
        pic3.contentMode = UIViewContentModeScaleAspectFill;
        [pic3 setContentScaleFactor:[[UIScreen mainScreen]scale]];
        pic3.clipsToBounds  = YES;
        [self addSubview:pic3];
        self.cellPic3 = pic3;
        
        UILabel *name = [[UILabel alloc]init];
        name.font = [UIFont systemFontOfSize:15.0f];
        name.textColor = [UIColor colorWithRed:0.02 green:0.02 blue:0.02 alpha:1];
        name.frame = CGRectMake(8, 0, SCREEN_WIDTH-16, 35);
        name.numberOfLines = 1;
        [self addSubview:name];
        self.cellName = name;
        
        UILabel *time = [[UILabel alloc]init];
        time.font = [UIFont systemFontOfSize:12.5f];
        time.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1];
        time.frame = CGRectMake(8, 111.5f, SCREEN_WIDTH-16, 35);
        [self addSubview:time];
        self.pubTime = time;
        
        UILabel *pv = [[UILabel alloc]init];
        pv.font = [UIFont systemFontOfSize:12.5f];
        pv.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1];
        pv.frame = CGRectMake(8, 111.5f, SCREEN_WIDTH-16, 35);
        pv.textAlignment = NSTextAlignmentRight;
        [self addSubview:pv];
        self.pv = pv;
    }
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    return self;
}

-(void)loadTableCell:(CellData*)data{
    [self.cellPic1 setImage:[UIImage imageNamed:@""]];
    if (![data.images isEqual:@""]) {
        [self.cellPic1 setImageWithURL:[NSURL URLWithString:data.images]];
    }
    
    [self.cellPic2 setImage:[UIImage imageNamed:@""]];
    if (![data.images2 isEqual:@""]) {
        [self.cellPic2 setImageWithURL:[NSURL URLWithString:data.images2]];
    }
    
    [self.cellPic3 setImage:[UIImage imageNamed:@""]];
    if (![data.images3 isEqual:@""]) {
        [self.cellPic3 setImageWithURL:[NSURL URLWithString:data.images3]];
    }
    
    
    self.cellName.text = data.newsTitle;
    NSString *strs;
    if ([data.source isEqual:@""]) {
        strs = data.createTime;
    }else{
        strs = [data.source stringByAppendingString:@"  "];
        strs = [strs stringByAppendingString:data.createTime];
    }
    self.pubTime.text = strs;
    
    self.pv.text = [data.pv stringByAppendingString:@"阅"];
}

@end
