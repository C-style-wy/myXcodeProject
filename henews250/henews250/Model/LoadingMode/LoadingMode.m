//
//  LoadingMode.m
//  henews250
//
//  Created by 汪洋 on 16/7/15.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "LoadingMode.h"

@implementation LoadingMode

MJCodingImplementation

+ (NSDictionary*)objectClassInArray {
    return @{
        @"hNewsNodes":@"SingleColMode",
        @"videoNodes":@"SingleColMode",
    };
}

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
//+ (NSDictionary *)replacedKeyFromPropertyName
//{
//    return @{
//             @"ID" : @"id",
//             @"desc" : @"desciption",
//             @"oldName" : @"name.oldName",
//             @"nowName" : @"name.newName",
//             @"nameChangedTime" : @"name.info.nameChangedTime",
//             @"bag" : @"other.bag"
//             };
//}

@end
