//
//  UserCenterController.m
//  henews250
//
//  Created by 汪洋 on 2016/10/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "UserCenterController.h"

@interface UserCenterController ()

@end

@implementation UserCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPage];
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

- (UserInfoModel *)userInfo {
    if (!_userInfo) {
        if ([UserInfoHandle isLogin]) {
            LoaclUserInfoData *data = [UserInfoHandle getUserInfoFromLocal];
            _userInfo = data.userInfo;
        }
    }
    return _userInfo;
}

- (UIImagePickerController *)picker {
    if (!_picker) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.view.backgroundColor = [UIColor blackColor];
//        UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeCamera;
//        picker.sourceType = sourcheType;
        picker.delegate = self;
        picker.title = @"相册";
        picker.allowsEditing = YES;
        _picker = picker;
    }
    return _picker;
}

#pragma mark - 初始化页面
- (void)initPage {
    [super initPage];
    self.pageTitle.text = @"个人信息";
    self.pageShareBtn.hidden = YES;
    self.headView.line.hidden = YES;
    self.userCenterSubView = [UserCenterSubView loadFromNib];
    self.userCenterSubView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (275.0f/320.0f)*SCREEN_WIDTH);
    [self.mainScrollView addSubview:self.userCenterSubView];
    
    //头像
    self.userCenterSubView.headImg.layer.masksToBounds = YES;
    self.userCenterSubView.headImg.layer.cornerRadius = 14.0f;
    if (self.userInfo) {
        if (self.userInfo.pic && ![self.userInfo.pic isEqualToString:@""]) {
            [self.userCenterSubView.headImg loadFromWebWithUrlString:self.userInfo.pic animated:YES];
        }else{
            self.userCenterSubView.sname.text = self.userInfo.name;
            self.userCenterSubView.headImg.image = [UIImage imageNamed:@"head_default"];
        }
        //昵称
        if (self.userInfo.sname && ![self.userInfo.sname isEqualToString:@""]) {
            self.userCenterSubView.sname.text = self.userInfo.sname;
        }else{
            self.userCenterSubView.sname.text = self.userInfo.name;
        }
        //性别
        if (self.userInfo.sex && [self.userInfo.sex isEqualToString:@"0"]) {
            self.userCenterSubView.sexLabel.text = @"男";
        } else if (self.userInfo.sex && [self.userInfo.sex isEqualToString:@"1"]) {
            self.userCenterSubView.sexLabel.text = @"女";
        } else {
            self.userCenterSubView.sexLabel.text = @"保密";
        }
        //手机号
        if (self.userInfo.mobile && ![self.userInfo.mobile isEqualToString:@""]) {
            self.userCenterSubView.phoneNumLabel.text = self.userInfo.mobile;
        }else{
            self.userCenterSubView.phoneNumLabel.text = @"未设置";
        }
        //邮箱
        if (self.userInfo.mail && ![self.userInfo.mail isEqualToString:@""]) {
            self.userCenterSubView.emailLabel.text = self.userInfo.mail;
        }else{
            self.userCenterSubView.emailLabel.text = @"未设置";
        }
        //地址
        if (self.userInfo.area && ![self.userInfo.area isEqualToString:@""]) {
            self.userCenterSubView.addreLabel.text = self.userInfo.area;
            self.userCenterSubView.addreLabel.textColor = [UIColor colorWithHexColor:@"#969696"];
        }else{
            self.userCenterSubView.addreLabel.text = @"便于活动奖品发放";
            self.userCenterSubView.addreLabel.textColor = [UIColor colorWithHexColor:@"#006496"];
        }
    }
    {
        self.userCenterSubView.headBtn.tag = 1;
        [self.userCenterSubView.headBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.userCenterSubView.exitBtn.tag = 7;
        [self.userCenterSubView.exitBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 按钮事件
- (void)btnAction:(UIButton *)btn {
    NSLog(@"btnAction======");
    if (1 == btn.tag) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:self.picker animated:YES completion:nil];
        }
    } else if (2 == btn.tag) {
        
    } else if (3 == btn.tag) {
        
    } else if (4 == btn.tag) {
        
    } else if (5 == btn.tag) {
        
    } else if (6 == btn.tag) {
        
    } else if (7 == btn.tag) {
        NSLog(@"退出登录======");
        [NetworkManager postRequestJsonWithURL:DEF_GetLogOutUrl params:nil cacheBlock:nil successBlock:^(NSDictionary *returnJson) {
            if ([[returnJson objectForKey:@"resultCode"] isEqualToString:@"1"]) {
                LoaclUserInfoData *data = [UserInfoHandle getUserInfoFromLocal];
                data.isLogin = NO;
                [UserInfoHandle saveUserInfo2Local:data];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } failureBlock:^(NSError *error) {
            
        } showHUD:YES];
    }
}

#pragma mark - 页面返回按钮事件
- (void)pageBackBtnSelect {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self.picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo {
    [self.picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.picker dismissViewControllerAnimated:YES completion:nil];
}
@end
