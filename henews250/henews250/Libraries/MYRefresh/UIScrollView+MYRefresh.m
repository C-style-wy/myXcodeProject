//
//  UIScrollView+MYRefresh.m
//  henews250
//
//  Created by 汪洋 on 16/10/8.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "UIScrollView+MYRefresh.h"
#import "MYRefreshHeader.h"
#import "MYRefreshFooter.h"
#import <objc/runtime.h>

@implementation NSObject (MYRefresh)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2 {
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2 {
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}

@end

@implementation UIScrollView (MYRefresh)

#pragma mark - header
static const char MYRefreshHeaderKey = '\0';
- (void)setMy_header:(MYRefreshHeader *)my_header {
    if (my_header != self.my_header) {
        // 删除旧的，添加新的
        [self.my_header removeFromSuperview];
        [self insertSubview:my_header atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"my_header"]; // KVO
        objc_setAssociatedObject(self, &MYRefreshHeaderKey, my_header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"my_header"]; //KVO
    }
}

- (MYRefreshHeader *)my_header {
    return objc_getAssociatedObject(self, &MYRefreshHeaderKey);
}

#pragma mark - footer
static const char MYRefreshFooterKey = '\0';
- (void)setMy_footer:(MYRefreshFooter *)my_footer {
    if (my_footer != self.my_footer) {
        // 删除旧的，添加新的
        [self.my_footer removeFromSuperview];
        [self insertSubview:my_footer atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"my_footer"]; // KVO
        objc_setAssociatedObject(self, &MYRefreshFooterKey, my_footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"my_footer"]; // KVO
    }
}

- (MYRefreshFooter *)my_footer {
    return objc_getAssociatedObject(self, &MYRefreshFooterKey);
}

#pragma mark - 过期
- (void)setFooter:(MYRefreshFooter *)footer {
    self.my_footer = footer;
}

- (MYRefreshFooter *)footer {
    return self.my_footer;
}

- (void) setHeader:(MYRefreshHeader *)header {
    self.my_header = header;
}

- (MYRefreshHeader *)header {
    return self.my_header;
}

#pragma mark - other
- (NSInteger)my_totalDataCount {
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section < tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    }else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section < collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

static const char MYRefreshReloadDataBlockKey = '\0';
- (void)setMy_reloadDataBlock:(void (^)(NSInteger))my_reloadDataBlock {
    [self willChangeValueForKey:@"my_reloadDataBlocj"]; // KVO
    objc_setAssociatedObject(self, &MYRefreshReloadDataBlockKey, my_reloadDataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"my_reloadDataBlocj"]; // KVO
}

- (void (^)(NSInteger))my_reloadDataBlock {
    return objc_getAssociatedObject(self, &MYRefreshReloadDataBlockKey);
}

- (void)executeReloadDataBlock {
    !self.my_reloadDataBlock ? :self.my_reloadDataBlock(self.my_totalDataCount);
}
@end

@implementation UITableView (MYRefresh)

+ (void)load {
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(my_reloadData)];
}

- (void)my_reloadData {
    [self my_reloadData];
    
    [self executeReloadDataBlock];
}
@end

@implementation UICollectionView (MYRefresh)

+ (void)load {
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(my_reloadData)];
}

- (void)my_reloadData {
    [self my_reloadData];
    [self executeReloadDataBlock];
}
@end









