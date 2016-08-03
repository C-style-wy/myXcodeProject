//
//  PullCollectionViewFlowLayout.m
//  henews250
//
//  Created by 汪洋 on 16/7/28.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "PullCollectionViewFlowLayout.h"

#ifdef CGGEOMETRY_LXSUPPORT_H_
CG
#endif

//全局静态常量
static NSString * const kDGScrollingDirectionKey = @"DGScrollingDirection";
static NSString * const kDGCollectionViewKeyPath = @"collectionView";

@interface UICollectionViewCell (PullCollectionViewFlowLayout)
- (UIView *)DG_snapshotView;
@end

@implementation UICollectionViewCell (PullCollectionViewFlowLayout)

- (UIView *)DG_snapshotView {
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
        return [self snapshotViewAfterScreenUpdates:YES];
    }else{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0f);
        
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        return [[UIImageView alloc] initWithImage:image];
    }
}

@end

@implementation PullCollectionViewFlowLayout

- (id)init {
    self = [super init];
    if (self) {
        [self setDefaults];
        //kvo
        [self addObserver:self forKeyPath:kDGCollectionViewKeyPath options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setDefaults];
        //kvo
        [self addObserver:self forKeyPath:kDGCollectionViewKeyPath options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)setDefaults {
    self.scrollingSpeed = 300.0f;
    self.scrollingTriggerEdgeInsets = UIEdgeInsetsMake(50.0f, 50.0f, 50.0f, 50.0f);
}

- (void)setupCollectionView {
    _longPressGestureRecongnizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPressGesture:)];
    _longPressGestureRecongnizer.delegate = self;
    
    for (UIGestureRecognizer *gestureRecognizer in self.collectionView.gestureRecognizers) {
        if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
            [gestureRecognizer requireGestureRecognizerToFail:_longPressGestureRecongnizer];
        }
    }
    [self.collectionView addGestureRecognizer:_longPressGestureRecongnizer];
    
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    _panGestureRecognizer.delegate = self;
    [self.collectionView addGestureRecognizer:_panGestureRecognizer];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kDGCollectionViewKeyPath]) {
        if (self.collectionView != nil) {
            [self setupCollectionView];
        }else{
            
        }
    }
}

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer {
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            NSLog(@"handleLongPressGesture===");
            NSIndexPath *currentIndexPath = [self.collectionView indexPathForItemAtPoint:[gestureRecognizer locationInView:self.collectionView]];
            self.selectedItemIndexPath = currentIndexPath;
            
            UICollectionViewCell *collectionViewCell = [self.collectionView cellForItemAtIndexPath:self.selectedItemIndexPath];
            
            self.currentView = [[UIView alloc] initWithFrame:collectionViewCell.frame];
            
            collectionViewCell.highlighted = YES;
            UIView *highlightedImageView = [collectionViewCell DG_snapshotView];
            highlightedImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            highlightedImageView.alpha = 1.0f;
            
            collectionViewCell.highlighted = NO;
            UIView *imageView = [collectionViewCell DG_snapshotView];
            imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            imageView.alpha = 0.0f;
            
            [self.currentView addSubview:imageView];
            [self.currentView addSubview:highlightedImageView];
            [self.collectionView addSubview:self.currentView];
            
            self.currentViewCenter = self.currentView.center;
            
            __weak typeof (self) weakSelf = self;
            [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    strongSelf.currentView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
                    highlightedImageView.alpha = 0.0f;
                    imageView.alpha = 1.0f;
                }
            } completion:^(BOOL finished) {
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    [highlightedImageView removeFromSuperview];
                }
            }];
            
            [self invalidateLayout];
        }break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            NSIndexPath *currentIndexPath = self.selectedItemIndexPath;
            if (currentIndexPath) {
                
            }
            
            self.selectedItemIndexPath = nil;
            self.currentViewCenter = CGPointZero;
            
            UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForItemAtIndexPath:currentIndexPath];
            
//            self.longPressGestureRecongnizer.enabled = NO;
            
            __weak typeof(self) weakSelf = self;
            [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    strongSelf.currentView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                    strongSelf.currentView.center = layoutAttributes.center;
                }
            } completion:^(BOOL finished) {
//                self.longPressGestureRecongnizer.enabled = NO;
                
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf.currentView removeFromSuperview];
                    strongSelf.currentView = nil;
                    [strongSelf invalidateLayout];
                }
            }];
        }break;
        default:
            break;
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:{
            self.panTranslationInCollentionView = [gestureRecognizer translationInView:self.collectionView];
            NSLog(@"x=%f, y=%f", self.panTranslationInCollentionView.x, self.panTranslationInCollentionView.y);
            CGPoint viewCenter = self.currentView.center;
        }break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            NSLog(@"UIGestureRecognizerStateEnded=======");
        }break;
        default:{
            
        }break;
    }
}
@end
