//
//  PlayViewController.m
//  henews
//
//  Created by 汪洋 on 15/11/11.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "PlayViewController.h"

@implementation PlayViewController{
    PlayerView *_playView;
    UIView *_redLine;
    UILabel *_introLabel;
    UILabel *_commentLabel;
    UIScrollView *_mainScrollView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self preferredStatusBarStyle];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(BOOL)shouldAutorotate{
    return !_playView.isSwitch;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = VIEWBACKGROUND_COLOR;
    
    [self createUI];
    
    UIView *statuView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    statuView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:statuView];

    [Request requestPostForJSON:@"playData" url:_playUrl delegate:self paras:nil msg:0 useCache:NO];
}

-(void)dealloc{
    //关闭播放器并销毁当前播放view
    //一定要在退出时使用,否则内存可能释放不了
    NSLog(@"dealloc====");
    [_playView close];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createUI{
    UIView *twoButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 191, SCREEN_WIDTH, 44)];
    twoButtonView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:twoButtonView];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, twoButtonView.frame.size.height-0.5f, SCREEN_WIDTH, 0.5f)];
    line.image = [UIImage imageNamed:@"menuFenge.png"];
    [twoButtonView addSubview:line];
    
    UIView *redLine = [[UIView alloc]initWithFrame:CGRectMake(0, twoButtonView.frame.size.height-3.5f, SCREEN_WIDTH/2, 3.5f)];
    redLine.backgroundColor = ROSERED;
    [twoButtonView addSubview:redLine];
    _redLine = redLine;
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2*i, 0, SCREEN_WIDTH/2, twoButtonView.frame.size.height)];
        [twoButtonView addSubview:btn];
        btn.tag = i+1;
        [btn addTarget:self action:@selector(twoBtnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label = [[UILabel alloc]initWithFrame:btn.bounds];
        if (i == 0) {
            label.text = @"简介";
            label.textColor = ROSERED;
            _introLabel = label;
        }else{
            label.text = @"评论";
            label.textColor = [UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.00];
            _commentLabel = label;
        }
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.5f];
        [btn addSubview:label];
    }
    
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, twoButtonView.frame.origin.y+twoButtonView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-(twoButtonView.frame.origin.y+twoButtonView.frame.size.height)-35.5f)];
    [self.view addSubview:_mainScrollView];
    _mainScrollView.delegate = self;
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, 0);
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _mainScrollView.frame.size.width, _mainScrollView.frame.size.height)];
    label1.textColor = ROSERED;
    label1.text = @"简介";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:15.5f];
    [_mainScrollView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, _mainScrollView.frame.size.width, _mainScrollView.frame.size.height)];
    label2.textColor = ROSERED;
    label2.text = @"评论";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:15.5f];
    [_mainScrollView addSubview:label2];
}

-(void)requestDidReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg isCacheReturn:(BOOL)flag{
    if ([tag isEqual:@"playData"]) {
        [self dealPlayDataBack:returnJson];
    }else if ([tag isEqual:@"playUrl"]){
        NSString *filePath = [returnJson objectForKey:@"url"];
        _playView = [[PlayerView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 171) url:filePath delegate:self haveOriginalUI:YES];
        _playView.title = @"标题";
        [self.view addSubview:_playView];
    }
}

-(void)dealPlayDataBack:(NSDictionary*)jsonData{
    NSString *getPlayUrl = [jsonData objectForKey:@"getPlayUrl"];
    [Request requestPostForJSON:@"playUrl" url:getPlayUrl delegate:self paras:nil msg:0 useCache:NO];
}

#pragma mark - 点击事件
//返回
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
//两个按钮响应事件
-(void)twoBtnClickEvent:(UIButton*)button{
    if (button.tag == 1) { //简介
        CGRect preFrame = _redLine.frame;
        if (preFrame.origin.x != 0) {
            _introLabel.textColor = ROSERED;
            _commentLabel.textColor = [UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.00];
            [_mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }else{
        CGRect preFrame = _redLine.frame;
        if (preFrame.origin.x != SCREEN_WIDTH/2) {
            _introLabel.textColor = [UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.00];
            _commentLabel.textColor = ROSERED;
            [_mainScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}
//scrollView停止滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float x = scrollView.contentOffset.x;
    if (x == SCREEN_WIDTH) {
        _introLabel.textColor = [UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.00];
        _commentLabel.textColor = ROSERED;
    }else{
        _introLabel.textColor = ROSERED;
        _commentLabel.textColor = [UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.00];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float x = scrollView.contentOffset.x;
    if (x <= 320 && x >= 0) {
        _redLine.frame = CGRectMake(x/2, _redLine.frame.origin.y, _redLine.frame.size.width, _redLine.frame.size.height);
    }
}
@end
