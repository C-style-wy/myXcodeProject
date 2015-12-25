//
//  ChannelManageView.m
//  henews
//
//  Created by 汪洋 on 15/11/19.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "ChannelManageView.h"

#define openOrCloseTime (0.3f)
//设置标识
static NSString *indentify = @"indentify";

@implementation ChannelManageView

//重写initWithFrame
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, -frame.size.height, frame.size.width, frame.size.height)];
        _mainView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:0.98f];
        _mainView.clipsToBounds = YES;
        [self addSubview:_mainView];
        
        CustomCollectionViewFlowLayout *myFlowLayout=[[CustomCollectionViewFlowLayout alloc] init];
        [myFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height) collectionViewLayout:myFlowLayout];
        _myCollectionView.backgroundColor = [UIColor clearColor];
        [_mainView addSubview:_myCollectionView];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        [_myCollectionView registerClass:[ChannelCell class] forCellWithReuseIdentifier:indentify];
        
        self.myTipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-8, 30)];
        self.myTipsLabel.text = @"长按删除或长按拖动排序";
        self.myTipsLabel.textColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1];
        self.myTipsLabel.font = [UIFont systemFontOfSize:12];
        self.myTipsLabel.textAlignment = NSTextAlignmentRight;
        [_mainView addSubview:self.myTipsLabel];
        
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _headView.backgroundColor = [UIColor whiteColor];
        UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, _headView.frame.size.width-8, _headView.frame.size.height)];
        headLabel.textAlignment = NSTextAlignmentLeft;
        headLabel.textColor = [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1];
        headLabel.font = [UIFont systemFontOfSize:16];
        headLabel.text = @"更多频道";
        [_headView addSubview:headLabel];
        [_mainView addSubview:_headView];
        
        UICollectionViewFlowLayout *otherFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        [otherFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _otherCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height) collectionViewLayout:otherFlowLayout];
        _otherCollectionView.backgroundColor = [UIColor clearColor];
        [_mainView addSubview:_otherCollectionView];
        _otherCollectionView.delegate = self;
        _otherCollectionView.dataSource = self;
        [_otherCollectionView registerClass:[ChannelCell class] forCellWithReuseIdentifier:indentify];
        
        self.otherTipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-8, 30)];
        self.otherTipsLabel.text = @"点击添加";
        self.otherTipsLabel.textColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1];
        self.otherTipsLabel.font = [UIFont systemFontOfSize:12];
        self.otherTipsLabel.textAlignment = NSTextAlignmentRight;
        [_mainView addSubview:self.otherTipsLabel];
        
        _layoutHead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 58)];
        _layoutHead.backgroundColor = [UIColor whiteColor];
        
        
        UIButton *channelBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 44, 20, 44, 38)];
        [channelBtn addTarget:self action:@selector(closeChannelBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *addImg = [[UIImageView alloc]initWithFrame:CGRectMake(13, 10, 18, 18)];
        addImg.image = [UIImage imageNamed:@"class_add.png"];
        addImg.transform = CGAffineTransformMakeRotation(PI/4);
        _addImageView = addImg;
        [channelBtn addSubview:addImg];
        _channelBtn = channelBtn;
        
        _finishBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 20, 100, 38)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _finishBtn.frame.size.width-8, 38)];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1];
        label.font = [UIFont systemFontOfSize:16];
        label.text = @"完成";
        [_finishBtn addSubview:label];
        [_finishBtn addTarget:self action:@selector(finishBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *myChannelLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 20, 200, 38)];
        myChannelLabel.textAlignment = NSTextAlignmentLeft;
        myChannelLabel.textColor = [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1];
        myChannelLabel.font = [UIFont systemFontOfSize:16];
        myChannelLabel.text = @"我的频道";
        [_layoutHead addSubview:myChannelLabel];
        [_layoutHead addSubview:channelBtn];
        
        //给_myCollectionView添加长按事件
//        UILongPressGestureRecognizer *longPressGR =
//        [[UILongPressGestureRecognizer alloc] initWithTarget:self
//                                                      action:@selector(handleLongPress:)];
//        longPressGR.allowableMovement=YES;
//        longPressGR.minimumPressDuration = 0.5f;
//        longPressGR.delegate = self;
//        [_myCollectionView addGestureRecognizer:longPressGR];
        
    }
    return self;
}

//长按响应的事件
-(void)handleLongPress:(UILongPressGestureRecognizer*)gesture{
    _isEditStatu = true;
    //加上完成按钮
    [_layoutHead addSubview:_finishBtn];
    [_channelBtn removeFromSuperview];
    [_myCollectionView reloadData];
//    NSLog(@"长按======");
//    switch (gesture.state) {
//        case UIGestureRecognizerStateBegan:
//        {
//            NSLog(@"长按==Began====");
//            NSIndexPath *selectedIndexPath = [_myCollectionView indexPathForItemAtPoint:[gesture locationInView:_myCollectionView]];
//            [_myCollectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
////            break;
//        }
//        case UIGestureRecognizerStateChanged:
//        {
//            NSLog(@"长按==Changed====");
//            [_myCollectionView updateInteractiveMovementTargetPosition:[gesture locationInView:[gesture view]]];
//        }
//        default:
//            NSLog(@"长按==end====");
//            [_myCollectionView cancelInteractiveMovement];
//    }
}

- (void)closeChannelBtnSelect:(UIButton*)button{
    [self closeChannel];
}

-(void)finishBtnSelect:(UIButton*)button{
    _isEditStatu = false;
    [_myCollectionView reloadData];
    [_finishBtn removeFromSuperview];
    [_layoutHead addSubview:_channelBtn];
}

- (void)openChannel:(NSInteger)class Order:(NSString *)orderName NotOrder:(NSString *)notOrderName{
    _returnClass = class;
    //设置编辑状态为false
    _isEditStatu = false;
    
    ProgramaStructure *pro = [[ProgramaStructure alloc]init];
    _myChannelAry = [pro readLocadPrograma:orderName];
    _otherChannelAry = [pro readLocadPrograma:notOrderName];
    [self initCollectionData];
    [UIView animateWithDuration:openOrCloseTime
                     animations:^{
                         [_mainView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
                     }
                     completion:^(BOOL finished){
                         _mainView.clipsToBounds = NO;
                         self.clipsToBounds = NO;
                         [self.superview addSubview:_layoutHead];
                     }];
}

-(void)closeChannel{
    _mainView.clipsToBounds = YES;
    self.clipsToBounds = YES;
    [_delegate dealChannelChange:self returnClass:_returnClass];
    [UIView animateWithDuration:openOrCloseTime
                     animations:^{
                         [_mainView setFrame:CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height)];
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         [_layoutHead removeFromSuperview];
                     }];
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    theAnimation.duration=openOrCloseTime+0.06f;
    theAnimation.removedOnCompletion = YES;
    theAnimation.fromValue = [NSNumber numberWithFloat:PI/4];
    theAnimation.toValue = [NSNumber numberWithFloat:-PI/2];
    [_addImageView.layer addAnimation:theAnimation forKey:@"animateTransform"];
}

-(void)initCollectionData{
    [self.myCollectionView reloadData];
    NSLog(@"lineNum==%f", ((float)_myChannelAry.count/4));
    int lineNum = ceilf((float)_myChannelAry.count/4.0);
    float myCollectionHeight = lineNum*39+(lineNum-1)*6.5f+3;
    _myCollectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, myCollectionHeight);
    self.myTipsLabel.frame = CGRectMake(0, myCollectionHeight, SCREEN_WIDTH-8, 30);
    self.headView.frame = CGRectMake(0, myCollectionHeight+30, SCREEN_WIDTH, 40);
    int otherlineNum = ceilf((float)_otherChannelAry.count/4.0);
    float otherCollectionHeight = otherlineNum*39+(otherlineNum-1)*6.5f+3;
    if (otherCollectionHeight > _mainView.frame.size.height-myCollectionHeight-100) {
        otherCollectionHeight = _mainView.frame.size.height-myCollectionHeight-100;
    }
    self.otherCollectionView.frame = CGRectMake(0, myCollectionHeight+70, SCREEN_WIDTH, otherCollectionHeight);
    _otherTipsLabel.frame = CGRectMake(0, myCollectionHeight+70+otherCollectionHeight, SCREEN_WIDTH-8, 30);
    [_otherCollectionView reloadData];
    if (_otherChannelAry.count == 0) {
        _otherTipsLabel.hidden = YES;
        _headView.hidden = YES;
    }else{
        _otherTipsLabel.hidden = NO;
        _headView.hidden = NO;
    }
}

#pragma mark - UICollectionDelegate
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _myCollectionView) {
        return _myChannelAry.count;
    }else{
        return _otherChannelAry.count;
    }
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    columStruct *oneChannel = nil;
    ChannelCell *cell = (ChannelCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
    if (collectionView == _myCollectionView) {
        oneChannel = [_myChannelAry objectAtIndex:indexPath.row];
        [cell initWithData:oneChannel isEdit:_isEditStatu];
    }else{
        oneChannel = [_otherChannelAry objectAtIndex:indexPath.row];
        [cell initWithData:oneChannel isEdit:NO];
    }
    return cell;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-46)/4, 39);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(3, 8, 0, 8);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _otherCollectionView) {
        columStruct *temp = [_otherChannelAry objectAtIndex:indexPath.row];
        [_otherChannelAry removeObjectAtIndex:indexPath.row];
        [_myChannelAry addObject:temp];
        [self initCollectionData];
        ProgramaStructure *pro = [[ProgramaStructure alloc]init];
        [pro saveData:_myChannelAry Key:NEWS_ORDER];
        [pro saveData:_otherChannelAry Key:NEWS_NOT_ORDER];
    }else{
        if (_isEditStatu) {
            columStruct *colum = [_myChannelAry objectAtIndex:indexPath.row];
            if (![colum.showAllTime isEqual:@"1"]) {
                columStruct *temp = [_myChannelAry objectAtIndex:indexPath.row];
                [_myChannelAry removeObjectAtIndex:indexPath.row];
                [_otherChannelAry addObject:temp];
                [self initCollectionData];
                ProgramaStructure *pro = [[ProgramaStructure alloc]init];
                [pro saveData:_myChannelAry Key:NEWS_ORDER];
                [pro saveData:_otherChannelAry Key:NEWS_NOT_ORDER];
            }
        }else{
            _returnClass = indexPath.row;
            [self closeChannel];
        }
    }
}

//设定指定区内Cell的最小行距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 6.5f;
}

//设定指定区内Cell的最小间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 9.5f;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//Moves an item from one location to another in the collection view.
- (void)moveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath{
    NSLog(@"moveItemAtIndexPath=======");
}

@end
