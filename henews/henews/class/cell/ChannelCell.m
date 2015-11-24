//
//  ChannelCell.m
//  henews
//
//  Created by 汪洋 on 15/11/23.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "ChannelCell.h"

@implementation ChannelCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (frame.size.height-30)/2, frame.size.width, 30)];
        self.bgView.image = [UIImage imageNamed:@"btn_bg.png"];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:self.bgView.frame];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.textColor = [UIColor colorWithRed:0.12 green:0.12 blue:0.12 alpha:1];
        self.nameLabel.text = @"测试";
        [self addSubview:self.bgView];
        [self addSubview:self.nameLabel];
        
        self.hotImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-23, 0, 23.0f, 10.5f)];
        self.hotImg.image = [UIImage imageNamed:@"hot.png"];
        [self addSubview:self.hotImg];
        
        self.deleteImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 16.5f, 16.5f)];
        self.deleteImg.image = [UIImage imageNamed:@"delete.png"];
        [self addSubview:self.deleteImg];
    }
    return self;
}

-(void)initWithData:(columStruct*)data isEdit:(BOOL)edit{
    self.nameLabel.text = data.nodeName;
    if ([data.isHot isEqual:@"1"]) {
        self.hotImg.hidden = NO;
    }else{
        self.hotImg.hidden = YES;
    }
    if ([data.showAllTime isEqual:@"1"]) {
        self.bgView.image = [UIImage imageNamed:@"noEdit.png"];
    }else{
        self.bgView.image = [UIImage imageNamed:@"btn_bg.png"];
    }
    self.deleteImg.hidden = YES;
    if (![data.showAllTime isEqual:@"1"]) {
        if (edit) {
            self.deleteImg.hidden = NO;
        }else{
            self.deleteImg.hidden = YES;
        }
    }
}

@end
