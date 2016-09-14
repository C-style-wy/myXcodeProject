//
//  CoreDataManager.m
//  henews250
//
//  Created by 汪洋 on 16/9/12.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "CoreDataManager.h"
// 数据库名称
static NSString *const CoreDataSQLiteName = @"CoreDataCache.sqlite";

@interface CoreDataManager ()

@property (nonatomic, strong) NSManagedObjectContext *objectContext; // 托管对象上下文

@end

@implementation CoreDataManager

/// 数据库存储路径（document）
NSString *GetDocumentPathFileName(NSString *lpFileName) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if (paths && 0 != paths.count) {
        NSString *documentsDirectory = [paths objectAtIndex:0];
        if (documentsDirectory && 0 != documentsDirectory.length) {
            if (lpFileName && 0 != lpFileName.length) {
                NSString *filePath = [documentsDirectory stringByAppendingPathComponent:lpFileName];
                return filePath;
            }
        }
    }
    return nil;
}

- (id)init {
    self = [super init];
    if (self) {
        if (!self.objectContext) {
            // 指定存储数据文件(CoreData是建立在SQLite之上的,文件后缀名为:xcdatamodel)
            NSString *persistentStorePath = GetDocumentPathFileName(CoreDataSQLiteName);
            NSURL *storeUrl = [NSURL fileURLWithPath:persistentStorePath];
            
            // 数据迁移
            NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                     [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
            
            
            // 创建托管对象模型
            //            NSManagedObjectModel  *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
            NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CacheModel" withExtension:@"momd"];
            NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
            
            // 创建持久化存储协调器,并使用SQLite数据库做持久化存储
            NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
            
            NSError *error = nil;
            NSPersistentStore *persistentStore = [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error];
            
            // 创建托管对象上下文
            if (persistentStore && !error) {
                NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
                [managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
                
                self.objectContext = managedObjectContext;
            }else {
                NSLog(@"failed to add persistent store with type to persistent store coordinator");
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            }
        }
    }
    return self;
}


+ (CoreDataManager *)shareManager {
    static CoreDataManager *staticCoreDataManager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        staticCoreDataManager = [[self alloc] init];
        assert(staticCoreDataManager != nil);
    });
    return staticCoreDataManager;
}

- (id)createEmptyObjectWithEntityName:(NSString *)entityName {
    NSManagedObject *managerObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.objectContext];
    return managerObject;
}

- (NSArray *)getListWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptions entityName:(NSString *)entityName limitNum:(NSNumber *)limitNum {
    NSError *error = nil;
    
    // 创建取回数据请求
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    // 设置查询条件
    [fetchRequest setPredicate:predicate];
    
    // 设置排序条件
    [fetchRequest setSortDescriptors:sortDescriptions];
    
    // 查询条件的总数
    [fetchRequest setFetchLimit:[limitNum intValue]];
    
    // 执行获取数据请求,返回数组
    NSArray *fetchResult = [self.objectContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchResult;
}

- (BOOL)deleteObject:(NSManagedObject *)object {
    [self.objectContext deleteObject:object];
    
    BOOL isSuccess = [self save];
    return isSuccess;
}

- (void)deleteObject:(NSManagedObject *)object complete:(void (^)(BOOL isSuccess))complete {
    BOOL isSuccess = [self deleteObject:object];
    if (complete) {
        complete(isSuccess);
    }
}

- (BOOL)deleteAllObjectWithEntityName:(NSString *)entityName {
    NSArray *allObjects = [self getListWithPredicate:nil sortDescriptors:nil entityName:entityName limitNum:nil];
    if (allObjects && 0 != allObjects.count) {
        for (NSManagedObject *object in allObjects) {
            [self.objectContext deleteObject:object];
        }
        BOOL isSuccess = [self save];
        return isSuccess;
    }
    return NO;
}

- (void)deleteAllObjectWithEntityName:(NSString *)entityName complete:(void (^)(BOOL isSuccess))complete {
    BOOL isSuccess = [self deleteAllObjectWithEntityName:entityName];
    if (complete) {
        complete(isSuccess);
    }
}

- (BOOL)save {
    NSError *error = nil;
    BOOL isSuccess = [self.objectContext save:&error];
    return isSuccess;
}

- (void)save:(void (^)(BOOL isSuccess))complete {
    BOOL isSuccess = [self save];
    if (complete) {
        complete(isSuccess);
    }
}

@end
