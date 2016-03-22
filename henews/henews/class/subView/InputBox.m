//
//  InputBox.m
//  henews
//
//  Created by 汪洋 on 16/3/21.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "InputBox.h"

@interface InputBox ()
{
    UITextView *inputBox;
    UIView *bgView;
    UIView *colorView;
}

@end

@implementation InputBox

- (id)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
        
        colorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        colorView.backgroundColor = [UIColor blackColor];
        colorView.alpha = 0.25f;
        [self addSubview:colorView];
        
        UIButton *bgButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [bgButton addTarget:self action:@selector(bgButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];
        
        bgView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-134, SCREEN_WIDTH, 134)];
        bgView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        [self addSubview:bgView];
        
        UIImageView *inputBg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-302)/2, 35.5f, 302, 84)];
        inputBg.image = [UIImage imageNamed:@"detail_input.png"];
        [bgView addSubview:inputBg];
        
        inputBox = [[UITextView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-302)/2, 35.5f, 302, 84)];
        inputBox.backgroundColor = [UIColor clearColor];
        [bgView addSubview:inputBox];
        [self registerForKeyboardNotifications];
    }
    return self;
}


- (void)openInputBox:(UIViewController *)controller{
    [controller.view addSubview:self];
    bgView.alpha = 0.0f;
    colorView.alpha = 0.0f;
    [UIView animateWithDuration:0.25f animations:^{
        bgView.alpha = 1.0f;
        colorView.alpha = 0.25f;
    }];
    [inputBox becomeFirstResponder];
}

- (void)bgButtonAction:(UIButton*)button{
    NSLog(@"bgButtonAction==");
    [self removeFromSuperview];
}

- (void) registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void) keyboardWasShown:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"keyBoard:%f", keyboardSize.height);  //216
    bgView.frame = CGRectMake(0, SCREEN_HEIGHT-keyboardSize.height-134, SCREEN_WIDTH, 134);
}
- (void) keyboardWasHidden:(NSNotification *) notif
{
//    NSDictionary *info = [notif userInfo];
//    
//    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    CGSize keyboardSize = [value CGRectValue].size;
    bgView.frame = CGRectMake(0, SCREEN_HEIGHT-134, SCREEN_WIDTH, 134);
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    NSLog(@"keyboardWillShow=h==%f", height);
    [UIView animateWithDuration:0.5f animations:^{
        bgView.frame = CGRectMake(0, SCREEN_HEIGHT-height-134, SCREEN_WIDTH, 134);
    }];
}
@end
