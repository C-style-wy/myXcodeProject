//
//  ChannelCell.h
//  henews
//
//  Created by 汪洋 on 15/11/23.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "columStruct.h"

@interface ChannelCell : UICollectionViewCell

@property (nonatomic, retain)UIImageView *bgView;
@property (nonatomic, retain)UIImageView *hotImg;
@property (nonatomic, retain)UIImageView *deleteImg;

@property (nonatomic, retain)UILabel *nameLabel;

-(void)initWithData:(columStruct*)data isEdit:(BOOL)edit;

@end
