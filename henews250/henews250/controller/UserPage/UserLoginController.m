//
//  UserLoginController.m
//  henews250
//
//  Created by 汪洋 on 2016/10/13.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "UserLoginController.h"
#import <ShareSDK/ShareSDK.h>

@interface UserLoginController ()

@end

@implementation UserLoginController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPage];
}

- (void)initPage {
    [super initPage];
    self.pageTitle.text = @"登陆";
    self.pageShareBtn.hidden = YES;
    self.headView.line.hidden = YES;
    
    [self.mainScrollView addSubview:self.thirdPartyView];
    [self.mainScrollView addSubview:self.keyLoginView];
    [self.mainScrollView addSubview:self.loginNameAndPasswordView];
    [self.mainScrollView addSubview:self.autoLoginView];
    [self.mainScrollView addSubview:self.loginBtnView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)pageBackBtnSelect {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 懒加载
- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        UIScrollView *uiScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 53, SCREEN_WIDTH, SCREEN_HEIGHT-53)];
        uiScrollView.showsVerticalScrollIndicator = NO;
        uiScrollView.showsHorizontalScrollIndicator = NO;
        uiScrollView.alwaysBounceVertical = YES;
        uiScrollView.backgroundColor = LRClearColor;
        [self.view addSubview:_mainScrollView = uiScrollView];
    }
    return _mainScrollView;
}

- (UIView *)weiXinBtnView {
    if (!_weiXinBtnView) {
        UIButton *btn = nil;
        {
            btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44.0f, 84.0f)];
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            
            [btn setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"weixin_s"] forState:UIControlStateHighlighted];
            
            [btn setTitle:@"微信" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexColor:@"#8e8e8e"] forState:UIControlStateHighlighted];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.titleLabel.font = [UIFont systemFontOfSize:13.5f];
            [btn setTitleColor:[UIColor colorWithHexColor:@"#1e1e1e"] forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(7, 0, 33.5f, 0)];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(50, -btn.titleLabel.bounds.size.width-50, 0, 0)];
            [btn addTarget:self action:@selector(thirdPartyBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 1;
        }
        
        NSLayoutConstraint *btnWidth = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:44.0f];
        NSLayoutConstraint *btnHeight = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:84.0f];
        
        {
            _weiXinBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/4, 84)];
            _weiXinBtnView.backgroundColor = [UIColor whiteColor];
            [_weiXinBtnView addSubview:btn];
        }
        
        NSLayoutConstraint *btnLeading = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_weiXinBtnView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0];
        NSLayoutConstraint *btnTop = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_weiXinBtnView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
        [btn addConstraint:btnWidth];
        [btn addConstraint:btnHeight];
        [_weiXinBtnView addConstraint:btnLeading];
        [_weiXinBtnView addConstraint:btnTop];
        [_weiXinBtnView setNeedsLayout];
    }
    return _weiXinBtnView;
}

- (UIView *)bianFengBtnView {
    if (!_bianFengBtnView) {
        UIButton *btn = nil;
        {
            btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44.0f, 84.0f)];
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            
            [btn setImage:[UIImage imageNamed:@"bianfeng"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"bianfeng_s"] forState:UIControlStateHighlighted];
            
            [btn setTitle:@"边锋" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexColor:@"#8e8e8e"] forState:UIControlStateHighlighted];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.titleLabel.font = [UIFont systemFontOfSize:13.5f];
            [btn setTitleColor:[UIColor colorWithHexColor:@"#1e1e1e"] forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(7, 0, 33.5f, 0)];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(50, -btn.titleLabel.bounds.size.width-50, 0, 0)];
            [btn addTarget:self action:@selector(thirdPartyBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2;
        }
        
        NSLayoutConstraint *btnWidth = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:44.0f];
        NSLayoutConstraint *btnHeight = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:84.0f];
        
        {
            _bianFengBtnView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, 0, SCREEN_WIDTH/4, 84)];
            _bianFengBtnView.backgroundColor = [UIColor whiteColor];
            [_bianFengBtnView addSubview:btn];
        }
        
        NSLayoutConstraint *btnLeading = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_bianFengBtnView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0];
        NSLayoutConstraint *btnTop = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_bianFengBtnView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
        [btn addConstraint:btnWidth];
        [btn addConstraint:btnHeight];
        [_bianFengBtnView addConstraint:btnLeading];
        [_bianFengBtnView addConstraint:btnTop];
        [_bianFengBtnView setNeedsLayout];
    }
    return _bianFengBtnView;
}

- (UIView *)weiBoBtnView {
    if (!_weiBoBtnView) {
        UIButton *btn = nil;
        {
            btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44.0f, 84.0f)];
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            
            [btn setImage:[UIImage imageNamed:@"weibo"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"weibo_s"] forState:UIControlStateHighlighted];
            
            [btn setTitle:@"微博" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexColor:@"#8e8e8e"] forState:UIControlStateHighlighted];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.titleLabel.font = [UIFont systemFontOfSize:13.5f];
            [btn setTitleColor:[UIColor colorWithHexColor:@"#1e1e1e"] forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(7, 0, 33.5f, 0)];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(50, -btn.titleLabel.bounds.size.width-50, 0, 0)];
            [btn addTarget:self action:@selector(thirdPartyBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 3;
        }
        
        NSLayoutConstraint *btnWidth = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:44.0f];
        NSLayoutConstraint *btnHeight = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:84.0f];
        
        {
            _weiBoBtnView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/4, 84)];
            _weiBoBtnView.backgroundColor = [UIColor whiteColor];
            [_weiBoBtnView addSubview:btn];
        }
        
        NSLayoutConstraint *btnLeading = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_weiBoBtnView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0];
        NSLayoutConstraint *btnTop = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_weiBoBtnView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
        [btn addConstraint:btnWidth];
        [btn addConstraint:btnHeight];
        [_weiBoBtnView addConstraint:btnLeading];
        [_weiBoBtnView addConstraint:btnTop];
        [_weiBoBtnView setNeedsLayout];
    }
    return _weiBoBtnView;
}

- (UIView *)QQBtnView {
    if (!_QQBtnView) {
        UIButton *btn = nil;
        {
            btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44.0f, 84.0f)];
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            
            [btn setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"qq_s"] forState:UIControlStateHighlighted];
            
            [btn setTitle:@"QQ" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexColor:@"#8e8e8e"] forState:UIControlStateHighlighted];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.titleLabel.font = [UIFont systemFontOfSize:13.5f];
            [btn setTitleColor:[UIColor colorWithHexColor:@"#1e1e1e"] forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(7, 0, 33.5f, 0)];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(50, -btn.titleLabel.bounds.size.width-50, 0, 0)];
            [btn addTarget:self action:@selector(thirdPartyBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 4;
        }
        
        NSLayoutConstraint *btnWidth = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:44.0f];
        NSLayoutConstraint *btnHeight = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:84.0f];
        
        {
            _QQBtnView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/4)*3, 0, SCREEN_WIDTH/4, 84)];
            _QQBtnView.backgroundColor = [UIColor whiteColor];
            [_QQBtnView addSubview:btn];
        }
        
        NSLayoutConstraint *btnLeading = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_QQBtnView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0];
        NSLayoutConstraint *btnTop = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_QQBtnView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
        [btn addConstraint:btnWidth];
        [btn addConstraint:btnHeight];
        [_QQBtnView addConstraint:btnLeading];
        [_QQBtnView addConstraint:btnTop];
        [_QQBtnView setNeedsLayout];
    }
    return _QQBtnView;
}

- (UIView *)thirdPartyView {
    if (!_thirdPartyView) {
        {
            _thirdPartyView = [[UIView alloc]initWithFrame:CGRectMake(0, 4.5f, SCREEN_WIDTH, 84)];
            _thirdPartyView.backgroundColor = [UIColor whiteColor];
            
            [_thirdPartyView addSubview:self.weiXinBtnView];
            [_thirdPartyView addSubview:self.bianFengBtnView];
            [_thirdPartyView addSubview:self.weiBoBtnView];
            [_thirdPartyView addSubview:self.QQBtnView];
        }
    }
    return _thirdPartyView;
}

- (UIView *)keyLoginView {
    if (!_keyLoginView) {
        {
            _keyLoginView = [[UIView alloc]initWithFrame:CGRectMake(0, self.thirdPartyView.frame.origin.y + self.thirdPartyView.frame.size.height, SCREEN_WIDTH, 70.5f)];
            _keyLoginView.backgroundColor = LRClearColor;
        }
        UIButton *btn = nil;
        {
            btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44.0f, 35.5f)];
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            
            [btn setBackgroundImage:[UIImage imageNamed:@"key_login"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"key_login_s"] forState:UIControlStateHighlighted];
            
            [btn setTitle:@"本机号码一键登录" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexColor:@"#a3a3a3"] forState:UIControlStateHighlighted];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.titleLabel.font = [UIFont systemFontOfSize:15.5f];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            [btn addTarget:self action:@selector(keyLoginBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [_keyLoginView addSubview:btn];
        
        NSLayoutConstraint *btnHeight = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:35.5f];
        NSLayoutConstraint *btnVCenter = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_keyLoginView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0];
        NSLayoutConstraint *btnLeading = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_keyLoginView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:14.0f];
        NSLayoutConstraint *btnTrailing = [NSLayoutConstraint constraintWithItem:_keyLoginView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:btn attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:14.0f];
        
        [btn addConstraint:btnHeight];
        [_keyLoginView addConstraints:@[btnVCenter, btnLeading, btnTrailing]];
        [_keyLoginView setNeedsLayout];
    }
    return _keyLoginView;
}

- (UIView *)loginNameAndPasswordView {
    if (!_loginNameAndPasswordView) {
        {
            _loginNameAndPasswordView = [[UIView alloc]initWithFrame:CGRectMake(0, self.keyLoginView.frame.origin.y + self.keyLoginView.frame.size.height, SCREEN_WIDTH, 71.0f)];
            _loginNameAndPasswordView.backgroundColor = [UIColor whiteColor];
        }
        UIImageView *line = nil;
        {
            line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menuFengexian"]];
            line.translatesAutoresizingMaskIntoConstraints = NO;
            [_loginNameAndPasswordView addSubview:line];
            
            NSLayoutConstraint *lineHeight = [NSLayoutConstraint constraintWithItem:line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:0.5f];
            NSLayoutConstraint *lineCenterY = [NSLayoutConstraint constraintWithItem:line attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_loginNameAndPasswordView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0];
            NSLayoutConstraint *lineLeading = [NSLayoutConstraint constraintWithItem:line attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_loginNameAndPasswordView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:9.0f];
            NSLayoutConstraint *lineTrailing = [NSLayoutConstraint constraintWithItem:_loginNameAndPasswordView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:line attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:9.0f];
            [line addConstraint:lineHeight];
            [_loginNameAndPasswordView addConstraints:@[lineCenterY, lineLeading, lineTrailing]];
        }
        UIImageView *userNameIcon = nil;
        {
            userNameIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user_name_icon"]];
            userNameIcon.translatesAutoresizingMaskIntoConstraints = NO;
            [_loginNameAndPasswordView addSubview:userNameIcon];
            
            NSLayoutConstraint *userNameIconWidth = [NSLayoutConstraint constraintWithItem:userNameIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:15.0f];
            NSLayoutConstraint *userNameIconHeight = [NSLayoutConstraint constraintWithItem:userNameIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:15.0f];
            NSLayoutConstraint *userNameIconLeading = [NSLayoutConstraint constraintWithItem:userNameIcon attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_loginNameAndPasswordView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:9.0f];
            NSLayoutConstraint *userNameIconCenterY = [NSLayoutConstraint constraintWithItem:userNameIcon attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_loginNameAndPasswordView attribute:NSLayoutAttributeCenterY multiplier:0.5f constant:0];
            [userNameIcon addConstraints:@[userNameIconWidth, userNameIconHeight]];
            [_loginNameAndPasswordView addConstraints:@[userNameIconLeading, userNameIconCenterY]];
        }
        UIImageView *passwordIcon = nil;
        {
            passwordIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password_icon"]];
            passwordIcon.translatesAutoresizingMaskIntoConstraints = NO;
            [_loginNameAndPasswordView addSubview:passwordIcon];
            
            NSLayoutConstraint *passwordIconWidth = [NSLayoutConstraint constraintWithItem:passwordIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:15.0f];
            NSLayoutConstraint *passwordIconHeight = [NSLayoutConstraint constraintWithItem:passwordIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:15.0f];
            NSLayoutConstraint *passwordIconLeading = [NSLayoutConstraint constraintWithItem:passwordIcon attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_loginNameAndPasswordView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:9.0f];
            NSLayoutConstraint *passwordIconCenterY = [NSLayoutConstraint constraintWithItem:passwordIcon attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_loginNameAndPasswordView attribute:NSLayoutAttributeCenterY multiplier:1.5f constant:0];
            [passwordIcon addConstraints:@[passwordIconWidth, passwordIconHeight]];
            [_loginNameAndPasswordView addConstraints:@[passwordIconLeading, passwordIconCenterY]];
        }
        {
            [_loginNameAndPasswordView addSubview:self.nameField];
            self.nameField.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *nameFieldHeight = [NSLayoutConstraint constraintWithItem:self.nameField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_loginNameAndPasswordView attribute:NSLayoutAttributeHeight multiplier:0.5f constant:0];
            NSLayoutConstraint *nameFieldTop = [NSLayoutConstraint constraintWithItem:self.nameField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_loginNameAndPasswordView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
            NSLayoutConstraint *nameFieldLeading = [NSLayoutConstraint constraintWithItem:self.nameField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:userNameIcon attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:14.0f];
            NSLayoutConstraint *nameFieldTrailing = [NSLayoutConstraint constraintWithItem:_loginNameAndPasswordView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.nameField attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:9.0f];
            [_loginNameAndPasswordView addConstraints:@[nameFieldHeight, nameFieldTop, nameFieldLeading, nameFieldTrailing]];
        }
        {
            [_loginNameAndPasswordView addSubview:self.passwordField];
            self.passwordField.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *passwordFieldHeight = [NSLayoutConstraint constraintWithItem:self.passwordField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_loginNameAndPasswordView attribute:NSLayoutAttributeHeight multiplier:0.5f constant:0];
            NSLayoutConstraint *passwordFieldcenterY = [NSLayoutConstraint constraintWithItem:self.passwordField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_loginNameAndPasswordView attribute:NSLayoutAttributeCenterY multiplier:1.5f constant:0];
            NSLayoutConstraint *passwordFieldLeading = [NSLayoutConstraint constraintWithItem:self.passwordField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:userNameIcon attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:14.0f];
            NSLayoutConstraint *passwordFieldTrailing = [NSLayoutConstraint constraintWithItem:_loginNameAndPasswordView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.passwordField attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:9.0f];
            [_loginNameAndPasswordView addConstraints:@[passwordFieldHeight, passwordFieldcenterY, passwordFieldLeading, passwordFieldTrailing]];
        }
        {
            [_loginNameAndPasswordView addSubview:self.forgetPasswordBtn];
            
            
            NSLayoutConstraint *btnHeight = [NSLayoutConstraint constraintWithItem:self.forgetPasswordBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_loginNameAndPasswordView attribute:NSLayoutAttributeHeight multiplier:0.5f constant:0];
            NSLayoutConstraint *btnTrailing = [NSLayoutConstraint constraintWithItem:_loginNameAndPasswordView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.forgetPasswordBtn attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:9.0f];
            NSLayoutConstraint *btnCenterY = [NSLayoutConstraint constraintWithItem:self.forgetPasswordBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_loginNameAndPasswordView attribute:NSLayoutAttributeCenterY multiplier:1.5f constant:0];
            [_loginNameAndPasswordView addConstraints:@[btnHeight, btnTrailing, btnCenterY]];
        }
        
        [_loginNameAndPasswordView setNeedsLayout];
    }
    return _loginNameAndPasswordView;
}

- (UITextField *)nameField {
    if (!_nameField) {
        _nameField = [[UITextField alloc]init];
        _nameField.delegate = self;
        _nameField.placeholder = @"用户名";
        _nameField.font = [UIFont systemFontOfSize:14.0f];
        _nameField.textColor = [UIColor colorWithHexColor:@"1e1e1e"];
        [_nameField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _nameField;
}

- (UITextField *)passwordField {
    if (!_passwordField) {
        _passwordField = [[UITextField alloc]init];
        _passwordField.delegate = self;
        _passwordField.placeholder = @"密码";
        _passwordField.font = [UIFont systemFontOfSize:14.0f];
        _passwordField.textColor = [UIColor colorWithHexColor:@"1e1e1e"];
        [_passwordField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordField;
}

- (UIButton *)forgetPasswordBtn {
    if (!_forgetPasswordBtn) {
        _forgetPasswordBtn = [[UIButton alloc]init];
        [_forgetPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPasswordBtn setTitleColor:[UIColor colorWithHexColor:@"#006496"] forState:UIControlStateNormal];
        [_forgetPasswordBtn setTitleColor:[UIColor colorWithHexColor:@"#000000"] forState:UIControlStateHighlighted];
        _forgetPasswordBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _forgetPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_forgetPasswordBtn addTarget:self action:@selector(forgetPasswordBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
        
        _forgetPasswordBtn.translatesAutoresizingMaskIntoConstraints = NO;
        
        CGFloat w = [_forgetPasswordBtn.titleLabel needWidth];
        
        NSLayoutConstraint *btnwidth = [NSLayoutConstraint constraintWithItem:_forgetPasswordBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:w];
        [_forgetPasswordBtn addConstraint:btnwidth];
    }
    return _forgetPasswordBtn;
}

- (UIView *)autoLoginView {
    if (!_autoLoginView) {
        _autoLoginView = [[UIView alloc]initWithFrame:CGRectMake(0, self.loginNameAndPasswordView.frame.origin.y + self.loginNameAndPasswordView.frame.size.height, SCREEN_WIDTH, 45.5f)];
        _autoLoginView.backgroundColor = LRClearColor;
        
        UIButton *btn = [[UIButton alloc]init];
        [_autoLoginView addSubview:btn];
        {
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            [btn setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateHighlighted];
            [btn setImage:[UIImage imageNamed:@"unchoose"] forState:UIControlStateSelected];
            
            [btn setTitle:@"自动登录" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexColor:@"#999999"] forState:UIControlStateNormal];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.titleLabel.font = [UIFont systemFontOfSize:12.5f];
            
            CGFloat w = [btn.titleLabel needWidth];
            
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, w+35.0f-18.0f)];
            
            
            NSLayoutConstraint *btnW = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:w+35.0f];
            
            NSLayoutConstraint *btnH = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:18.0f];
            
            [btn addConstraints:@[btnW, btnH]];
            
            
            NSLayoutConstraint *btnLeading = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_autoLoginView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:9.0f];
            
            NSLayoutConstraint *btnCenterY = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_autoLoginView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0];
            
            [_autoLoginView addConstraints:@[btnLeading, btnCenterY]];
            
            btn.tag = 1;
            [btn addTarget:self action:@selector(autoLoginAndSoBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        UIButton *btn2 = [[UIButton alloc]init];
        [_autoLoginView addSubview:btn2];
        {
            btn2.translatesAutoresizingMaskIntoConstraints = NO;
            [btn2 setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateHighlighted];
            [btn2 setImage:[UIImage imageNamed:@"unchoose"] forState:UIControlStateSelected];
            
            [btn2 setTitle:@"记住密码" forState:UIControlStateNormal];
            [btn2 setTitleColor:[UIColor colorWithHexColor:@"#999999"] forState:UIControlStateNormal];
            btn2.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn2.titleLabel.font = [UIFont systemFontOfSize:12.5f];
            
            CGFloat w = [btn2.titleLabel needWidth];
            
            [btn2 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, w+35.0f-18.0f)];
            
            
            NSLayoutConstraint *btn2W = [NSLayoutConstraint constraintWithItem:btn2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:w+35.0f];
            
            NSLayoutConstraint *btn2H = [NSLayoutConstraint constraintWithItem:btn2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:18.0f];
            
            [btn2 addConstraints:@[btn2W, btn2H]];
            
            
            NSLayoutConstraint *btn2Trailing = [NSLayoutConstraint constraintWithItem:_autoLoginView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:btn2 attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
            
            NSLayoutConstraint *btn2CenterY = [NSLayoutConstraint constraintWithItem:btn2 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_autoLoginView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0];
            
            [_autoLoginView addConstraints:@[btn2Trailing, btn2CenterY]];
            
            btn2.tag = 2;
            [btn2 addTarget:self action:@selector(autoLoginAndSoBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
        }
        [_autoLoginView setNeedsLayout];
    }
    return _autoLoginView;
}

- (UIView *)loginBtnView {
    if (!_loginBtnView) {
        {
            _loginBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, self.autoLoginView.frame.origin.y + self.autoLoginView.frame.size.height, SCREEN_WIDTH, 35.5f)];
            _loginBtnView.backgroundColor = LRClearColor;
        }
        UIButton *btn = nil;
        {
            btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44.0f, 35.5f)];
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            
            [btn setUserInteractionEnabled:NO];
            btn.selected = YES;
            [btn setBackgroundImage:[UIImage imageNamed:@"key_login"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"key_login_s"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"key_login_s"] forState:UIControlStateHighlighted];
            
            [btn setTitle:@"登录" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexColor:@"#a3a3a3"] forState:UIControlStateHighlighted];
            [btn setTitleColor:[UIColor colorWithHexColor:@"#a3a3a3"] forState:UIControlStateSelected];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.titleLabel.font = [UIFont systemFontOfSize:16.5f];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            [btn addTarget:self action:@selector(loginBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [_loginBtnView addSubview:btn];
        
        NSLayoutConstraint *btnHeight = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:35.5f];
        NSLayoutConstraint *btnVCenter = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_loginBtnView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0];
        NSLayoutConstraint *btnLeading = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_loginBtnView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:14.0f];
        NSLayoutConstraint *btnTrailing = [NSLayoutConstraint constraintWithItem:_loginBtnView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:btn attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:14.0f];
        
        [btn addConstraint:btnHeight];
        [_loginBtnView addConstraints:@[btnVCenter, btnLeading, btnTrailing]];
        [_loginBtnView setNeedsLayout];
        self.loginBtn = btn;
    }
    return _loginBtnView;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //回收键盘,取消第一响应者
    [textField resignFirstResponder];
    return YES;
}
//点击空白处收回键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

#pragma mark - 按钮点击事件
- (void)thirdPartyBtnSelect:(UIButton *)sender {
    if (1 == sender.tag) {
        
    } else if (2 == sender.tag) {
        
    } else if (3 == sender.tag) {
        
    } else if (4 == sender.tag) {
        NSLog(@"QQ=======");
//        [ShareSDK getUserInfo:SSDKPlatformTypeQQ
//               onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
//                   if (state == SSDKResponseStateSuccess) {
//                       
//                       NSLog(@"uid=%@",user.uid);
//                       NSLog(@"%@",user.credential);
//                       NSLog(@"token=%@",user.credential.token);
//                       NSLog(@"nickname=%@",user.nickname);
//                   } else {
//                       NSLog(@"%@",error);
//                   }
//               }];
    }
}

- (void)keyLoginBtnSelect:(UIButton *)sender {
    NSLog(@"keyLoginBtnSelect=======");
}

- (void)forgetPasswordBtnSelect:(UIButton *)sender {
    NSLog(@"forgetPasswordBtnSelect=======");
}

- (void)autoLoginAndSoBtnSelect:(UIButton *)sender {
    NSLog(@"autoLoginAndSoBtnSelect=======");
    sender.selected = !sender.selected;
}

- (void)loginBtnSelect:(UIButton *)sender {
    NSLog(@"loginBtnSelect=======");
}

- (void) textFieldDidChange:(UITextField *)textField {
    if (![self.nameField.text isEqualToString:@""] && ![self.passwordField.text isEqualToString:@""]) {
        self.loginBtn.selected = NO;
        [self.loginBtn setUserInteractionEnabled:YES];
    }else{
        self.loginBtn.selected = YES;
        [self.loginBtn setUserInteractionEnabled:NO];
    }
}
@end
