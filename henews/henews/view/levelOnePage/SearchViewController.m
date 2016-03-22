//
//  SearchViewController.m
//  henews
//
//  Created by 汪洋 on 15/10/23.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "SearchViewController.h"
#import <objc/runtime.h>

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = VIEWBACKGROUND_COLOR;
    
    
    static char overviewKey;
    NSArray *array = [[NSArray alloc]initWithObjects:@"One", @"Two", @"Three", nil];
    NSLog(@"array=before===%@", array);
    NSString *overview = [[NSString alloc] initWithFormat:@"%@", @"First three numbers"];
    objc_setAssociatedObject(array, &overviewKey, overview, OBJC_ASSOCIATION_RETAIN);
    NSLog(@"array=end===%@", array);
    
    NSString *associatedObject = (NSString*)objc_getAssociatedObject(array, &overviewKey);
    NSLog(@"associatedObject==%@", associatedObject);
    
    //创建UILabel
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 0)];
    label.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:label];
    //自动换行
    label.numberOfLines = 0;
    //设置label内容宽度
    CGFloat textWidth = SCREEN_WIDTH;
    //获取数据
    NSString *text = @"获取数据获取数据,获取数据获取7数据获取数据9获取［］数据获取rt6数据获［］取数据获取数据获取数据获取数据获取数据］、获取数据获取数据";
    //创建NSMutableAttributedString实例，并将text传入
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:text];
    //创建NSMutableParagraphStyle实例
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentNatural;
    //设置行距
    [style setLineSpacing:20.0f];
    //判断内容长度是否大于Label内容宽度，如果不大于，则设置内容宽度为行宽（内容如果小于行宽，Label长度太短，如果Label有背景颜色，将影响布局效果）
    NSInteger leng = textWidth;
    if (attStr.length < textWidth) {
        leng = attStr.length;
    }
    //根据给定长度与style设置attStr式样
    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, leng)];
    //Label获取attStr式样
    label.attributedText = attStr;
    //Label自适应大小
    [label sizeToFit];
    //设置Label高度
//    label.height = label.frame.size.height;
//    [self conversionCharacterInterval:70 current:text withLabel:label];
    
    
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shareWeibo.jpg"]];
    image.frame = self.view.frame;
    image.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:image];
    self.photoImage = image;

    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)];
    
//    [pinchRecognizer setDelegate:self];
    [self.view addGestureRecognizer:pinchRecognizer];
    
}

-(void)scale:(id)sender {
    
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _lastScale = 1.0;
    }
    
    CGFloat scale = 1.0 - (_lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    
    CGAffineTransform currentTransform = self.photoImage.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
    [self.photoImage setTransform:newTransform];
    
    _lastScale = [(UIPinchGestureRecognizer*)sender scale];
//    [self showOverlayWithFrame:photoImage.frame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)conversionCharacterInterval:(NSInteger)maxInteger current:(NSString *)currentString withLabel:(UILabel *)label{
    CGRect rect = [[currentString substringToIndex:1] boundingRectWithSize:CGSizeMake(200,label.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: label.font}context:nil];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:currentString];
    float strLength = [self getLengthOfString:currentString];
    [attrString addAttribute:NSKernAttributeName value:@(((maxInteger - strLength) * rect.size.width)/(strLength - 1)) range:NSMakeRange(0, strLength)];
    label.attributedText = attrString;
}

- (float)getLengthOfString:(NSString*)str {
    float strLength = 0;
    char *p = (char *)[str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (NSInteger i = 0 ; i < [str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            strLength++;
        }
        p++;
    }
    return strLength/2;
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
