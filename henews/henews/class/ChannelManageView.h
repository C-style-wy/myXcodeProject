//
//  ChannelManageView.h
//  henews
//
//  Created by 汪洋 on 15/11/19.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIStringMacros.h"
#import "ChannelCell.h"
#import "ProgramaStructure.h"

@protocol ChannelManageViewDelegate;

@interface ChannelManageView : UIView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>

@property (nonatomic, retain) id <ChannelManageViewDelegate> delegate;

@property (nonatomic, retain) UIView *mainView;

@property (nonatomic, retain) UIButton *channelBtn;
@property (nonatomic, retain) UIButton *finishBtn;

@property (nonatomic, retain) UIView *layoutHead;
@property (nonatomic, retain) UICollectionView *myCollectionView;
@property (nonatomic, retain) NSMutableArray *myChannelAry;
@property (nonatomic, retain) UILabel *myTipsLabel;

@property (nonatomic, retain) UIView *headView;

@property (nonatomic, retain) UICollectionView *otherCollectionView;
@property (nonatomic, retain) NSMutableArray *otherChannelAry;
@property (nonatomic, retain) UILabel *otherTipsLabel;

@property (nonatomic, retain) UIImageView *addImageView;

//是否处于编辑状态
@property (nonatomic, assign) BOOL isEditStatu;
//class
@property (nonatomic, assign) NSInteger returnClass;


-(void)openChannel:(NSInteger)class Order:(NSString*)orderName NotOrder:(NSString*)notOrderName;

-(void)closeChannel;

@end


@protocol ChannelManageViewDelegate <NSObject>

@optional
-(void)dealChannelChange:(ChannelManageView*)view returnClass:(NSInteger)class;

@end
