//
//  UserCenterController.h
//  henews250
//
//  Created by 汪洋 on 2016/10/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SubBaseViewController.h"
#import "UserCenterSubView.h"
#import "UserInfoHandle.h"

@interface UserCenterController : SubBaseViewController<UIImagePickerControllerDelegate>

@property(nonatomic, retain) UIScrollView *mainScrollView;
@property(nonatomic, retain) UserCenterSubView *userCenterSubView;

@property(nonatomic, retain) UserInfoModel *userInfo;

@property(nonatomic, retain) UIImagePickerController *picker;

@end
