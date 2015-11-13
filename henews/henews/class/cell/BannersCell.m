//
//  BannersCell.m
//  henews
//
//  Created by 汪洋 on 15/11/3.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "BannersCell.h"
#import "APIStringMacros.h"
#import "UIImageView+AFNetworking.h"

@implementation BannersCell

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
    static NSString *identifier = @"BannersCell";
    // 1.缓存中取
    BannersCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[BannersCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
        UIImageView *line = [[UIImageView alloc]init];
        line.frame = CGRectMake(0, 184.5f, SCREEN_WIDTH, 0.5f);
        line.image = [UIImage imageNamed:@"menuFenge.png"];
        [self addSubview:line];
        
        UIScrollView *scro = [[UIScrollView alloc]init];
        scro.scrollEnabled = YES;
        scro.pagingEnabled = YES;
        [self addSubview:scro];
        self.bannersScrollView = scro;
    }
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    return self;
}

-(void)loadTableCell:(id)data{
    self.bannersScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 155);
    NSLog(@"banners==number===%lu", (unsigned long)[data count]);
    for (int i=0; i < (unsigned long)[data count]; i++) {
        UIImageView *scroImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, self.bannersScrollView.frame.size.height)];
        [scroImage setImageWithURL:[NSURL URLWithString:[[data objectAtIndex:i] objectForKey:@"imageUrl"]]];
        [self.bannersScrollView addSubview:scroImage];
        self.bannersScrollView.showsHorizontalScrollIndicator = NO;
    }
    self.bannersScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*(unsigned long)[data count], 0);
}

@end
