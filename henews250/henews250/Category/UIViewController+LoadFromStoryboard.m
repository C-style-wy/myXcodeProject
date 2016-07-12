//
//  UIViewController+LoadFromStoryboard.m
//  henews250
//
//  Created by 汪洋 on 16/7/10.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "UIViewController+LoadFromStoryboard.h"

@implementation UIViewController (LoadFromStoryboard)

+(id)loadFromStoryboard {
    NSString *storyboardId = NSStringFromClass([self class]);
    
    //获取storyboard: 通过bundle根据storyboard的名字来获取我们的storyboard,
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //由storyboard根据myView的storyBoardID来获取我们要切换的视图
    UIViewController *rootView = [story instantiateViewControllerWithIdentifier:storyboardId];
    return rootView;
}

@end
