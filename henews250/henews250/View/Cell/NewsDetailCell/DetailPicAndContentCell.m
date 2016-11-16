//
//  DetailPicAndContentCell.m
//  henews250
//
//  Created by 汪洋 on 2016/11/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "DetailPicAndContentCell.h"
#import "UIImageView+LoadFromWeb.h"

@implementation DetailPicAndContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifer = @"DetailPicAndContentCell";
    DetailPicAndContentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[DetailPicAndContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    return cell;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexpath:(NSIndexPath*)indexPath {
    NSString *identifer = [NSString stringWithFormat:@"DetailPicAndContentCell%ld%ld", (long)indexPath.section, (long)indexPath.row];
    DetailPicAndContentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[DetailPicAndContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.contentText.text = @"";
    self.contentText.frame = CGRectZero;
}

/**
 *  构造方法(在初始化对象的时候会调用)
 *  一般在这个方法中添加需要显示的子控件
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        SHLUILabel *contentText = [[SHLUILabel alloc]init];
        contentText.linesSpacing = ContentLineSpace;
        contentText.font = ContentFont;
        contentText.textColor = [UIColor colorWithHexColor:@"#1e1e1e"];
        [self.contentView addSubview:contentText];
        self.contentText = contentText;
        
        UIImageView *image = [[UIImageView alloc]init];
        image.backgroundColor = [UIColor colorWithHexColor:@"#d4d4d4"];
        [self.contentView addSubview:image];
        self.image = image;
    }
    return self;
}

- (void)setDetailPicAndContentFrame:(DetailPicAndContentFrame *)detailPicAndContentFrame {
    _detailPicAndContentFrame = detailPicAndContentFrame;
    
    // 1.给子控件赋值数据
    [self settingData];
    // 2.设置frame
    [self settingFrame];
}

/**
 *  设置子控件的数据
 */
- (void)settingData {
    SubContentMode *data = self.detailPicAndContentFrame.contentMode;
    if (data.content && ![data.content isEqualToString:@""]) {
        self.contentText.text = data.content;
    }
    
    if (data.imageInfoList && data.imageInfoList.count > 0) {
        ImageInfoMode *imageInfo = [data.imageInfoList objectAtIndex:0];
        [self.image loadFromWebWithUrlString:imageInfo.url animated:YES];
    }
}
/**
 *  设置子控件的frame
 */
- (void)settingFrame {
    self.image.frame = self.detailPicAndContentFrame.imageFrame;
    self.contentText.frame = self.detailPicAndContentFrame.textFrame;
}

@end
