//
//  LinkReadCell.m
//  henews250
//
//  Created by 汪洋 on 2016/11/16.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "LinkReadCell.h"

@implementation LinkReadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifer = @"LinkReadCell";
    LinkReadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[LinkReadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithHexColor:@"#b4b4b4"];
        label.text = @"已自动优化阅读，点击查看原新闻";
        label.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:label];
        self.linkReadLabel = label;
    }
    return self;
}

@end
