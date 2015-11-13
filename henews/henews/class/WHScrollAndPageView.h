//
//  WHScrollAndPageView.h
//  henews
//
//  Created by 汪洋 on 15/11/4.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WHcrollViewViewDelegate;

@interface WHScrollAndPageView : UIView <UIScrollViewDelegate>
{
    __unsafe_unretained id <WHcrollViewViewDelegate> _delegate;
}


@property (nonatomic, assign) id <WHcrollViewViewDelegate> delegate;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray *imageViewAry;

@property (nonatomic, readonly) UIScrollView *scrollView;

@property (nonatomic, readonly) UIPageControl *pageControl;

-(void)shouldAutoShow:(BOOL)shouldStart;

@end

@protocol WHcrollViewViewDelegate <NSObject>

@optional
-(void)didClickPage:(WHScrollAndPageView*)view atIndex:(NSInteger)index;

@end
