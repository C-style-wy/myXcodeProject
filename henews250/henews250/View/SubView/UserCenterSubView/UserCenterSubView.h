//
//  UserCenterSubView.h
//  henews250
//
//  Created by 汪洋 on 2016/10/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterSubView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UIButton *headBtn;

@property (weak, nonatomic) IBOutlet UILabel *sname;
@property (weak, nonatomic) IBOutlet UIButton *snameBtn;

@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UIButton *sexBtn;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneNumBtn;

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIButton *emailBtn;

@property (weak, nonatomic) IBOutlet UILabel *addreLabel;
@property (weak, nonatomic) IBOutlet UIButton *addreBtn;

@property (weak, nonatomic) IBOutlet UIButton *exitBtn;

@end
