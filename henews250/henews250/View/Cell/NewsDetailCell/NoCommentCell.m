//
//  NoCommentCell.m
//  henews250
//
//  Created by 汪洋 on 2016/11/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NoCommentCell.h"

@implementation NoCommentCell

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
    NoCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[NoCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
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
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-4)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithHexColor:@"#b4b4b4"];
        label.text = @"正在获取评论数据...";
        label.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:label];
        self.noCommentLabel = label;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, label.frame.size.height, self.frame.size.width, 4)];
        lineView.backgroundColor = [UIColor colorWithHexColor:@"#dcdcdc"];
        [self.contentView addSubview:lineView];
    }
    return self;
}

@end
