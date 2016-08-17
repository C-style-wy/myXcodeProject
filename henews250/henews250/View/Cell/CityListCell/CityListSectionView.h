//
//  CityListSectionView.h
//  henews250
//
//  Created by 汪洋 on 16/8/16.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LoadFromNib.h"

@interface CityListSectionView : UIView
@property (weak, nonatomic) IBOutlet UILabel *letter;

- (id)initWithSectionName:(NSString *)sectionName;

@end
