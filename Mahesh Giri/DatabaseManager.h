//
//  Last Updated by Alok on 19/02/14.
//  Copyright (c) 2014 Aryansbtloe. All rights reserved.
//


#define MANAGED_OBJECT_CONTEXT [NSManagedObjectContext MR_contextForCurrentThread]

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <UIKit/UIKit.h>

@interface DatabaseManager : NSObject

+ (DatabaseManager *)sharedDatabaseManager;



- (void)setUserInfo:(NSMutableDictionary *)dict;


- (NSMutableArray *)getAllContentsFor:(Class)entity;
-(id)getUserInfo;

- (void)resetCompleteDatabase;
- (void)actuallySave;
- (void)saveData ;



-(NSArray *)getArrayOfProperty:(NSString *)propertyName inEntity:(NSString *)entityName withCondition:(NSPredicate *)condition;
-(NSArray *)findAllInEntity:(NSString *)entityName withCondition:(NSPredicate *)condition;
- (void)removeUserInfo;
-(NSArray *)findEntity:(NSString *)entityName withCondition:(NSPredicate *)condition;

@end
