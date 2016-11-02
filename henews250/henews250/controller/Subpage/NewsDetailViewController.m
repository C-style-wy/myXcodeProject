//
//  NewsDetailViewController.m
//  henews250
//
//  Created by 汪洋 on 16/9/7.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NewsDetailViewController.h"

static NSString * const NewsDetailTag = @"NewsDetailTag";

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headView.hidden = YES;
//    self.collectionBtn.selected = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initPage {
    [super initPage];
    if (self.url && ![self.url isEqualToString:@""]) {
        [NetworkManager postRequestJsonWithURL:self.url params:nil delegate:self tag:NewsDetailTag msg:0 useCache:YES update:YES showHUD:YES];
    }
}

#pragma mark - 网络返回
- (void)requestDidFinishLoading:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg{
    self.newsDetailData = [NewsDetailMode mj_objectWithKeyValues:returnJson];
}

//缓存数据返回
- (void)requestDidCacheReturn:(NSString*)tag returnJson:(NSDictionary*)returnJson msg:(NSInteger) msg {
    
}

- (void)requestdidFailWithError:(NSError*)error tag:(NSString *)tag msg:(NSInteger)msg {

}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(headerHeight);
            make.leading.offset(0);
            make.trailing.offset(0);
            make.bottom.offset(35.5);
        }];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.pageData.count;
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pageData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 按钮点击事件
- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)collectionBtnAction:(id)sender {
}
- (IBAction)nightBtnAction:(id)sender {
}
- (IBAction)shareBtnAction:(id)sender {
}
- (IBAction)fontBtnAction:(id)sender {
}
- (IBAction)commentBtnAction:(id)sender {
}

- (IBAction)inputBtnAction:(id)sender {
    NSLog(@"inputBtnAction=====");
}

@end
