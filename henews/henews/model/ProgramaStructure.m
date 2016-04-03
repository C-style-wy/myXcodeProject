//
//  ProgramaStructure.m
//  henews
//
//  Created by 汪洋 on 15/11/10.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "ProgramaStructure.h"
#import "columStruct.h"

@implementation ProgramaStructure

-(void)compareAndSave:(NSArray*)serverData OrderName:(NSString *)orderName NotOrderName:(NSString *)notOrderName{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *newsOrder = [userDefaults arrayForKey:orderName];
    NSArray *newsNotOrder = [userDefaults arrayForKey:notOrderName];
    
    NSMutableArray *localNewsOrder = [[NSMutableArray alloc]init];
    NSMutableArray *localNewsNotOrder = [[NSMutableArray alloc]init];
    for (int i = 0; i < serverData.count; i++) {
        columStruct *temp = [[columStruct alloc]init];
        [temp setData:[serverData objectAtIndex:i]];
        if (![temp.nodeName isEqualToString:@""]) {
            NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:temp];
            
            if ([temp.isMore isEqual:@"1"]) {
                [localNewsNotOrder addObject:udObject];
            }else{
                [localNewsOrder addObject:udObject];
            }
        }
    }
    
    if (newsOrder) {

    }else{
        newsOrder = [localNewsOrder copy];
        newsNotOrder = [localNewsNotOrder copy];
        [userDefaults setObject:newsOrder forKey:orderName];
        [userDefaults setObject:newsNotOrder forKey:notOrderName];
        [userDefaults synchronize];
    }
}

-(NSMutableArray*)readLocadPrograma:(NSString*)isOrNotOrderStr{
    NSMutableArray *tempAry = [[NSMutableArray alloc]init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *proAry = [userDefaults arrayForKey:isOrNotOrderStr];
    if (!proAry) {
        return nil;
    }else{
        for (int i = 0 ; i < proAry.count; i++) {
            columStruct *tempStru = [NSKeyedUnarchiver unarchiveObjectWithData:[proAry objectAtIndex:i]];
            [tempAry addObject:tempStru];
        }
        return tempAry;
    }
}

-(void)saveData:(NSMutableArray*)ary Key:(NSString*)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    for (int i = 0; i<ary.count; i++) {
        columStruct *colum = [ary objectAtIndex:i];
        NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:colum];
        [temp addObject:udObject];
    }
    [userDefaults setObject:[temp copy] forKey:key];
    [userDefaults synchronize];
}

@end
