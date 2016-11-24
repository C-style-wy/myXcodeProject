//
//  SettingViewController.m
//  henews250
//
//  Created by 汪洋 on 2016/11/14.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SettingViewController.h"
#import "SHLUILabel.h"
#import "RechTextRegex.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initPage {
    [super initPage];
    self.pageTitle.text = @"设置";
    self.headView.shareBtn.hidden = YES;
    self.headView.line.hidden = YES;
    
    NSString *testStr = @"<B><U>本文共计3166字|建议阅\n读时间10分钟</U></B>\n<B>很多人在了解跟科<image:src=file://image/h001.png;rect=0,0,30,30>学发展相关的历史时</B>，总有一个错误的观念：科学的进步是一下子出现的——在某个历史节点上，一个先知般的人物瞬间获得了“完全正确的”认识，而其他人仍处在一种昏昏沉沉的迷惘状态之中。\n然而，任何<C:Ff0000>展的过程都是连续<N>的，所有青史留名的成就都是<B>“站在巨人肩膀上”</B>获得的，这就注定了极少会出现“众人皆醉我独醒”的人物。在审<C:0ff000>视历史的<N>过程中，我<image:src=file://image/h001.png;rect=0,0,30,30>们极难量化一个人的<U>思想——这其</U>中到底有多少对的成分？<node:text_normal=006496;text_selecteing=00ff00;text_selected=969696;data=0,5134630,http://211.140.7.174:8001/clt/publish/clt/resource/portal/v1/commonNews.jsp?c=5134630,0,1,内链.....苯酚;OnMouseUp=nodeOnMouseUp>内链.....苯酚</node><node:text_selecteing=00ff00;text_selected=ff0000;data=http://www.baidu.com;OnMouseUp=nodeOnMouseUp>超链接2</node>";
    
    SHLUILabel *label2 = [[SHLUILabel alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 500)];
    label2.textColor = [UIColor blackColor];
    [self.view addSubview:label2];
    label2.text = testStr;
    //    label2.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
    label2.font = [UIFont fontWithName:@"KaiTi_GB2312" size:17.0f];
//    label2.font = [UIFont boldSystemFontOfSize:17.0f];
    
    
//    NSString *searchText = @"// Do any additional setup after loading the view, typically from a nib.";
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexBStr options:NSRegularExpressionCaseInsensitive error:&error];

    NSArray *resultAry = [regex matchesInString:testStr options:0 range:NSMakeRange(0, [testStr length])];
    if (resultAry && resultAry.count > 0) {
        
        for (NSTextCheckingResult *result in resultAry) {
            NSLog(@"BBB=%@\n", [testStr substringWithRange:result.range]);
        }
    }
    
    NSRegularExpression *regexU = [NSRegularExpression regularExpressionWithPattern:regexUStr options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *resultUAry = [regexU matchesInString:testStr options:0 range:NSMakeRange(0, [testStr length])];
    if (resultUAry && resultUAry.count > 0) {
        
        for (NSTextCheckingResult *result in resultUAry) {
            NSLog(@"UUU=%@\n", [testStr substringWithRange:result.range]);
        }
    }
    
    NSRegularExpression *regexColor = [NSRegularExpression regularExpressionWithPattern:regexColorStr options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *resultColorAry = [regexColor matchesInString:testStr options:0 range:NSMakeRange(0, [testStr length])];
    if (resultColorAry && resultColorAry.count > 0) {
        
        for (NSTextCheckingResult *result in resultColorAry) {
            NSLog(@"color=%@\n", [testStr substringWithRange:result.range]);
        }
    }
    
    NSRegularExpression *regexPic = [NSRegularExpression regularExpressionWithPattern:regexPicStr options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *resultPicAry = [regexPic matchesInString:testStr options:0 range:NSMakeRange(0, [testStr length])];
    if (resultPicAry && resultPicAry.count > 0) {
        
        for (NSTextCheckingResult *result in resultPicAry) {
            NSLog(@"pic=%@\n", [testStr substringWithRange:result.range]);
        }
    }
    
    NSRegularExpression *regexLink = [NSRegularExpression regularExpressionWithPattern:regexLinkStr options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *resultLinkAry = [regexLink matchesInString:testStr options:0 range:NSMakeRange(0, [testStr length])];
    if (resultLinkAry && resultLinkAry.count > 0) {
        
        for (NSTextCheckingResult *result in resultLinkAry) {
            NSLog(@"link=%@\n", [testStr substringWithRange:result.range]);
        }
    }
    
    
    RechTextRegex *textssss = [RechTextRegex sharedInstance];
    textssss.orginalString = testStr;
}

@end
