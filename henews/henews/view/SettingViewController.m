//
//  SettingViewController.m
//  henews
//
//  Created by 汪洋 on 16/3/31.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SettingViewController.h"
#import <objc/runtime.h>
#import "SHLUILabel.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.head.pageTitle.text = @"设置";
    self.head.shareButton.hidden = YES;
    
    //测试
    Class class = [self class];
    SEL originalSelector = @selector(viewDidAppear:);
    SEL swizzledSelector = @selector(fd_viewDidAppear:);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200)];
    textLabel.backgroundColor = [UIColor colorWithHexColor:@"#d7f7f2"];
    textLabel.font = [UIFont systemFontOfSize:15];
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:textLabel];
//    textLabel.text = @"<B>我是传奇</B>";
    NSString *textString = @"啊啊啊淡定的<B>我</B>是<B>传奇</B>定的wwwwwwww";
    NSMutableAttributedString *attributedString =[[NSMutableAttributedString alloc]initWithString:textString];
    
//    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"<B>(\\s)*(\\S)*<\\/B>" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"<B>((?!</B>.<B>).)*<\\/B>" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //        NSArray *match = [reg matchesInString:labelString options:NSMatchingCompleted range:NSMakeRange(0, [labelString length])];
    NSArray *match = [reg matchesInString:textString options:NSMatchingReportCompletion range:NSMakeRange(0, [textString length])];
    for (int i = 0; i < match.count; i++) {
        NSTextCheckingResult *result = [match objectAtIndex:i];
        
        [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:textLabel.font.pointSize] range:NSMakeRange(result.range.location + 3, result.range.length - 7)];
        
//        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(result.range.location,result.range.length)];
//        attributedString.string =  [textString substringToIndex:7];
        
    }
    
    
    textLabel.attributedText = attributedString;
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear");
}

- (void)fd_viewDidAppear:(BOOL)animated{
    [self fd_viewDidAppear:animated];
    NSLog(@"fd_viewDidAppear");
    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//    view.center = CGPointMake(160, 400);
//    view.backgroundColor = ROSERED;
//    [self.view addSubview:view];
    
    
    
//    CASpringAnimation *spring = [[CASpringAnimation alloc]init];
//    spring.keyPath = @"position.x";
//    spring.damping = 5;
//    spring.stiffness = 100;
//    spring.mass = 1;
//    spring.initialVelocity = 0;
////    spring.fromValue = (double)view.layer.position.x;
////    spring.toValue = view.layer.position.x + 50;
//    spring.duration = spring.settlingDuration;
//    [view.layer addAnimation:spring forKey:spring.keyPath];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
