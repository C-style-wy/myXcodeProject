//
//  HenewsRefreshHeader.h
//  henews250
//
//  Created by 汪洋 on 2016/10/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "MYRefreshStateHeader.h"

@interface HenewsRefreshHeader : MYRefreshStateHeader

@property (weak, nonatomic, readonly) UIImageView *arrowView;

@property (nonatomic, retain) UILabel *tipLabel;
@end
