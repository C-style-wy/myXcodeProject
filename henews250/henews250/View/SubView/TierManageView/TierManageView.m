//
//  TierManageView.m
//  henews250
//
//  Created by 汪洋 on 16/7/27.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TierManageView.h"

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
        _tiers = [TierManageMode readLocadTier:name];
        [self.collectionView reloadData];
    }
    return self;
}

- (void)openTierManage:(NSInteger)currentClass clickBtn:(UIButton*)btn {
    self.mainViewBottom.constant = self.frame.size.height;
    [self layoutIfNeeded];
    self.mainViewBottom.constant = 0;
    
//    UIImageView *btnImage = (UIImageView*)btn.subviews;
    UIImageView *btnImage;
    for (UIView *subView in btn.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]){
            btnImage = (UIImageView*)subView;
        }
    }
    
    tierHeadView = [[TierHeadView loadFromNib]init];
    tierHeadView.delegate = self;
    tierHeadView.frame = CGRectMake(0, 0, self.frame.size.width, 53);
    [self.superview addSubview:tierHeadView];
    tierHeadView.alpha = 0.0f;
    
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
                         if ([self.delegate respondsToSelector:@selector(whenOpenOrCloseTierManage:)]) {
                             [self.delegate whenOpenOrCloseTierManage:YES];
                         }
                     }];
}

- (void)closeTierManageView:(UIImageView*)image {
    self.mainViewBottom.constant = self.frame.size.height;
    if ([self.delegate respondsToSelector:@selector(whenOpenOrCloseTierManage:)]) {
        [self.delegate whenOpenOrCloseTierManage:NO];
    }
    [UIView animateWithDuration:openOrCloseTime
                     animations:^{
                         image.transform = CGAffineTransformMakeRotation(PI+PI/2);
                         [self layoutIfNeeded];
                     }
                     completion:^(BOOL finished){
                         [tierHeadView removeFromSuperview];
                         [self removeFromSuperview];
                     }];
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
    [cell initWithData:[ary objectAtIndex:indexPath.row]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        TierCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        if(footerView == nil) {
            footerView = [[TierCollectionReusableView alloc] init];
        }
        //        footerView.backgroundColor = [UIColor lightGrayColor];
        return footerView;
    }
    
    return nil;
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
#pragma mark - UICollectionViewDelegate

@end
