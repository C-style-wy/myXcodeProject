//
//  NewsTitleCell.m
//  henews250
//
//  Created by 汪洋 on 2016/11/7.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NewsTitleCell.h"
#import "Masonry.h"

@implementation NewsTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifer = @"NewsTitleCell";
    NewsTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[NewsTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/**
 *  构造方法(在初始化对象的时候会调用)
 *  一般在这个方法中添加需要显示的子控件
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        SHLUILabel *titleLabel = [[SHLUILabel alloc]init];
        
        titleLabel.linesSpacing = TitleLineSpace;
        titleLabel.font = TitleFont;
        titleLabel.textColor = [UIColor colorWithHexColor:@"#1e1e1e"];
        [self.contentView addSubview:titleLabel];
        self.title = titleLabel;
        
        UILabel *sourceLabel = [[UILabel alloc]init];
        sourceLabel.font = SourceAndTimeFont;
        sourceLabel.textColor = [UIColor colorWithHexColor:@"#969696"];
        [self.contentView addSubview:sourceLabel];
        self.source = sourceLabel;
        
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.font = SourceAndTimeFont;
        timeLabel.textColor = [UIColor colorWithHexColor:@"#969696"];
        [self.contentView addSubview:timeLabel];
        self.time = timeLabel;
    }
    return self;
}

- (void)setNewsTitleFrame:(NewsTitleFrame *)newsTitleFrame {
    _newsTitleFrame = newsTitleFrame;
    
    // 1.给子控件赋值数据
    [self settingData];
    // 2.设置frame
    [self settingFrame];
}


/**
 *  设置子控件的数据
 */
- (void)settingData {
    NewsTitleMode *newsTitle = self.newsTitleFrame.newsTitle;
    
    // 设置新闻标题
    self.title.text = newsTitle.name;
    
    // 设置来源
    self.source.text = newsTitle.source;
    
    // 设置时间
    self.time.text = newsTitle.pubTime;
}
/**
 *  设置子控件的frame
 */
- (void)settingFrame {
    self.title.frame = self.newsTitleFrame.titleFrame;
    self.source.frame = self.newsTitleFrame.sourceFrame;
    self.time.frame = self.newsTitleFrame.timeFrame;
}
@end
