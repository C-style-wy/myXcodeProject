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

-(void)compareAndSave:(NSArray*)serverData{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *newsOrder = [userDefaults arrayForKey:@"newsOrder"];
    NSArray *newsNotOrder = [userDefaults arrayForKey:@"newsNotOrder"];
    
    NSMutableArray *localNewsOrder = [[NSMutableArray alloc]init];
    NSMutableArray *localNewsNotOrder = [[NSMutableArray alloc]init];
    for (int i = 0; i < serverData.count; i++) {
        columStruct *temp = [[columStruct alloc]init];
        [temp setData:[serverData objectAtIndex:i]];
        NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:temp];
        if ([temp.isMore isEqual:@"1"]) {
            [localNewsNotOrder addObject:udObject];
        }else{
            [localNewsOrder addObject:udObject];
        }
    }
    
    if (newsOrder) {

    }else{
        newsOrder = [localNewsOrder copy];
        newsNotOrder = [localNewsNotOrder copy];
        [userDefaults setObject:newsOrder forKey:@"newsOrder"];
        [userDefaults setObject:newsNotOrder forKey:@"newsNotOrder"];
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

@end
