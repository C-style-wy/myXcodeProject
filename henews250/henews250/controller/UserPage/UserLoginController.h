//
//  UserLoginController.h
//  henews250
//
//  Created by 汪洋 on 2016/10/13.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SubBaseViewController.h"

@interface UserLoginController : SubBaseViewController<UITextFieldDelegate>
@property(nonatomic, retain) UIScrollView *mainScrollView;

@property (nonatomic, retain) UIView *weiXinBtnView;
@property (nonatomic, retain) UIView *bianFengBtnView;
@property (nonatomic, retain) UIView *weiBoBtnView;
@property (nonatomic, retain) UIView *QQBtnView;

@property (nonatomic, retain) UIView *thirdPartyView;
@property (nonatomic, retain) UIView *keyLoginView;
@property (nonatomic, retain) UIView *loginNameAndPasswordView;

@property (nonatomic, retain) UITextField *nameField;
@property (nonatomic, retain) UITextField *passwordField;

@property (nonatomic, retain) UIButton *forgetPasswordBtn;

@property (nonatomic, retain) UIView *loginBtnView;
@property (nonatomic, retain) UIButton *loginBtn;

@property (nonatomic, retain) UIView *autoLoginView;

@end
