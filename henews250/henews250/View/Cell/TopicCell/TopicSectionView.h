//
//  TopicSectionView.h
//  henews250
//
//  Created by 汪洋 on 2016/11/18.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialNodeListModel.h"

@protocol TopicSectionViewDelegate <NSObject>

@required
- (void)sectionBtnAction:(NSString*)url name:(NSString *)name;

@end

@interface TopicSectionView : UIView

@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;
@property (weak, nonatomic) IBOutlet UIButton *sectionBtn;

@property (nonatomic, retain) SpecialNodeListModel *specialNodeListModel;
@property (nonatomic, assign) id<TopicSectionViewDelegate> delegate;

@end
