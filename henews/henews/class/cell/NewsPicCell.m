//
//  NewsPicCell.m
//  henews
//
//  Created by 汪洋 on 15/11/11.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "NewsPicCell.h"
#import "APIStringMacros.h"
#import "UIImageView+AFNetworking.h"

@implementation NewsPicCell

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
    static NSString *identifier = @"NewsPicCell";
    // 1.缓存中取
    NewsPicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[NewsPicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *pic = [[UIImageView alloc]init];
//        pic.frame = CGRectMake(8, 11, 85, 66);
        pic.contentMode = UIViewContentModeScaleAspectFill;
        [pic setContentScaleFactor:[[UIScreen mainScreen]scale]];
        pic.clipsToBounds  = YES;
        [self addSubview:pic];
        self.pic = pic;
       
    }
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    return self;
}

-(void)loadTableCell:(NewsPicCellData*)data{
    [self.pic setImage:[UIImage imageNamed:@""]];
    if (![data.picUrl isEqual:@""]) {
        [self.pic setImageWithURL:[NSURL URLWithString:data.picUrl]];
    }
    self.pic.frame = data.picFrame;
}

@end
