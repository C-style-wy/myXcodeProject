//
//  TopicTitleCell.m
//  henews250
//
//  Created by 汪洋 on 2016/11/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TopicTitleCell.h"

@implementation TopicTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifer = @"TopicTitleCell";
    TopicTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[TopicTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)prepareForReuse {
    [super prepareForReuse];
}

/**
 *  构造方法(在初始化对象的时候会调用)
 *  一般在这个方法中添加需要显示的子控件
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        SHLUILabel *topicIntro = [[SHLUILabel alloc]init];
        topicIntro.linesSpacing = IntroLineSpace;
        topicIntro.font = IntroFont;
        topicIntro.textColor = [UIColor colorWithHexColor:@"#969696"];
        [self.contentView addSubview:topicIntro];
        self.topicIntro = topicIntro;
        
        UIImageView *image = [[UIImageView alloc]init];
        image.backgroundColor = [UIColor colorWithHexColor:@"#d4d4d4"];
        [self.contentView addSubview:image];
        self.topicImage = image;
    }
    return self;
}

- (void)setTopicTitleFrame:(TopicTitleFrame *)topicTitleFrame {
    _topicTitleFrame = topicTitleFrame;
    
    // 1.给子控件赋值数据
    [self settingData];
    // 2.设置frame
    [self settingFrame];
}

/**
 *  设置子控件的数据
 */
- (void)settingData {
    TopicTitleModel *data = self.topicTitleFrame.topicTitleModel;
    if (data.topicIntro && ![data.topicIntro isEqualToString:@""]) {
        self.topicIntro.text = data.topicIntro;
    }
    
    if (data.imageUrl && ![data.imageUrl isEqualToString:@""]) {
        [self.topicImage loadFromWebWithUrlString:data.imageUrl animated:YES];
    }
}
/**
 *  设置子控件的frame
 */
- (void)settingFrame {
    self.topicImage.frame = self.topicTitleFrame.topicImageFrame;
    self.topicIntro.frame = self.topicTitleFrame.topicIntroFrame;
}

@end
