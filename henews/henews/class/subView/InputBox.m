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
    UILabel *stickLabel;
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
        
        UIImageView *inputBg = [[UIImageView alloc]initWithFrame:CGRectMake(8.5f, 35.5f, SCREEN_WIDTH-2*8.5f, 84)];
        inputBg.image = [UIImage imageNamed:@"detail_input.png"];
        [bgView addSubview:inputBg];
        
        inputBox = [[UITextView alloc]initWithFrame:CGRectMake(8.5f, 35.5f, SCREEN_WIDTH-2*8.5f, 84)];
        inputBox.backgroundColor = [UIColor clearColor];
        inputBox.textColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1];
//        inputBox.backgroundColor=[UIColor whiteColor]; //背景色
        inputBox.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
        inputBox.editable = YES;        //是否允许编辑内容，默认为“YES”
//        inputBox.delegate = self;       //设置代理方法的实现类
        inputBox.font=[UIFont fontWithName:@"Arial" size:14.0f]; //设置字体名字和字体大小;
        inputBox.returnKeyType = UIReturnKeyDefault;//return键的类型
        inputBox.keyboardType = UIReturnKeySend;//键盘类型
        inputBox.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
        inputBox.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
        [bgView addSubview:inputBox];
        [self registerForKeyboardNotifications];
        
        UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(8.5f, 0, 40, inputBox.frame.origin.y)];
        [cancelBtn setImage:[UIImage imageNamed:@"detail_cancel.png"] forState:UIControlStateNormal];
        [cancelBtn setImageEdgeInsets:UIEdgeInsetsMake(9, 0, 9, 0)];
        [cancelBtn addTarget:self action:@selector(bgButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:cancelBtn];
        
        UIButton *sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40.0f-8.5f, 0, 40, inputBox.frame.origin.y)];
        [sendBtn setImage:[UIImage imageNamed:@"detail_send.png"] forState:UIControlStateNormal];
        [sendBtn setImageEdgeInsets:UIEdgeInsetsMake(9, 0, 9, 0)];
        [sendBtn addTarget:self action:@selector(sendBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:sendBtn];
    }
    return self;
}


- (void)openInputBox:(UIViewController *)controller stickLabel:(UILabel*)label{
    [controller.view addSubview:self];
    bgView.alpha = 0.0f;
    colorView.alpha = 0.0f;
    [UIView animateWithDuration:0.25f animations:^{
        bgView.alpha = 1.0f;
        colorView.alpha = 0.25f;
    }];
    stickLabel = label;
    if (![stickLabel.text isEqualToString:@"我也说一句"] && ![stickLabel.text isEqualToString:@""]) {
        NSString *string = [stickLabel.text substringFromIndex:4];
        inputBox.text = string;
    }
    [inputBox becomeFirstResponder];
}

- (void)bgButtonAction:(UIButton*)button{
    if (![inputBox.text isEqualToString:@""]) {
        NSString *caotieStr = @"「草贴」";
        NSString *caotieAddText = [caotieStr stringByAppendingString:inputBox.text];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:caotieAddText];
        [text addAttribute:NSForegroundColorAttributeName value:ROSERED range:NSMakeRange(0, 4)];
        stickLabel.attributedText = text;
    }else{
        stickLabel.text = @"我也说一句";
    }
    
    [self removeFromSuperview];
}

- (void)sendBtnAction:(UIButton*)button{
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
    [UIView animateWithDuration:0.5f animations:^{
        bgView.frame = CGRectMake(0, SCREEN_HEIGHT-height-134, SCREEN_WIDTH, 134);
    }];
}
@end
