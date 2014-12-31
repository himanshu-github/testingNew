//
//  Last Updated by Alok on 19/02/14.
//  Copyright (c) 2014 Aryansbtloe. All rights reserved.
//

#ifndef UIDevice_Macros_h
#define UIDevice_Macros_h

#define IS_IPAD                                         (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE                                       (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5                                     (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)

#define IS_IPHONE_4                                    (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)480) < DBL_EPSILON)

#define CURRENT_DEVICE_VERSION_FLOAT  [[UIDevice currentDevice] systemVersion].floatValue
#define CURRENT_DEVICE_VERSION_STRING [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define IS_CAMERA_AVAILABLE [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]

#define FIX_IOS_7_EDGE_START_LAY_OUT_ISSUE     if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) self.edgesForExtendedLayout = UIRectEdgeNone;

/*
 Message Okay button title for all alerts in the application
 */
#define MESSAGE_OKAY_BUTTON_NAME    @"Ok"
#define MESSAGE_CANCEL_BUTTON_NAME  @"Cancel"

//1>
#define MESSAGE_TITLE___FOR_NETWORK_NOT_REACHABILITY   @"Oops!"
#define MESSAGE_TEXT___FOR_NETWORK_NOT_REACHABILITY    @"No internet connection detected."

//2>
#define MESSAGE_TITLE___FOR_SERVER_NOT_REACHABILITY   @"Oops!"
#define MESSAGE_TEXT___FOR_SERVER_NOT_REACHABILITY    @"There is a network error. Please try again!"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#endif
