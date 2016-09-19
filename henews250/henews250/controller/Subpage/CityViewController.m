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
    self.pageTitle.text = [@"当前城市-" stringByAppendingString:[[CityManager shareInstance] getLocalCity]];
    self.pageShareBtn.hidden = YES;
    
    self.edit.delegate = self;
    
    [self.edit addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.cityTableView.delegate = self;
    self.cityTableView.dataSource = self;
    self.cityTableView.sectionIndexColor = MainColor;
    
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    self.searchTableView.sectionIndexColor = LRClearColor;
    self.searchTableView.hidden = YES;
    
    [NetworkManager postRequestJsonWithURL:DEF_GetCitypage params:nil cacheBlock:^(NSDictionary *returnJson) {
        if (returnJson) {
            CityListMode *cityListMode = [CityListMode mj_objectWithKeyValues:returnJson];
            [self dealDataAndShow:cityListMode];
        }
    } successBlock:^(NSDictionary *returnJson) {
        if (returnJson) {
            CityListMode *cityListMode = [CityListMode mj_objectWithKeyValues:returnJson];
            [self dealDataAndShow:cityListMode];
        }
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - dealData
- (void)dealDataAndShow:(CityListMode*)data {
    if (!_cityAry) {
        _cityAry = [[NSMutableArray alloc]init];
    }
    [_cityAry removeAllObjects];
    
    CityListItemMode *currentCity = [[CityListItemMode alloc]init];
    currentCity.letter = @"您当前的位置可能是";
    currentCity.cities = [[NSArray alloc]initWithObjects:[[CityManager shareInstance] getLocalCity],nil];
    [_cityAry addObject:currentCity];
    
    if ([[CityManager shareInstance] getChoceCityAry].count > 0) {
        CityListItemMode *choceCity = [[CityListItemMode alloc]init];
        choceCity.letter = @"经常选择的城市";
        choceCity.cities = [[CityManager shareInstance] getChoceCityAry];
        [_cityAry addObject:choceCity];
    }
    
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
    [self dealSearchTextChange:NullString];
}


- (void) textFieldDidChange:(UITextField *)textField {
    NSString *str = textField.text;
    if ([str isEqualToString:@""]) {
        self.deleteBtn.hidden = YES;
    }else{
        self.deleteBtn.hidden = NO;
    }
    [self dealSearchTextChange:str];
}

- (void)dealSearchTextChange:(NSString*)str {
    if ([str isEqualToString:@""]) {
        _cityTableView.hidden = NO;
        _searchTableView.hidden = YES;
        _view_null.hidden = YES;
    }else{
        if (!_searchCityAry) {
            _searchCityAry = [[NSMutableArray alloc]init];
        }
        [_searchCityAry removeAllObjects];
        
        BOOL have = NO;
        for (int i=0; i<_cityAry.count; i++) {
            CityListItemMode *itemMode = [_cityAry objectAtIndex:i];
            for (int j=0; j<itemMode.cities.count; j++) {
                NSString *city = [itemMode.cities objectAtIndex:j];
                if ([city rangeOfString:str].location != NSNotFound) {
                    have = YES;
                    BOOL searchAryNotHave = YES;
                    for (int m = 0; m < _searchCityAry.count; m++) {
                        if ([city isEqualToString:[_searchCityAry objectAtIndex:m]]) {
                            searchAryNotHave = NO;
                        }
                    }
                    if (searchAryNotHave) {
                        [_searchCityAry addObject:city];
                    }
                }
            }
        }
        
        [_searchTableView reloadData];
        if (have) {
            _cityTableView.hidden = YES;
            _searchTableView.hidden = NO;
            _view_null.hidden = YES;
        }else{
            _cityTableView.hidden = YES;
            _searchTableView.hidden = YES;
            _view_null.hidden = NO;
        }
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
    if (tableView == _cityTableView) {
        return self.cityAry.count;
    }else{
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (tableView == _cityTableView) {
        CityListItemMode *sectionMode = [self.cityAry objectAtIndex:section];
        CityListSectionView *sectionView = [[CityListSectionView loadFromNib]initWithSectionName:sectionMode.letter];
        return sectionView;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _cityTableView) {
        return 27.0f;
    }else{
        return 0;
    }
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _cityTableView) {
        CityListItemMode *sectionMode = [self.cityAry objectAtIndex:section];
        return sectionMode.cities.count;
    }else{
        return _searchCityAry.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _cityTableView) {
        CityListItemMode *sectionMode = [self.cityAry objectAtIndex:indexPath.section];
        CityListCell *cell = [CityListCell cellWithTableView:tableView];
        BOOL hiddenLine = NO;
        if (sectionMode.cities.count == indexPath.row + 1) {
            hiddenLine = YES;
        }
        [cell setCityName:[sectionMode.cities objectAtIndex:indexPath.row] hiddenLine:hiddenLine];
        return cell;
    }else {
        CityListCell *cell = [CityListCell cellWithTableView:tableView];
        [cell setCityName:[_searchCityAry objectAtIndex:indexPath.row] hiddenLine:NO];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_WIDTH*36.0f/320.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.edit resignFirstResponder];
    NSString *selectCityName;
    if (tableView == _cityTableView) {
        CityListItemMode *sectionMode = [self.cityAry objectAtIndex:indexPath.section];
        selectCityName = [sectionMode.cities objectAtIndex:indexPath.row];
    }else{
        selectCityName = [_searchCityAry objectAtIndex:indexPath.row];
    }
    NSString *currentCity = [[CityManager shareInstance] getCity];
    [[CityManager shareInstance] addChoseCity:selectCityName];
    if (![currentCity isEqualToString:[[CityManager shareInstance] getCity]]) {
        self.changeCityBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
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
    if (tableView == _cityTableView) {
        return toBeReturned;
    }else{
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if (tableView == _cityTableView) {
        NSInteger count = 0;
        for(int i = 0; i < _cityAry.count; i++) {
            CityListItemMode *itemMode = [_cityAry objectAtIndex:i];
            if([itemMode.letter isEqualToString:title]) {
                return count;
            }
            count ++;
        }
        return 0;
    }else{
        return 0;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if([_cityAry count]==0) {
        return @"";
    }
    return [_cityAry objectAtIndex:section];
}

@end
