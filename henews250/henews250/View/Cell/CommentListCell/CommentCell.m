//
//  CommentCell.m
//  henews250
//
//  Created by 汪洋 on 2016/12/26.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.userHeader.layer.masksToBounds = YES;
    self.userHeader.layer.cornerRadius = 27.0f/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifer = @"CommentCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:nil options:nil] firstObject];
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
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        self.backgroundColor = [UIColor clearColor];
//        self.userHeader.layer.masksToBounds = YES;
//        self.userHeader.layer.cornerRadius = 27.0f/2;
//    }
//    return self;
//}

- (void)setCommentMode:(CommentMode *)commentMode {
    _commentMode = commentMode;
    if (_commentMode.pic && ![_commentMode.pic isEqualToString:@""]) {
        [self.userHeader loadFromWebWithUrlString:_commentMode.pic animated:YES];
    }else{
        self.userHeader.image = [UIImage imageNamed:@"visitor_header"];
    }
}

- (void)setHideLine:(BOOL)hideLine {
    _hideLine = hideLine;
    self.line.hidden = hideLine;
}
@end
