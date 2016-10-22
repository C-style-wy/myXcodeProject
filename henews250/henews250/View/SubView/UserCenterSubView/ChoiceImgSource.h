//
//  ChoiceImgSource.h
//  henews250
//
//  Created by 汪洋 on 2016/10/22.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *
 */
typedef void (^PhotoBlock)();
/**
 *
 */
typedef void (^AlbumBlock)();

@interface ChoiceImgSource : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnViewBottom;
@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UIView *viewBlow;

@property (nonatomic, assign) PhotoBlock photoBlock;
@property (nonatomic, assign) AlbumBlock albumBlock;

/**
 *   target
 */
@property (nonatomic,assign) id tagrget;
/**
 *   action
 */
@property (nonatomic,assign) SEL photoAction;
/**
 *   action
 */
@property (nonatomic,assign) SEL albumAction;

+ (ChoiceImgSource*)shareInstance;

- (void)showWithSupView:(UIView *)newSupview photoBlock:(PhotoBlock)photoBlock albumBlock:(AlbumBlock)albumBlock;

- (void)showWithSupView:(UIView *)newSupview target:(id)target photoAction:(SEL)photoAction albumAction:(SEL)albumAction;

- (void)dismiss;
@end
