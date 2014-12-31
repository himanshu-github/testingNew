//
//  Last Updated by Alok on 19/02/14.
//  Copyright (c) 2014 Aryansbtloe. All rights reserved.
//


#import "DatabaseManager.h"
#import "DKPredicateBuilder.h"
#import "CoreDataModals.h"
#import "ApplicationSpecificConstants.h"
#import "MagicalRecord+Setup.h"
#import "NSManagedObject+MagicalFinders.h"
#import "NSManagedObject+MagicalRecord.h"
#import "UserInfo.h"

@implementation DatabaseManager

#define MANAGED_OBJECT_CONTEXT [NSManagedObjectContext MR_contextForCurrentThread]


#pragma mark - initializer methods

static DatabaseManager * databaseManager_ = nil;

+ (DatabaseManager *)sharedDatabaseManager {
	CONTINUE_IF_MAIN_THREAD @synchronized(databaseManager_) {
		static dispatch_once_t pred;
		dispatch_once(&pred, ^{
		    if (databaseManager_ == nil) {
		        databaseManager_ = [[DatabaseManager alloc]init];
		        [MagicalRecord setupCoreDataStack];
			}
		});
	}
    
	return databaseManager_;
}

+ (id)alloc {
	NSAssert(databaseManager_ == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}
- (void)setUserInfo:(NSMutableDictionary *)dict {
    
    
    [self removeUserInfo];
    
    UserInfo *obj = [UserInfo MR_createInContext:MANAGED_OBJECT_CONTEXT];
    
    obj.user_id = [dict objectForKey:@"id"];
    obj.oauth_key = [dict objectForKey:@"OAUTH_KEY"];
    obj.user_address = [dict objectForKey:@"user_address"];
    obj.user_age = [dict objectForKey:@"user_age"];
    obj.user_contact = [dict objectForKey:@"user_contact"];
    obj.user_email = [dict objectForKey:@"user_email"];
    obj.user_fname = [dict objectForKey:@"user_fname"];
    obj.user_image = [dict objectForKey:@"user_image"];
    obj.user_lname = [dict objectForKey:@"user_lname"];
    obj.user_type = [dict objectForKey:@"user_type"];
    obj.requirment_added = [NSString stringWithFormat:@"%@",[dict objectForKey:@"requirment_added"]];
    obj.creation_date = [dict objectForKey:@"creation_date"];
    obj.user_status = [dict objectForKey:@"user_status"];
    obj.sound = [dict objectForKey:@"sound"];
    obj.notification = [dict objectForKey:@"notification"];
    obj.amount = [dict objectForKey:@"user_amount"];

    [self saveData];
    
}


- (void)removeUserInfo {
   
	[UserInfo MR_truncateAllInContext:MANAGED_OBJECT_CONTEXT];
    [self saveData];
    
}



//Getter
- (id)getUserInfo {
	return [UserInfo MR_findFirst];
}

// array of a single property by condition
-(NSArray *)getArrayOfProperty:(NSString *)propertyName inEntity:(NSString *)entityName withCondition:(NSPredicate *)condition
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:MANAGED_OBJECT_CONTEXT];
    [fetchRequest setEntity:entity];
    fetchRequest.propertiesToFetch = [NSArray arrayWithObject:[[entity propertiesByName] objectForKey:propertyName]];
    fetchRequest.returnsDistinctResults = YES;
    fetchRequest.resultType = NSDictionaryResultType;
    [fetchRequest setPredicate:condition];
    NSError *error;
    return [MANAGED_OBJECT_CONTEXT executeFetchRequest:fetchRequest error:&error];
}

-(NSArray *)findAllInEntity:(NSString *)entityName withCondition:(NSPredicate *)condition
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:MANAGED_OBJECT_CONTEXT];
    [fetchRequest setEntity:entity];
    //fetchRequest.resultType = NSDictionaryResultType;
    [fetchRequest setPredicate:condition];
    NSError *error;
    return [MANAGED_OBJECT_CONTEXT executeFetchRequest:fetchRequest error:&error];
}


-(NSArray *)findEntity:(NSString *)entityName withCondition:(NSPredicate *)condition
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:MANAGED_OBJECT_CONTEXT];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:condition];
    NSError *error;
    return [MANAGED_OBJECT_CONTEXT executeFetchRequest:fetchRequest error:&error];
}

#pragma mark - common methods to work with core data

- (void)saveData {
	static NSTimer *timer = nil;
	if ([self isNotNull:timer])
		[timer invalidate];
	timer = [NSTimer scheduledTimerWithTimeInterval:TIME_DELAY_IN_FREQUENTLY_SAVING_CHANGES target:self selector:@selector(actuallySave) userInfo:nil repeats:NO];
}

- (void)actuallySave {
	[MANAGED_OBJECT_CONTEXT MR_saveToPersistentStoreAndWait];
}

- (NSPredicate *)preparePredicateByAndingKeysAndObjectFromDictionary:(NSDictionary *)info {
	DKPredicateBuilder *predicateBuilder = [[DKPredicateBuilder alloc] init];
	for (NSString *key in info.allKeys) {
		if ([self isNotNull:[info objectForKey:key]])
			[predicateBuilder where:key contains:[info objectForKey:key]];
	}
	return [NSPredicate predicateWithFormat:[[predicateBuilder compoundPredicate] predicateFormat]];
}

- (void)resetCompleteDatabase {
//	[UserInfo MR_truncateAllInContext:MANAGED_OBJECT_CONTEXT];
	[self saveData];
}

- (NSMutableArray *)getAllContentsFor:(Class)entity {
	return [self getAllContentsUsingContext:MANAGED_OBJECT_CONTEXT ForEntity:entity WithPredicate:nil asDictionary:NO];
}

- (NSMutableArray *)getAllContentsUsingContext:(NSManagedObjectContext *)context ForEntity:(Class)entity WithPredicate:(NSPredicate *)predicate asDictionary:(BOOL)asDictionary {
	NSArray *results = [entity MR_findAllWithPredicate:predicate];
	return [[NSMutableArray alloc]initWithArray:results];
}

- (id)fetchSingleForEntity:(Class)entity WithPredicate:(NSPredicate *)predicate {
	return [entity MR_findFirstWithPredicate:predicate];
}

@end
