//
//  CommentListSectionView.h
//  henews250
//
//  Created by 汪洋 on 2016/12/26.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentListSectionView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *headLabel;

@property (nonatomic, assign) BOOL isHot;

@end
