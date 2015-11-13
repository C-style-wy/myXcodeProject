//
//  DetailViewController.m
//  henews
//
//  Created by 汪洋 on 15/10/19.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "DetailViewController.h"
#import "Request.h"
#import "UIImageView+AFNetworking.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = VIEWBACKGROUND_COLOR;
    NSLog(@"detailUrl=viewDidLoad=");
    [self UIInit];
}

-(void)UIInit{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 58)];
    headView.backgroundColor = [UIColor whiteColor];
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 38)];
    titleView.backgroundColor = [UIColor clearColor];
    [headView addSubview:titleView];
    [self.view addSubview:headView];
    
    UILabel *viewTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, titleView.frame.size.height)];
    viewTitle.textAlignment = NSTextAlignmentCenter;
    viewTitle.text = @"和新闻";

    viewTitle.textColor = VIEWTITLECOLOR;
    viewTitle.font = VIEWTITLEFONT;
    [titleView addSubview:viewTitle];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, titleView.frame.size.height)];
    
    [backBtn addTarget:self action:@selector(backBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:backBtn];
    
    [backBtn setImage:[UIImage imageNamed:@"back_arrow.png"] forState:UIControlStateNormal];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(9.5f, 8, 9.5f, 41)];
    
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.frame = CGRectMake(0, 58, SCREEN_WIDTH, SCREEN_HEIGHT-58);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
}

- (void)backBtnSelect:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getUrl:(NSString *)urlString{
    NSLog(@"detailUrl==%@", urlString);
    [Request requestPostForJSON:@"detailData" url:urlString delegate:self paras:nil msg:0];
}

-(void)requestDidReturn:(NSString*)tag returnStr:(NSString*)returnStr returnJson:(NSDictionary*)returnJson msg:(NSInteger)msg;{
    if ([tag isEqual:@"detailData"]) {
        [self dealDetailDataBack:returnJson];
    }
}

-(void)dealDetailDataBack:(NSDictionary*)jsonData{
//    NSLog(@"jsonData====%@", jsonData);
    if (!_tableViewData) {
        _tableViewData = [[NSMutableArray alloc]init];
    }
    [_tableViewData removeAllObjects];
    //处理标题以及来源和时间
    NewsTitleCellData *titleCell = [[NewsTitleCellData alloc]init];
    NSDictionary *content = [jsonData objectForKey:@"content"];
    NSString *title = [content objectForKey:@"name"];
    NSString *source = [content objectForKey:@"source"];
    NSString *time = [content objectForKey:@"pubTime"];
    [titleCell initWithData:title source:source time:time];
    
    [_tableViewData addObject:titleCell];
    
    NewsShareCellData *shareCell = [[NewsShareCellData alloc]init];
    [_tableViewData addObject:shareCell];
    
    NSArray *detailContent = [content objectForKey:@"content"];
    for (int i = 0; i < detailContent.count; i++) {
        NSDictionary *temp = [detailContent objectAtIndex:i];
        
        NewsContentCellData *contentData = [[NewsContentCellData alloc]init];
        NSString *contentText = [temp objectForKey:@"content"];
        [contentData initWithData:contentText];
        if (![contentData.content isEqual:@""]) {
            [_tableViewData addObject:contentData];
        }
        
        NewsPicCellData *picData = [[NewsPicCellData alloc]init];
        NSArray *picAry = [temp objectForKey:@"imageInfoList"];
        if (picAry && picAry.count > 0) {
            [picData initWithData:[picAry objectAtIndex:0]];
        }
        if (![picData.picUrl isEqual:@""]) {
            [_tableViewData addObject:picData];
        }
    }
    
    NewsShareCellData *shareCell2 = [[NewsShareCellData alloc]init];
    [_tableViewData addObject:shareCell2];
    
    [_tableView reloadData];
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
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsTitleCellData class]]) {
        NewsTitleCellData *one = [_tableViewData objectAtIndex:indexPath.row];
        NewsTitleCell *cell = [NewsTitleCell cellWithTableView:tableView];
        [cell loadTableCell:one];
        return cell;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsShareCellData class]]){
        NewsShareCell *cell = [NewsShareCell cellWithTableView:tableView];
        return cell;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsContentCellData class]]){
        NewsContentCellData *one = [_tableViewData objectAtIndex:indexPath.row];
        NewsContentCell *cell = [NewsContentCell cellWithTableView:tableView];
        [cell loadTableCell:one];
        return cell;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsPicCellData class]]){
        NewsPicCellData *one = [_tableViewData objectAtIndex:indexPath.row];
        NewsPicCell *cell = [NewsPicCell cellWithTableView:tableView];
        [cell loadTableCell:one];
        return cell;
    }
    else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsTitleCellData class]]) {
        NewsTitleCellData *one = [_tableViewData objectAtIndex:indexPath.row];
        return one.height;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsShareCellData class]]){
        NewsShareCellData *one = [_tableViewData objectAtIndex:indexPath.row];
        return one.height;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsShareCellData class]]){
        NewsShareCellData *one = [_tableViewData objectAtIndex:indexPath.row];
        return one.height;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsContentCellData class]]){
        NewsContentCellData *one = [_tableViewData objectAtIndex:indexPath.row];
        return one.height;
    }else if ([[_tableViewData objectAtIndex:indexPath.row] isKindOfClass:[NewsPicCellData class]]){
        NewsPicCellData *one = [_tableViewData objectAtIndex:indexPath.row];
        return one.height;
    }else{
        return 0;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
