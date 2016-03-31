//
//  PlayViewController.m
//  henews
//
//  Created by 汪洋 on 15/11/11.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "PlayViewController.h"
#import "SHLUILabel.h"
#import "InputBox.h"
#import "CTUIScrollView.h"

@implementation PlayViewController{
    PlayerView *_playView;
    UIView *_redLine;
    UILabel *_introLabel;
    UILabel *_commentLabel;
    CTUIScrollView *_mainScrollView;
    NSString *_playViewTitle;
    //是否隐藏状态栏
    BOOL _hideBar;
    UIScrollView *_introScrollView;
    UILabel *_sayLabel;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden{
    //    return !showToolBarAndText; //返回NO表示要显示，返回YES将hiden
    return _hideBar;
}

-(BOOL)shouldAutorotate{
    return !_playView.isSwitch;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _hideBar = NO;
    self.view.backgroundColor = VIEWBACKGROUND_COLOR;
    
    UIView *statuView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20+171)];
    statuView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:statuView];
    [self createUI];
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
    
    _mainScrollView = [[CTUIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(twoButtonView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-(twoButtonView.frame.origin.y+twoButtonView.frame.size.height)-35.5f)];
    [self.view addSubview:_mainScrollView];
    _mainScrollView.delegate = self;
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.bounces = NO;
    _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, 0);
    
    _introScrollView = [[UIScrollView alloc]initWithFrame:_mainScrollView.bounds];
    _introScrollView.delegate = self;
    _introScrollView.showsHorizontalScrollIndicator = NO;
    _introScrollView.showsVerticalScrollIndicator = YES;
    _introScrollView.pagingEnabled = NO;
    _introScrollView.alwaysBounceHorizontal = NO;
    _introScrollView.alwaysBounceVertical = YES;
    [_mainScrollView addSubview:_introScrollView];
//    _introScrollView.backgroundColor = [UIColor redColor];
    
    //底部控制Bar
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-30.5f, SCREEN_WIDTH, 30.5f)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIButton *commentBtn = [[UIButton alloc]initWithFrame:CGRectMake(8, 0, 231.5f, 30.5f)];
    [commentBtn addTarget:self action:@selector(handleCommentBtnSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [commentBtn setImage:[UIImage imageNamed:@"inputBox_play.png"] forState:UIControlStateNormal];
    [commentBtn setImage:[UIImage imageNamed:@"inputBox_play.png"] forState:UIControlStateHighlighted];
    [commentBtn setImageEdgeInsets:UIEdgeInsetsMake(3.0f, 0.0f, 3.0f, 0.0f)];
    [view addSubview:commentBtn];
    
    UIImageView *penImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"detail_comment_icon.png"]];
    penImage.frame = CGRectMake(8.5f, (commentBtn.frame.size.height - 11)/2, 11, 11);
    [commentBtn addSubview:penImage];
    
    UILabel *sayLabel = [[UILabel alloc]initWithFrame:CGRectMake(25.0f, 0, commentBtn.frame.size.width-25.0f, commentBtn.frame.size.height)];
    sayLabel.text = @"我也说一句";
    _sayLabel = sayLabel;
    sayLabel.textAlignment = NSTextAlignmentLeft;
    sayLabel.textColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1];
    sayLabel.font = [UIFont systemFontOfSize:13.0f];
    [commentBtn addSubview:sayLabel];
    
    //字体大小调整
    UIButton *fontSizeBtn = [[UIButton alloc]initWithFrame:CGRectMake(250.5f, 0, 35.5, 30.5f)];
    [fontSizeBtn addTarget:self action:@selector(handleFontSizeBtnSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [fontSizeBtn setImage:[UIImage imageNamed:@"setBtn.png"] forState:UIControlStateNormal];
    [fontSizeBtn setImageEdgeInsets:UIEdgeInsetsMake(3.0f, 0.0f, 3.0f, 11.0f)];
    [view addSubview:fontSizeBtn];
    //分享
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-35.5, 0, 35.5, 30.5f)];
    [shareBtn addTarget:self action:@selector(handleShareBtnSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [shareBtn setImage:[UIImage imageNamed:@"detail_share_icon.png"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"newShare_s.png"] forState:UIControlStateHighlighted];
    [shareBtn setImageEdgeInsets:UIEdgeInsetsMake(3.0f, 0.0f, 3.0f, 11.0f)];
    [view addSubview:shareBtn];
    //添加播放器UI
    _playView = [[PlayerView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 171) delegate:self baseImageUrl:self.baseImageUrl];
    [self.view addSubview:_playView];
}

-(void)requestDidReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg isCacheReturn:(BOOL)flag{
    if ([tag isEqual:@"playData"]) {
        [self dealPlayDataBack:returnJson];
    }else if ([tag isEqual:@"playUrl"]){
        NSString *filePath = [returnJson objectForKey:@"url"];
//        _playView = [[PlayerView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 171) url:filePath delegate:self haveOriginalUI:YES];
        [_playView setPlayerUrlAndPlay:filePath];
        _playView.title = _playViewTitle;
//        [self.view addSubview:_playView];
    }
}

-(void)dealPlayDataBack:(NSDictionary*)jsonData{
    NSString *getPlayUrl = [jsonData objectForKey:@"getPlayUrl"];
    _playViewTitle = [[jsonData objectForKey:@"content"] objectForKey:@"name"];
    [Request requestPostForJSON:@"playUrl" url:getPlayUrl delegate:self paras:nil msg:0 useCache:NO];
    
    SHLUILabel *title = [[SHLUILabel alloc]init];
    title.font = [UIFont systemFontOfSize:17.0f];
    title.text = [[jsonData objectForKey:@"content"] objectForKey:@"name"];
    title.textColor = [UIColor colorWithRed:0.12 green:0.12 blue:0.12 alpha:1.00];
    
    title.lineBreakMode = NSLineBreakByWordWrapping;
    title.numberOfLines = 0;
    float titleH = [title getAttributedStringHeightWidthValue:_introScrollView.frame.size.width-16];
    title.frame = CGRectMake(8, 13, _introScrollView.frame.size.width-16, titleH);
    [_introScrollView addSubview:title];
    
    SHLUILabel *introduction = [[SHLUILabel alloc]init];
    introduction.font = [UIFont systemFontOfSize:15.0f];
    introduction.text = [[jsonData objectForKey:@"content"] objectForKey:@"summary"];
    introduction.textColor = [UIColor colorWithRed:0.12 green:0.12 blue:0.12 alpha:1.00];
    
    introduction.lineBreakMode = NSLineBreakByWordWrapping;
    introduction.numberOfLines = 0;
    float introductionH = [introduction getAttributedStringHeightWidthValue:_introScrollView.frame.size.width-16];
    introduction.frame = CGRectMake(8, 13+titleH+5, _introScrollView.frame.size.width-16, introductionH);
    [_introScrollView addSubview:introduction];
    _introScrollView.contentSize = CGSizeMake(0, 13+titleH+5+introductionH);
}
#pragma mark - playViewDelegate
//返回
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    //    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)hideOrShowStaBar:(BOOL)hide{
    _hideBar = hide;
    [self setNeedsStatusBarAppearanceUpdate];
}


#pragma mark - 点击事件
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
    if ([scrollView isEqual:_mainScrollView]) {
        float x = scrollView.contentOffset.x;
        if (x == SCREEN_WIDTH) {
            _introLabel.textColor = [UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.00];
            _commentLabel.textColor = ROSERED;
        }else{
            _introLabel.textColor = ROSERED;
            _commentLabel.textColor = [UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.00];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:_mainScrollView]) {
        float x = scrollView.contentOffset.x;
        if (x <= 320 && x >= 0) {
            _redLine.frame = CGRectMake(x/2, _redLine.frame.origin.y, _redLine.frame.size.width, _redLine.frame.size.height);
        }
    }
}

#pragma mark - 点击事件
- (void)handleCommentBtnSelectAction:(UIButton*)button{
    InputBox *inputBox = [[InputBox alloc]init];
    [inputBox openInputBox:self stickLabel:_sayLabel];
}
- (void)handleFontSizeBtnSelectAction:(UIButton*)button{
    
}
- (void)handleShareBtnSelectAction:(UIButton*)button{
    
}
@end
