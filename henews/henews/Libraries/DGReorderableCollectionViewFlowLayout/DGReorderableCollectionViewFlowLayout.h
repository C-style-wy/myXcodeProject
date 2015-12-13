//
//  DGReorderableCollectionViewFlowLayout.h
//  henews
//
//  Created by 汪洋 on 15/12/11.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGReorderableCollectionViewFlowLayout : UICollectionViewFlowLayout<UIGestureRecognizerDelegate>

@property (assign, nonatomic) CGFloat scrollingSpeed;
@property (assign, nonatomic) UIEdgeInsets scrollingTriggerEdgeInsets;
@property (retain, nonatomic, readonly) UILongPressGestureRecognizer *longPressGestureRecongnizer;
@property (strong, nonatomic, readonly) UIPanGestureRecognizer *panGestureRecognizer;

- (void)setUpGestureRecognizersOnCollectionView __attribute__((deprecated("Calls to setUpGestureRecognizersOnCollectionView method are not longer needed as setup are done automatically through KVO.")));

@end

@protocol DGReorderableCollectionViewDataSource <UICollectionViewDataSource>

@optional

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath;
- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath;

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath;

@end

@protocol DGReorderableCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>
@optional

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;

@end
