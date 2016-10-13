//
//  WelfareCollectionViewFlowLayout.m
//  henews250
//
//  Created by 汪洋 on 2016/10/13.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "WelfareCollectionViewFlowLayout.h"

@implementation WelfareCollectionViewFlowLayout

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
//    att.
    return att;
}

@end
