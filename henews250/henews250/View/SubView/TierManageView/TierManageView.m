//
//  TierManageView.m
//  henews250
//
//  Created by 汪洋 on 16/7/27.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TierManageView.h"

static NSString * const hiddenDeleteKeyPath = @"hiddenDelete";
#define openOrCloseTime (0.3f)
static NSString *const indentify = @"tierCell";
static NSString *const footerId = @"footerId";


@implementation TierManageView {
    TierHeadView *tierHeadView;
    LocalTierMode *_tiers;
    NSString *_tierName;
}

- (id)initWithName:(NSString*)name {
    self = [super init];
    if (self) {
        _tierName = name;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView registerClass:[TierCollectionViewCell class] forCellWithReuseIdentifier:indentify];
        [self.collectionView registerClass:[TierCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];

        [self addObserver:self forKeyPath:hiddenDeleteKeyPath options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)openTierManage:(NSInteger)currentClass clickBtn:(UIButton*)btn {
    _tiers = [[TierManager shareInstance] readLocadTier:_tierName];
    _clickTier = nil;
    self.hiddenDelete = YES;
    [self.collectionView reloadData];
    
    self.mainViewBottom.constant = self.frame.size.height;
    [self layoutIfNeeded];
    self.mainViewBottom.constant = 0;
    
    UIImageView *btnImage;
    for (UIView *subView in btn.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]){
            btnImage = (UIImageView*)subView;
        }
    }
    
    self.hidden = NO;
    if (tierHeadView == nil) {
        tierHeadView = [[TierHeadView loadFromNib]init];
        tierHeadView.delegate = self;
        tierHeadView.frame = CGRectMake(0, 0, self.frame.size.width, 53);
        [self.superview addSubview:tierHeadView];
    }
    tierHeadView.hidden = NO;
    tierHeadView.alpha = 0.0f;
    tierHeadView.addImage.transform = CGAffineTransformMakeRotation(PI/4);
    
    [UIView animateWithDuration:openOrCloseTime
                     animations:^{
                         [self layoutIfNeeded];
                         btnImage.transform = CGAffineTransformMakeRotation(PI);
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.2f animations:^{
                             tierHeadView.alpha = 1.0f;
                         }];
                         btnImage.transform = CGAffineTransformMakeRotation(0);
                         if ([self.delegate respondsToSelector:@selector(whenOpenOrCloseTierManage:orderTiers:nodeId:)]) {
                             [self.delegate whenOpenOrCloseTierManage:YES orderTiers:_tiers.orderTier nodeId:_clickTier];
                         }
                     }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:hiddenDeleteKeyPath]) {
        tierHeadView.isShowDelete = self.hiddenDelete;
        BOOL newValue=[[change objectForKey:NSKeyValueChangeNewKey] intValue];
        BOOL oldValue=[[change objectForKey:NSKeyValueChangeOldKey] intValue];
        if (newValue != oldValue) {
            [self.collectionView reloadData];
        }
    }
}

- (void)closeTierManageView:(UIImageView*)image {
    if ([self.delegate respondsToSelector:@selector(whenOpenOrCloseTierManage:orderTiers:nodeId:)]) {
        [self.delegate whenOpenOrCloseTierManage:NO orderTiers:_tiers.orderTier nodeId:_clickTier];
    }
    self.mainViewBottom.constant = self.frame.size.height;
    [UIView animateWithDuration:openOrCloseTime
                     animations:^{
                         image.transform = CGAffineTransformMakeRotation(PI+PI/2);
                         [self layoutIfNeeded];
                     }
                     completion:^(BOOL finished){
                         tierHeadView.hidden = YES;
                         self.hidden = YES;
                     }];
}
- (void)closeTierFinish {
    self.hiddenDelete = YES;
}

#pragma mark - TierHeadViewDelegate
- (void)closeTierManage:(UIImageView*)addImage {
    [self closeTierManageView:addImage];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (0 == section) {
        return _tiers.orderTier.count;
    }else{
        return _tiers.notOrderTier.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *ary;
    if (0 == indexPath.section) {
        ary = _tiers.orderTier;
    }else{
        ary = _tiers.notOrderTier;
    }
    
    TierCollectionViewCell *cell = (TierCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
    if (0 == indexPath.section) {
        [cell initWithData:[ary objectAtIndex:indexPath.row] hiddenDelete:self.hiddenDelete];
    }else{
        [cell initWithData:[ary objectAtIndex:indexPath.row] hiddenDelete:YES];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        TierCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        if(footerView == nil) {
            footerView = [[TierCollectionReusableView alloc] init];
        }
        return footerView;
    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath {
    
}
- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath {
    
    if (fromIndexPath.section == 0 && toIndexPath.section == 0) {
        [_tiers.orderTier exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
        [[TierManager shareInstance]saveData:_tiers Key:_tierName];
    }

}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return NO;
    }else{
        return YES;
    }
}
- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath {
    return YES;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREEN_WIDTH-4)/4, 45);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(3, 2, 0, 2);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (0 == section) {
        return (CGSize){SCREEN_WIDTH,74};
    }else {
        return CGSizeZero;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath{
    self.hiddenDelete = NO;
}
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.hiddenDelete == NO) {
        NSIndexPath *newIndexPath;
        TierMode *tier;
        if (0 == indexPath.section) {
            newIndexPath = [NSIndexPath indexPathForRow:_tiers.notOrderTier.count inSection:1];
            
            tier = [_tiers.orderTier objectAtIndex:indexPath.row];
            [_tiers.orderTier removeObjectAtIndex:indexPath.row];
            
            [_tiers.notOrderTier addObject:tier];
        }else{
            newIndexPath = [NSIndexPath indexPathForRow:_tiers.orderTier.count inSection:0];
            
            tier = [_tiers.notOrderTier objectAtIndex:indexPath.row];
            [_tiers.notOrderTier removeObjectAtIndex:indexPath.row];
            
            [_tiers.orderTier addObject:tier];
        }
        
        [collectionView performBatchUpdates:^{
            [collectionView deleteItemsAtIndexPaths:@[indexPath]];
            [collectionView insertItemsAtIndexPaths:@[newIndexPath]];
        } completion:^(BOOL finished) {
            [[TierManager shareInstance] saveData:_tiers Key:_tierName];
        }];
    }else {
        if (0 == indexPath.section) {
            _clickTier = [_tiers.orderTier objectAtIndex:indexPath.row];
            [self closeTierManageView:tierHeadView.addImage];
        }else{
            TierMode *tier;
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:_tiers.orderTier.count inSection:0];
            
            tier = [_tiers.notOrderTier objectAtIndex:indexPath.row];
            [_tiers.notOrderTier removeObjectAtIndex:indexPath.row];
            
            [_tiers.orderTier addObject:tier];
            [collectionView performBatchUpdates:^{
                [collectionView deleteItemsAtIndexPaths:@[indexPath]];
                [collectionView insertItemsAtIndexPaths:@[newIndexPath]];
            } completion:^(BOOL finished) {
                [[TierManager shareInstance] saveData:_tiers Key:_tierName];
            }];
        }
    }
    
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:hiddenDeleteKeyPath];
}

@end
