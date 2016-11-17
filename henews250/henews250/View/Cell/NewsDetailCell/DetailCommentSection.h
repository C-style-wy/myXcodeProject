//
//  DetailCommentSection.h
//  henews250
//
//  Created by 汪洋 on 2016/11/17.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsSectionConst.h"

@interface DetailCommentSection : UIView
@property (weak, nonatomic) IBOutlet UIImageView *detail_comment_list_icon;
@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;

- (DetailCommentSection *)initWithSectionType:(SectionType)sectionType;

@end
