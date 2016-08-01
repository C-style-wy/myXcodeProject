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
    
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:{
            self.panTranslationInCollentionView = [gestureRecognizer translationInView:self.collectionView];
            NSLog(@"x=%f, y=%f", self.panTranslationInCollentionView.x, self.panTranslationInCollentionView.y);
            CGPoint viewCenter = self.currentView.center ;
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
