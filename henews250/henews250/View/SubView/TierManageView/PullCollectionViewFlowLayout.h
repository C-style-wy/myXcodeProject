//
//  PullCollectionViewFlowLayout.h
//  henews250
//
//  Created by 汪洋 on 16/7/28.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PullCollectionViewFlowLayout : UICollectionViewFlowLayout<UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGFloat scrollingSpeed;
@property (assign, nonatomic) UIEdgeInsets scrollingTriggerEdgeInsets;
@property (retain, nonatomic, readonly) UILongPressGestureRecognizer *longPressGestureRecongnizer;
@property (strong, nonatomic, readonly) UIPanGestureRecognizer *panGestureRecognizer;

@property (strong, nonatomic) NSIndexPath *selectedItemIndexPath;
@property (strong, nonatomic) UIView *currentView;
@property (assign, nonatomic) CGPoint currentViewCenter;
@property (assign, nonatomic) CGPoint panTranslationInCollentionView;

@end
