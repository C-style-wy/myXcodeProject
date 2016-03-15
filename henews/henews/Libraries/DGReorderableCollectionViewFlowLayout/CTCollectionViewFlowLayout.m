//
//  CTCollectionViewFlowLayout.m
//  henews
//
//  Created by 汪洋 on 16/3/14.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "CTCollectionViewFlowLayout.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

#ifndef CGGEOMETRY_LXSUPPORT_H_
//CG_INLINE内连函数，作用就是两个CGPoint相加
CG_INLINE CGPoint CTS_CGPointAdd(CGPoint point1, CGPoint point2){
    return CGPointMake(point1.x + point2.x, point1.y + point2.y);
}
#endif

typedef NS_ENUM(NSInteger, CTScrollingDirection){
    CTScrollingDirectionUnknown = 0,
    CTScrollingDirectionUp,
    CTScrollingDirectionDown,
    CTScrollingDirectionLeft,
    CTScrollingDirectionRight
};
//全局静态常量
static NSString * const kCTScrollingDirectionKey = @"CTScrollingDirection";
static NSString * const kCTCollectionViewKeyPath = @"collectionView";

@interface CADisplayLink (CT_userInfo)
@property (nonatomic, copy) NSDictionary *CT_userInfo;
@end

@implementation CADisplayLink (CT_userInfo)

- (void)setCT_userInfo:(NSDictionary *)CT_userInfo{
    objc_setAssociatedObject(self, "CT_userInfo", CT_userInfo, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)CT_userInfo{
    return objc_getAssociatedObject(self, "CT_userInfo");
}

@end

@interface UICollectionViewCell (CTCollectionViewFlowLayout)

- (UIView *)CT_snapshotView;

@end

@implementation UICollectionViewCell (CTCollectionViewFlowLayout)

- (UIView *)CT_snapshotView{
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

@interface CTCollectionViewFlowLayout ()

@property (strong, nonatomic) NSIndexPath *selectedItemIndexPath;
@property (strong, nonatomic) UIView *currentView;
@property (assign, nonatomic) CGPoint currentViewCenter;
@property (assign, nonatomic) CGPoint panTranslationInCollentionView;
@property (strong, nonatomic) CADisplayLink *displayLink;

@property (assign, nonatomic, readonly) id<CTCollectionViewDataSource> dataSource;
@property (assign, nonatomic, readonly) id<CTCollectionViewDelegateFlowLayout> delegate;

@end

@implementation CTCollectionViewFlowLayout

- (void)setDefaults{
    _scrollingSpeed = 300.0f;
    _scrollingTriggerEdgeInsets = UIEdgeInsetsMake(50.0f, 50.0f, 50.0f, 50.0f);
}

- (void)setupCollectionView{
    _longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    _longPressGestureRecognizer.delegate = self;
    
    for (UIGestureRecognizer *gestureRecognizer in self.collectionView.gestureRecognizers) {
        if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
            [gestureRecognizer requireGestureRecognizerToFail:_longPressGestureRecognizer];
        }
    }
    [self.collectionView addGestureRecognizer:_longPressGestureRecognizer];
    
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    _panGestureRecognizer.delegate = self;
    [self.collectionView addGestureRecognizer:_panGestureRecognizer];
    
    //添加监听事件，监听是否触发home键挂起程序
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationWillResignAction:) name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)tearDownCollectionView{
    if (_longPressGestureRecognizer) {
        UIView *view = _longPressGestureRecognizer.view;
        if (view) {
            [view removeGestureRecognizer:_longPressGestureRecognizer];
        }
        _longPressGestureRecognizer.delegate = nil;
        _longPressGestureRecognizer = nil;
    }
    
    if (_panGestureRecognizer) {
        UIView *view = _panGestureRecognizer.view;
        if (view) {
            [view removeGestureRecognizer:_panGestureRecognizer];
        }
        _panGestureRecognizer.delegate = nil;
        _panGestureRecognizer = nil;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

- (id)init{
    self = [super init];
    if (self) {
        [self setDefaults];
        [self addObserver:self forKeyPath:kCTCollectionViewKeyPath options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

//使用xib初始化实例时调用
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setDefaults];
        [self addObserver:self forKeyPath:kCTCollectionViewKeyPath options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)dealloc{
    [self invalidatesScrollTimer];
    [self tearDownCollectionView];
    [self removeObserver:self forKeyPath:kCTCollectionViewKeyPath];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    if ([layoutAttributes.indexPath isEqual:self.selectedItemIndexPath]) {
        layoutAttributes.hidden = YES;
    }
}

- (id<CTCollectionViewDataSource>)dataSource {
    return (id<CTCollectionViewDataSource>)self.collectionView.dataSource;
}

- (id<CTCollectionViewDelegateFlowLayout>)delegate{
    return (id<CTCollectionViewDelegateFlowLayout>)self.collectionView.delegate;
}

- (void)invalidateLayoutIfNecessary{
    NSIndexPath *newIndexPath = [self.collectionView indexPathForItemAtPoint:self.currentView.center];
    NSIndexPath *previousIndexPath = self.selectedItemIndexPath;
    
    if ((newIndexPath == nil) || [newIndexPath isEqual:previousIndexPath]) {
        return;
    }
    
    if ([self.dataSource respondsToSelector:@selector(collectionView:itemAtIndexPath:canMoveToIndexPath:)] && ![self.dataSource collectionView:self.collectionView itemAtIndexPath:previousIndexPath canMoveToIndexPath:newIndexPath]) {
        return;
    }
    
    self.selectedItemIndexPath = newIndexPath;
    
    if ([self.dataSource respondsToSelector:@selector(collectionView:itemAtIndexPath:canMoveToIndexPath:)]) {
        [self.dataSource collectionView:self.collectionView itemAtIndexPath:previousIndexPath willMoveToIndexPath:newIndexPath];
    }
    //typeof(self)返回对应类型,等价于__weak CTCollectionViewFlowLayout * weakSelf = self;
    __weak typeof(self) weakSelf = self;
    [self.collectionView performBatchUpdates:^{
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.collectionView deleteItemsAtIndexPaths:@[previousIndexPath]];
            [strongSelf.collectionView insertItemsAtIndexPaths:@[newIndexPath]];
        }
    }completion:^(BOOL finished) {
        __strong typeof(self) strongSelf = weakSelf;
        if ([strongSelf.dataSource respondsToSelector:@selector(collectionView:itemAtIndexPath:didMoveToIndexPath:)]) {
            [strongSelf.dataSource collectionView:strongSelf.collectionView itemAtIndexPath:previousIndexPath didMoveToIndexPath:newIndexPath];
        }
    }];
}

- (void)invalidatesScrollTimer{
    if (!self.displayLink.paused) {
        [self.displayLink invalidate];
    }
    self.displayLink = nil;
}

- (void)setupScrollTimerInDirection:(CTScrollingDirection)direction {
    if (!self.displayLink.paused) {
        CTScrollingDirection oldDirection = [self.displayLink.CT_userInfo[kCTScrollingDirectionKey] integerValue];
        if (direction == oldDirection) {
            return;
        }
    }
    
    [self invalidatesScrollTimer];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleScroll:)];
    self.displayLink.CT_userInfo = @{kCTScrollingDirectionKey : @(direction)};
    
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)handleScroll:(CADisplayLink *)displayLink {
    NSLog(@"handleScroll");
    CTScrollingDirection direction = (CTScrollingDirection)[displayLink.CT_userInfo[kCTScrollingDirectionKey] integerValue];
    if (direction == CTScrollingDirectionUnknown) {
        return;
    }
    
    CGSize frameSize = self.collectionView.bounds.size;
    CGSize contentSize = self.collectionView.contentSize;
    CGPoint contentOffset = self.collectionView.contentOffset;
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    
    CGFloat distance = rint(self.scrollingSpeed * displayLink.duration);
    CGPoint translation = CGPointZero;
    
    switch (direction) {
        case CTScrollingDirectionUp:{
            distance = -distance;
            CGFloat minY = 0.0f - contentInset.top;
            
            if ((contentOffset.y + distance) <= minY) {
                distance = -contentOffset.y - contentInset.top;
            }
            
            translation = CGPointMake(0.0f, distance);
        } break;
        case CTScrollingDirectionDown:{
            CGFloat maxY = MAX(contentSize.height, frameSize.height) - frameSize.height + contentInset.bottom;
            
            if ((contentOffset.y + distance) >= maxY) {
                distance = maxY - contentOffset.y;
            }
            
            translation = CGPointMake(0.0f, distance);
        } break;
        case CTScrollingDirectionLeft:{
            distance = -distance;
            CGFloat minX = 0.0f - contentInset.left;
            
            if ((contentOffset.x + distance) <= minX) {
                distance = -contentOffset.x - contentInset.left;
            }
            translation = CGPointMake(distance, 0.0f);
        } break;
        case CTScrollingDirectionRight: {
            CGFloat maxX = MAX(contentSize.width, frameSize.width) - frameSize.width + contentInset.right;
            
            if ((contentOffset.x + distance) >= maxX) {
                distance = maxX - contentOffset.x;
            }
            
            translation = CGPointMake(distance, 0.0f);
        } break;
        default: {
            // Do nothing...
        } break;
    }
    
    self.currentViewCenter = CTS_CGPointAdd(self.currentViewCenter, translation);
    self.currentView.center = CTS_CGPointAdd(self.currentViewCenter, self.panTranslationInCollentionView);
    self.collectionView.contentOffset = CTS_CGPointAdd(contentOffset, translation);
}

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            NSIndexPath *currentIndexPath = [self.collectionView indexPathForItemAtPoint:[gestureRecognizer locationInView:self.collectionView]];
            
            if ([self.dataSource respondsToSelector:@selector(collectionView:canMoveItemAtIndexPath:)] && ![self.dataSource collectionView:self.collectionView canMoveItemAtIndexPath:currentIndexPath]) {
                return;
            }
            
            self.selectedItemIndexPath = currentIndexPath;
            
            if ([self.delegate respondsToSelector:@selector(collectionView:layout:willBeginDraggingItemAtIndexPath:)]) {
                [self.delegate collectionView:self.collectionView layout:self willBeginDraggingItemAtIndexPath:self.selectedItemIndexPath];
            }
            
            UICollectionViewCell *collectionViewCell = [self.collectionView cellForItemAtIndexPath:self.selectedItemIndexPath];
            
            self.currentView = [[UIView alloc] initWithFrame:collectionViewCell.frame];
            
            collectionViewCell.highlighted = YES;
            UIView *highlightedImageView = [collectionViewCell CT_snapshotView];
            highlightedImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            highlightedImageView.alpha = 1.0f;
            
            collectionViewCell.highlighted = NO;
            UIView *imageView = [collectionViewCell CT_snapshotView];
            imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            imageView.alpha = 0.0f;
            
            [self.currentView addSubview:imageView];
            [self.currentView addSubview:highlightedImageView];
            [self.collectionView addSubview:self.currentView];
            
            self.currentViewCenter = self.currentView.center;
            
            __weak typeof(self) weakSelf = self;
            [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    strongSelf.currentView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
                    highlightedImageView.alpha = 0.0f;
                    imageView.alpha = 1.0f;
                }
            }completion:^(BOOL finished) {
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    [highlightedImageView removeFromSuperview];
                    
                    if ([strongSelf.delegate respondsToSelector:@selector(collectionView:layout:didBeginDraggingItemAtIndexPath:)]) {
                        [strongSelf.delegate collectionView:strongSelf.collectionView layout:strongSelf didBeginDraggingItemAtIndexPath:strongSelf.selectedItemIndexPath];
                    }
                }
            }];
            
            [self invalidateLayout];
        }break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            NSIndexPath *currentIndexPath = self.selectedItemIndexPath;
            if (currentIndexPath) {
                if ([self.delegate respondsToSelector:@selector(collectionView:layout:willEndDraggingItemAtIndexPath:)]) {
                    [self.delegate collectionView:self.collectionView layout:self willEndDraggingItemAtIndexPath:currentIndexPath];
                }
            }
            
            self.selectedItemIndexPath = nil;
            self.currentViewCenter = CGPointZero;
            
            UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForItemAtIndexPath:currentIndexPath];
            
            self.longPressGestureRecognizer.enabled = NO;
            
            __weak typeof(self) weakSelf = self;
            [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    strongSelf.currentView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                    strongSelf.currentView.center = layoutAttributes.center;
                }
            }completion:^(BOOL finished) {
                self.longPressGestureRecognizer.enabled = NO;
                
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf.currentView removeFromSuperview];
                    strongSelf.currentView = nil;
                    [strongSelf invalidateLayout];
                    
                    if ([strongSelf.delegate respondsToSelector:@selector(collectionView:layout:didEndDraggingItemAtIndexPath:)]) {
                        [strongSelf.delegate collectionView:strongSelf.collectionView layout:strongSelf didEndDraggingItemAtIndexPath:currentIndexPath];
                    }
                }
            }];
        }break;
        default:
            break;
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:{
            self.panTranslationInCollentionView = [gestureRecognizer translationInView:self.collectionView];
            CGPoint viewCenter = self.currentView.center = CTS_CGPointAdd(self.currentViewCenter, self.panTranslationInCollentionView);
            
            [self invalidateLayoutIfNecessary];
            
            switch (self.scrollDirection) {
                case UICollectionViewScrollDirectionVertical:{
                    if (viewCenter.y < (CGRectGetMinY(self.collectionView.bounds) + self.scrollingTriggerEdgeInsets.top)) {
                        [self setupScrollTimerInDirection:CTScrollingDirectionUp];
                    }else{
                        if (viewCenter.y > (CGRectGetMaxY(self.collectionView.bounds) - self.scrollingTriggerEdgeInsets.bottom)) {
                            [self setupScrollTimerInDirection:CTScrollingDirectionDown];
                        } else {
                            [self invalidatesScrollTimer];
                        }
                    }
                } break;
                case UICollectionViewScrollDirectionHorizontal:{
                    if (viewCenter.x < (CGRectGetMinX(self.collectionView.bounds) + self.scrollingTriggerEdgeInsets.left)) {
                        [self setupScrollTimerInDirection:CTScrollingDirectionLeft];
                    } else {
                        if (viewCenter.x > (CGRectGetMaxX(self.collectionView.bounds) - self.scrollingTriggerEdgeInsets.right)) {
                            [self setupScrollTimerInDirection:CTScrollingDirectionRight];
                        } else {
                            [self invalidatesScrollTimer];
                        }
                    }
                } break;
                default:
                    break;
            }
        } break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            [self invalidatesScrollTimer];
        } break;
        default: {
            // Do nothing...
        } break;
    }
}

#pragma mark - UICollectionViewLayout overridden methods

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *layoutAttributesForElementsInRect = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in layoutAttributesForElementsInRect) {
        switch (layoutAttributes.representedElementCategory) {
            case UICollectionElementCategoryCell: {
                [self applyLayoutAttributes:layoutAttributes];
            } break;
            default: {
                // Do nothing...
            } break;
        }
    }
    
    return layoutAttributesForElementsInRect;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    switch (layoutAttributes.representedElementCategory) {
        case UICollectionElementCategoryCell: {
            [self applyLayoutAttributes:layoutAttributes];
        } break;
        default: {
            // Do nothing...
        } break;
    }
    
    return layoutAttributes;
}

#pragma mark - UIGestureRecognizerDelegate methods
//gestureRecognizer手势识别
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.panGestureRecognizer isEqual:gestureRecognizer]) {
        return (self.selectedItemIndexPath != nil);
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    NSLog(@"gestureRecognizer");
    if ([self.longPressGestureRecognizer isEqual:gestureRecognizer]) {
        return [self.panGestureRecognizer isEqual:otherGestureRecognizer];
    }
    
    if ([self.panGestureRecognizer isEqual:gestureRecognizer]) {
        return [self.longPressGestureRecognizer isEqual:otherGestureRecognizer];
    }
    
    return NO;
}

#pragma mark - Key-Value Observing methods

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:kCTCollectionViewKeyPath]) {
        if (self.collectionView != nil) {
            [self setupCollectionView];
        } else {
            [self invalidatesScrollTimer];
            [self tearDownCollectionView];
        }
    }
}

#pragma mark - Notifications

- (void)handleApplicationWillResignAction:(NSNotification *)notification{
    self.panGestureRecognizer.enabled = NO;
    self.panGestureRecognizer.enabled = YES;
}

@end















