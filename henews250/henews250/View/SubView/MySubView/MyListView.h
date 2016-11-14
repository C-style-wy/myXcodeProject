//
//  MyListView.h
//  henews250
//
//  Created by 汪洋 on 16/9/29.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyListViewDelegate <NSObject>

@optional
- (void)btnActionWithTag:(NSInteger)tag;

@end

@interface MyListView : UIView

@property (nonatomic, assign) id<MyListViewDelegate> delegate;

@end
