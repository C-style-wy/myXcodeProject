//
//  NewsVoteCell.m
//  henews
//
//  Created by 汪洋 on 16/3/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NewsVoteCell.h"

@interface NewsVoteCell ()
{
    UIView *goodSlideView;
    UIView *badSlideView;
    UIView *slideTotalView;
    BOOL haveVote;
    UIButton *zanButton;
    UIButton *caiButton;
}
@end

@implementation NewsVoteCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"NewsVoteCell";
    // 1.缓存中取
    NewsVoteCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[NewsVoteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *viewBottom = [[UIView alloc]initWithFrame:CGRectMake(0, 92-4, self.frame.size.width, 4)];
        viewBottom.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1];
        [self addSubview:viewBottom];
        
        UIView *viewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 4)];
        viewTop.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1];
        [self addSubview:viewTop];
        
        zanButton = [[UIButton alloc]initWithFrame:CGRectMake(22, (92-35.5f)/2, 35.5f, 35.5f)];
        [zanButton setImage:[UIImage imageNamed:@"detail_ding.png"] forState:UIControlStateNormal];
        [zanButton addTarget:self action:@selector(handleZanButtonSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [zanButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        zanButton.tag = 1;
        [self addSubview:zanButton];
        
        caiButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-35.5f-22, (92-35.5f)/2, 35.5f, 35.5f)];
        [caiButton setImage:[UIImage imageNamed:@"detail_cai.png"] forState:UIControlStateNormal];
        [caiButton addTarget:self action:@selector(handleZanButtonSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [caiButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        caiButton.tag = 2;
        [self addSubview:caiButton];
        
        UIView *slideBgView = [[UIView alloc]initWithFrame:CGRectMake((22+zanButton.frame.size.width+9), (92-2.0f)/2, SCREEN_WIDTH-2*(22+zanButton.frame.size.width+9), 2.0f)];
        slideBgView.backgroundColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1];
        slideTotalView = slideBgView;
        [self addSubview:slideBgView];
        
        UILabel *zanNum = [[UILabel alloc]initWithFrame:CGRectMake(slideBgView.frame.origin.x + 2.0f, slideBgView.frame.origin.y+slideBgView.frame.size.height, slideBgView.frame.size.width-2.0f, 22)];
        zanNum.textAlignment = NSTextAlignmentLeft;
        zanNum.font = [UIFont systemFontOfSize:11.0f];
        zanNum.textColor = [UIColor colorWithRed:0.88 green:0.18 blue:0.56 alpha:1];
        zanNum.text = @"0";
        self.zanNumLabel = zanNum;
        [self addSubview:zanNum];
        
        UILabel *caiNum = [[UILabel alloc]initWithFrame:CGRectMake(slideBgView.frame.origin.x, slideBgView.frame.origin.y+slideBgView.frame.size.height, slideBgView.frame.size.width-2.0f, 22)];
        caiNum.textAlignment = NSTextAlignmentRight;
        caiNum.font = [UIFont systemFontOfSize:11.0f];
        caiNum.textColor = [UIColor colorWithRed:0.06 green:0.46 blue:0.65 alpha:1];
        caiNum.text = @"0";
        self.caiNumLabel = caiNum;
        [self addSubview:caiNum];
        
        UILabel *vLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, slideBgView.frame.origin.y-30, SCREEN_WIDTH/2, 30)];
        vLabel.textAlignment = NSTextAlignmentRight;
        vLabel.font = [UIFont systemFontOfSize:13.0f];
        vLabel.textColor = [UIColor colorWithRed:0.88 green:0.18 blue:0.56 alpha:1];
        vLabel.text = @"V";
        [self addSubview:vLabel];
        
        UILabel *sLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, slideBgView.frame.origin.y-30, SCREEN_WIDTH/2, 30)];
        sLabel.textAlignment = NSTextAlignmentLeft;
        sLabel.font = [UIFont systemFontOfSize:13.0f];
        sLabel.textColor = [UIColor colorWithRed:0.06 green:0.46 blue:0.65 alpha:1];
        sLabel.text = @"S";
        [self addSubview:sLabel];
        
        
        goodSlideView = [[UIView alloc]initWithFrame:CGRectMake(slideTotalView.frame.origin.x, slideTotalView.frame.origin.y, 0, 2.0f)];
        goodSlideView.backgroundColor = [UIColor colorWithRed:0.88 green:0.18 blue:0.56 alpha:1];
        [self addSubview:goodSlideView];
        
        badSlideView = [[UIView alloc]initWithFrame:CGRectMake(slideTotalView.frame.origin.x + slideTotalView.frame.size.width, slideTotalView.frame.origin.y, 0, 2.0f)];
        badSlideView.backgroundColor = [UIColor colorWithRed:0.06 green:0.46 blue:0.65 alpha:1];
        [self addSubview:badSlideView];
        
        haveVote = NO;
        
//        [self.data addObserver:self forKeyPath:@"voteDataChange" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

-(void)loadTableCell:(NewsVoteCellMode*)data{
    self.data = data;
    if ([self.data.goodTimes floatValue] != 0.0f || [self.data.badTimes floatValue] != 0.0f) {
        badSlideView.frame = CGRectMake(slideTotalView.frame.origin.x, slideTotalView.frame.origin.y, slideTotalView.frame.size.width, 2.0f);
    }
    [self changeSlideAndNumber];
}

- (void)handleZanButtonSelectAction:(UIButton *)button{
    if (!haveVote) {
        [Request requestPostForJSON:@"voteData" url:[self.data.voteUrl stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)button.tag]] delegate:self paras:nil msg:101 useCache:false];
    }
}

-(void)requestDidReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg isCacheReturn:(BOOL)flag{
    if ([tag isEqual:@"voteData"]) {
        haveVote = true;
        if ([[returnJson objectForKey:@"behaivorType"] isEqualToString:@"1"]) {
            self.data.goodTimes = [returnJson objectForKey:@"voteTimes"];
        }else if ([[returnJson objectForKey:@"behaivorType"] isEqualToString:@"2"]){
            self.data.badTimes = [returnJson objectForKey:@"voteTimes"];
        }
        [self changeSlideAndNumber];
    }
}

- (void)changeSlideAndNumber{
    if ([self.data.goodTimes floatValue] != 0.0f || [self.data.badTimes floatValue] != 0.0f) {
        CGFloat scale = ([self.data.goodTimes floatValue]/([self.data.goodTimes floatValue] + [self.data.badTimes floatValue]));
        CGFloat goodLength = scale * slideTotalView.frame.size.width;
        CGFloat duration = 1.5f;
        if (scale != 0.0f) {
            duration = 1.5f*scale;
        }
        [UIView animateWithDuration:duration animations:^{
            goodSlideView.frame = CGRectMake(slideTotalView.frame.origin.x, slideTotalView.frame.origin.y, goodLength, 2.0f);
        } completion:^(BOOL finished) {
            self.zanNumLabel.text = self.data.goodTimes;
        }];
        
        [UIView animateWithDuration:duration animations:^{
            badSlideView.frame = CGRectMake(slideTotalView.frame.origin.x + goodLength, slideTotalView.frame.origin.y, slideTotalView.frame.size.width-goodLength, 2.0f);
        } completion:^(BOOL finished) {
            self.caiNumLabel.text = self.data.badTimes;
        }];
        
        [zanButton setImage:[UIImage imageNamed:@"detail_ding.png"] forState:UIControlStateHighlighted];
        [caiButton setImage:[UIImage imageNamed:@"detail_cai.png"] forState:UIControlStateHighlighted];
    }
}

@end
