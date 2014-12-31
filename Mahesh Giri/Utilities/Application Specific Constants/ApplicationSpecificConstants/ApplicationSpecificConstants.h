//
//  Last Updated by Alok on 19/02/14.
//  Copyright (c) 2014 Aryansbtloe. All rights reserved.
//

#ifndef ApplicationSpecificConstants_h
#define ApplicationSpecificConstants_h

/**
 Constants:-

 This header file holds all configurable constants specific  to this application.

 */

////////////////////////////////////////SOME MACROS TO MAKE YOUR PROGRAMING LIFE EASIER/////////////////////////////////////////

/**
 return if no internet connection is available with and without error message
 */
#define RETURN_IF_NO_INTERNET_AVAILABLE_WITH_USER_WARNING if (![CommonFunctions getStatusForNetworkConnectionAndShowUnavailabilityMessage:YES]) return;
#define RETURN_IF_NO_INTERNET_AVAILABLE                   if (![CommonFunctions getStatusForNetworkConnectionAndShowUnavailabilityMessage:NO]) return;

#define METHOD_IMPLEMENTATION_FOR_INITIALIZATION_PLUS_DEALLOC_PLUS_MEMORY_WARNING \
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {\
self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];            \
if (self) {                                                                       \
}                                                                             \
return self;                                                                  \
}                                                                                 \
- (id)init {                                                                      \
self = [super init];                                                          \
if (self) {                                                                   \
}                                                                             \
return self;                                                                  \
}                                                                                 \
- (void)dealloc {                                                                 \
[[NSNotificationCenter defaultCenter]removeObserver:self];                    \
}                                                                                 \
- (void)didReceiveMemoryWarning {                                                 \
[super didReceiveMemoryWarning];                                              \
}                                                                                 \

#define WINDOW_OBJECT ((UIWindow*)[[[UIApplication sharedApplication].windows sortedArrayUsingComparator:^NSComparisonResult(UIWindow *win1, UIWindow *win2) {return win1.windowLevel-win2.windowLevel;}]lastObject])

/**
 get status of internet connection
 */
#define IS_INTERNET_AVAILABLE_WITH_USER_WARNING           [CommonFunctions getStatusForNetworkConnectionAndShowUnavailabilityMessage:YES]
#define IS_INTERNET_AVAILABLE                             [CommonFunctions getStatusForNetworkConnectionAndShowUnavailabilityMessage:NO]

#define SHOW_SERVER_NOT_RESPONDING_MESSAGE                [CommonFunctions showNotificationInViewController:self withTitle:nil withMessage:@"Server not responding .Please try again after some time." withType:TSMessageNotificationTypeError withDuration:MIN_DUR];
#define CONTINUE_IF_MAIN_THREAD if ([NSThread isMainThread] == NO) { NSAssert(FALSE, @"Not called from main thread"); }
#define FUNCTIONALLITY_PENDING_MESSAGE  [CommonFunctions showNotificationInViewController:APPDELEGATE.window.rootViewController withTitle:nil withMessage:@"We are still developing this functionallity ,please ignore it." withType:TSMessageNotificationTypeMessage withDuration:MIN_DUR];

#define MIN_DUR 2
//#define DEVICE_KEY           @"5534671-3673781"

#define TIME_DELAY_TO_OPTIMISE_SEARCH_HIT 1

#define PUSH_NOTIFICATION_DEVICE_TOKEN                    @"pushNotificationDeviceToken"

#define TIME_DELAY_IN_FREQUENTLY_SAVING_CHANGES 1

#define BlockWeakObject(o) __typeof(o) __weak
#define BlockWeakSelf BlockWeakObject(self)

#define NOTIFICATION_UPDATE_CONTENTS @"NOTIFICATION_UPDATE_CONTENTS"

/*
 Message titles AND texts for all alerts in the application
 */

#define MESSAGE_TITLE___TWITTER_SHARING_SUCCESSFULL @"Vemer"
#define MESSAGE_TEXT____TWITTER_SHARING_SUCCESSFULL @"Shared to Twitter."

#define MESSAGE_TITLE___FACEBOOK_SHARING_SUCCESSFULL @"Vemer"
#define MESSAGE_TEXT____FACEBOOK_SHARING_SUCCESSFULL @"Shared to Facebook."

#define MESSAGE_TITLE___GOOGLE_PLUS_SHARING_SUCCESSFULL @"Vemer"
#define MESSAGE_TEXT____GOOGLE_PLUS_SHARING_SUCCESSFULL @"Shared to Google Plus."

#endif
