//
//  Last Updated by Alok on 19/02/14.
//  Copyright (c) 2014 Aryansbtloe. All rights reserved.
//

#ifndef Singleton_Macros_h
#define Singleton_Macros_h


#define SINGLETON_INTERFACE_FOR_CLASS( classname, accessorname )         \
+ (classname *)accessorname;

#define SINGLETON_IMPLEMENTATION_FOR_CLASS( classname, accessorname ) \
+ (classname *)accessorname                                              \
{                                                                        \
static classname *accessorname = nil;                                    \
static dispatch_once_t onceToken;                                        \
dispatch_once(&onceToken, ^{                                             \
accessorname = [[classname alloc] init];                                 \
});                                                                      \
return accessorname;                                                     \
}

#endif
