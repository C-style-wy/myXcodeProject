//
//  ViewController.h
//  SQLite3 Test
//
//  Created by 汪洋 on 16/4/19.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (copy, nonatomic)NSString *databaseFilePath;

- (void)applicationWillResignActive:(NSNotification *)notification;

@end

