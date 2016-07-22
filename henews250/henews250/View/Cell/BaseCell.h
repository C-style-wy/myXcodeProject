//
//  BaseCell.h
//  henews250
//
//  Created by 汪洋 on 16/7/20.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageMode.h"
#import "MacroDefinition.h"
#import "NewsMode.h"
#import "TagMode.h"
#import "UIImageView+LoadFromWeb.h"
#import "UILabel+NeedWidthAndHeight.h"

//新闻类型
#define NewsTypeVideo       1      //视频
#define NewsTypePic         4      //图集

@interface BaseCell : UITableViewCell

@end
