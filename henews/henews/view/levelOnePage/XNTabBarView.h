//
//  XNTabBarView.h
//  henews
//
//  Created by 汪洋 on 15/10/23.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol reflushDelegate

@optional
-(void)reflushTableView;

@end

@interface XNTabBarView : UITabBarController
//{
//    __unsafe_unretained id <reflushDelegate> _reflushDelegate;
//}

@property (nonatomic, assign) id<reflushDelegate>reflushDelegate;

@end
