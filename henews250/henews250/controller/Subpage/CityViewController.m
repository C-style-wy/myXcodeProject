//
//  CityViewController.m
//  henews250
//
//  Created by 汪洋 on 16/8/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "CityViewController.h"
#import "CityListMode.h"

@interface CityViewController ()

@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle.text = @"城市选择";
    self.pageShareBtn.hidden = YES;
    
    self.edit.delegate = self;
    
    [self.edit addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    NSString *url = [SERVER_URL stringByAppendingString:CityList_Url];
    [Request requestPostForJSON:@"cittList" url:url delegate:self paras:nil msg:0 useCache:YES update:YES];
}

#pragma mark - 网络返回
-(void)requestDidReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg isCacheReturn:(BOOL)flag{

    if ([tag isEqualToString:@"cittList"]) {
        if (returnJson) {
            CityListMode *cityListMode = [CityListMode mj_objectWithKeyValues:returnJson];
            [self dealDataAndShow:cityListMode];
        }
    }
}

#pragma mark - dealData
- (void)dealDataAndShow:(CityListMode*)data {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deleteBtnSelect:(id)sender {
    self.edit.text = NullString;
    self.deleteBtn.hidden = YES;
}


- (void) textFieldDidChange:(UITextField *)textField {
    NSString *str = textField.text;
    if ([str isEqualToString:@""]) {
        self.deleteBtn.hidden = YES;
    }else{
        self.deleteBtn.hidden = NO;
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //回收键盘,取消第一响应者
    [textField resignFirstResponder];
    return YES;
}
//点击空白处收回键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.edit resignFirstResponder];
}
@end
