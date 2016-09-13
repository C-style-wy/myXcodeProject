//
//  CoreDataManager.h
//  henews250
//
//  Created by 汪洋 on 16/9/12.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

/**
 *  单例模式
 *
 *  @return CoreDataManager
 */
+ (CoreDataManager *)shareManager;

/**
 *  创建空的表映射对象
 *
 *  @param entityName entityName实体描述名
 *
 *  @return id实体类对象
 */
- (id)createEmptyObjectWithEntityName:(NSString *)entityName;

/**
 *  查询托管对象上下文中的对象
 *
 *  @param predicate        predicate查询条件
 *  @param sortDescriptions sortDescriptions排序条件
 *  @param entityName       entityName实体描述名
 *  @param limitNum         limitNum返回总个数
 *
 *  @return NSArray
 */
- (NSArray *)getListWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptions entityName:(NSString *)entityName limitNum:(NSNumber *)limitNum;

/**
 *  删除托管对象上下文中的一个对象
 *
 *  @param object object需要删除的任意对象
 *
 *  @return BOOL
 */
- (BOOL)deleteObject:(NSManagedObject *)object;

/**
 *  删除托管对象上下文中的一个对象
 *
 *  @param object   object需要删除的任意对象
 *  @param complete complete block回调
 */
- (void)deleteObject:(NSManagedObject *)object complete:(void (^)(BOOL isSuccess))complete;

/**
 *  删除托管对象上下文中的所有对象
 *
 *  @param entityName entityName实体描述名
 *
 *  @return BOOL
 */
- (BOOL)deleteAllObjectWithEntityName:(NSString *)entityName;

/**
 *  删除托管对象上下文中的所有对象
 *
 *  @param entityName entityName实体描述名
 *  @param complete   complete block回调
 */
- (void)deleteAllObjectWithEntityName:(NSString *)entityName complete:(void (^)(BOOL isSuccess))complete;

/**
 *  保存托管对象上下文中的更改
 *
 *  @return BOOL
 */
- (BOOL)save;

/**
 *  保存托管对象上下文中的更改
 *
 *  @param complete complete block回调
 */
- (void)save:(void (^)(BOOL isSuccess))complete;

@end
