//
//  ProgramaStructure.h
//  henews
//
//  Created by 汪洋 on 15/11/10.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgramaStructure : NSObject


//比较本地栏目数据，并存储到本地(使用NSUserDefaults存储)
-(void)compareAndSave:(NSArray*)serverData OrderName:(NSString*)orderName NotOrderName:(NSString*)notOrderName;

//读取本地栏目数据
-(NSMutableArray*)readLocadPrograma:(NSString*)isOrNotOrderStr;
//保存栏目到本地
-(void)saveData:(NSMutableArray*)ary Key:(NSString*)key;

@end
