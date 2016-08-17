//
//  CityViewController.h
//  henews250
//
//  Created by 汪洋 on 16/8/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "SubBaseViewController.h"
#import "CityListCell.h"
#import "CityListSectionView.h"

@interface CityViewController : SubBaseViewController<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *edit;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (weak, nonatomic) IBOutlet UITableView *cityTableView;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) IBOutlet UIView *view_null;

@property (nonatomic, retain) NSMutableArray *cityAry;
@property (nonatomic, retain) NSMutableArray *searchCityAry;
@end
