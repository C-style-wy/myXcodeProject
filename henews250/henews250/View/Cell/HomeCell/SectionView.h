//
//  SectionView.h
//  henews250
//
//  Created by 汪洋 on 16/7/21.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LoadFromNib.h"
#import "NodeMode.h"
#import "MacroDefinition.h"
#import "NewsCellFactory.h"

@protocol SectionDelegate <NSObject>

@required
- (void)requestSectionChange:(NSString*)url section:(NSInteger)section;
- (void)jumpToMore:(NodeMode*)node;

@end

@interface SectionView : UIView
@property (weak, nonatomic) IBOutlet UILabel *modulName;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *modulNameWidth;

@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UILabel *changeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *changeIcon;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, assign) id<SectionDelegate> delegate;


- (id)initWithData:(NodeMode *)nodeMode section:(NSInteger)section;
@end
