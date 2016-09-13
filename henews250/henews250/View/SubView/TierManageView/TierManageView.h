//
//  TierManageView.h
//  henews250
//
//  Created by 汪洋 on 16/7/27.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LoadFromNib.h"
#import "TierHeadView.h"
#import "PullCollectionView.h"
#import "TierCollectionViewCell.h"
#import "TierCollectionReusableView.h"
#import "LocalTierMode.h"
#import "MacroDefinition.h"
#import "TierManageMode.h"

@protocol TierManageViewDelegate <NSObject>

@optional
- (void)whenOpenOrCloseTierManage:(BOOL)isOpen nodeId:(NSString*)nodeId;

@end

@interface TierManageView : UIView<TierHeadViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewBottom;
@property (weak, nonatomic) IBOutlet PullCollectionView *collectionView;


- (void)openTierManage:(NSInteger)currentClass clickBtn:(UIButton*)btn;


@property (nonatomic, assign) id<TierManageViewDelegate>delegate;

- (id)initWithName:(NSString*)name;
@end
