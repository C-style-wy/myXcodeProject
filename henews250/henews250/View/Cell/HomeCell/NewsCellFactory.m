//
//  NewsCellFactory.m
//  henews250
//
//  Created by 汪洋 on 16/7/20.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NewsCellFactory.h"

#import "OneSmallPicCell.h"
#import "EveryOneCell.h"
#import "ThreeSmallPicCell.h"
#import "OneBigPicCell.h"

@implementation NewsCellFactory

+ (BaseCell*)getCell:(NewsMode *)news tableView:(UITableView *)tableView hiddenLine:(BOOL)hidden isShortLine:(BOOL)isShort{
    
    switch ([news.displayType intValue]) {
        //一张大图
        case OneBigPicNews:{
            OneBigPicCell *cell = [OneBigPicCell cellWithTableView:tableView];
            [cell setNews:news hiddenLine:hidden isShortLine:isShort];
            return cell;
            break;
        }
        //三张小图
        case ThreeSmallPicNews:{
            ThreeSmallPicCell *cell = [ThreeSmallPicCell cellWithTableView:tableView];
            [cell setNews:news hiddenLine:hidden isShortLine:isShort];
            return cell;
            break;
        }
        //大家
        case EveryOneNews:{
            EveryOneCell *cell = [EveryOneCell cellWithTableView:tableView];
            [cell setNews:news hiddenLine:hidden isShortLine:isShort];
            return cell;
            break;
        }
        //感性
        case SensibilityNews:{
            EveryOneCell *cell = [EveryOneCell cellWithTableView:tableView];
            [cell setNews:news hiddenLine:hidden isShortLine:isShort];
            return cell;
            break;
        }
        //左小图
        case OneSmallPicNews:{
            OneSmallPicCell *cell = [OneSmallPicCell cellWithTableView:tableView];
            [cell setNews:news hiddenLine:hidden isShortLine:isShort];
            return cell;
            break;
        }
        //中图
        case OneMiddPicNews:{
            OneBigPicCell *cell = [OneBigPicCell cellWithTableView:tableView];
            [cell setNews:news hiddenLine:hidden isShortLine:isShort];
            return cell;
            break;
        }
        default:{
            OneSmallPicCell *cell = [OneSmallPicCell cellWithTableView:tableView];
            [cell setNews:news hiddenLine:hidden isShortLine:isShort];
            return cell;
            break;
        }
    }
    
}

+ (CGFloat)getHeightForRow:(NewsMode *)news {
    switch ([news.displayType intValue]) {
        //一张大图
        case OneBigPicNews:{
            return SCREEN_WIDTH*218.0f/320.0f;
            break;
        }
        //三张小图
        case ThreeSmallPicNews:{
            return SCREEN_WIDTH*146.0f/320.0f;
            break;
        }
        //大家
        case EveryOneNews:{
            return SCREEN_WIDTH*98.0f/320.0f;
            break;
        }
        //感性
        case SensibilityNews:{
            return SCREEN_WIDTH*98.0f/320.0f;
            break;
        }
        //左小图
        case OneSmallPicNews:{
            return SCREEN_WIDTH*88.0f/320.0f;
            break;
        }
        //中图
        case OneMiddPicNews:{
            return SCREEN_WIDTH*171.0f/320.0f;
            break;
        }
        default:{
            return SCREEN_WIDTH*88.0f/320.0f;
            break;
        }
    }
}

@end
