//
//  TierHeadView.h
//  henews250
//
//  Created by 汪洋 on 16/7/27.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LoadFromNib.h"
#import "MacroDefinition.h"

@protocol TierHeadViewDelegate <NSObject>

@required
- (void)closeTierManage:(UIImageView*)addImage;
- (void)closeTierFinish;

@end


@interface TierHeadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishLabel;
@property (weak, nonatomic) IBOutlet UIImageView *addImage;
@property (nonatomic, assign) BOOL isShowDelete;

@property (nonatomic, assign) id<TierHeadViewDelegate>delegate;

- (id)initWithName:(NSString*)name;
@end
