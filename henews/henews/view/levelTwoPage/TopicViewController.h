//
//  TopicViewController.h
//  henews
//
//  Created by 汪洋 on 16/3/30.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseViewController.h"

#import "OneSmallPicCell.h"
#import "OnlyTitleCell.h"
#import "OneBigPicCell.h"
#import "EveryOneCell.h"
#import "ThreePicCell.h"
#import "VideoCell.h"
#import "topicHeadData.h"
#import "TopicHeadCell.h"

#import "PicDetailViewController.h"
#import "DetailViewController.h"
#import "PlayViewController.h"
#import "LinkViewController.h"

@interface TopicViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSString *topicUrl;

@end
