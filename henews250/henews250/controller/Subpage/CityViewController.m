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
    self.pageTitle.text = @"当前城市-合肥";
    self.pageShareBtn.hidden = YES;
    
    self.edit.delegate = self;
    
    [self.edit addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.cityTableView.delegate = self;
    self.cityTableView.dataSource = self;
    self.cityTableView.sectionIndexColor = MainColor;
    
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
    if (!_cityAry) {
        _cityAry = [[NSMutableArray alloc]init];
    }
    [_cityAry removeAllObjects];
    
    CityListItemMode *currentCity = [[CityListItemMode alloc]init];
    currentCity.letter = @"您当前的位置可能是";
    currentCity.cities = [[NSArray alloc]initWithObjects:@"合肥",nil];
    
    CityListItemMode *choceCity = [[CityListItemMode alloc]init];
    choceCity.letter = @"经常选择的城市";
    choceCity.cities = [[NSArray alloc]initWithObjects:@"杭州", @"玉树", nil];
    
    [_cityAry addObject:currentCity];
    [_cityAry addObject:choceCity];
    
    [_cityAry addObjectsFromArray:data.cityList];
    [self.cityTableView reloadData];
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

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cityAry.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CityListItemMode *sectionMode = [self.cityAry objectAtIndex:section];
    CityListSectionView *sectionView = [[CityListSectionView loadFromNib]initWithSectionName:sectionMode.letter];
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 27.0f;
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CityListItemMode *sectionMode = [self.cityAry objectAtIndex:section];
    return sectionMode.cities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityListItemMode *sectionMode = [self.cityAry objectAtIndex:indexPath.section];
    CityListCell *cell = [CityListCell cellWithTableView:tableView];
    
    BOOL hiddenLine = NO;
    if (sectionMode.cities.count == indexPath.row + 1) {
        hiddenLine = YES;
    }
    [cell setCityName:[sectionMode.cities objectAtIndex:indexPath.row] hiddenLine:hiddenLine];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_WIDTH*36.0f/320.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.edit resignFirstResponder];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.edit resignFirstResponder];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *toBeReturned = [[NSMutableArray alloc]init];
    for(char c = 'A';c<='Z';c++) {
        for(int i = 0; i < _cityAry.count; i++) {
            CityListItemMode *itemMode = [_cityAry objectAtIndex:i];
            if([itemMode.letter isEqualToString:[NSString stringWithFormat:@"%c", c]]) {
                [toBeReturned addObject:[NSString stringWithFormat:@"%c",c]];
                break;
            }
        }
    }
    return toBeReturned;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    NSInteger count = 0;
    for(int i = 0; i < _cityAry.count; i++) {
        CityListItemMode *itemMode = [_cityAry objectAtIndex:i];
        if([itemMode.letter isEqualToString:title]) {
            return count;
        }
        count ++;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if([_cityAry count]==0) {
        return @"";
    }
    return [_cityAry objectAtIndex:section];
}

@end
