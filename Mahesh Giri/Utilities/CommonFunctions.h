//
//  Last Updated by Alok on 19/02/14.
//  Copyright (c) 2014 Aryansbtloe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "TSMessage.h"


#define IsiPhone3p5Inch ([CommonFunctions getDeviceType] == IPHONE3P5INCH)
#define IsiPhone4Inch   ([CommonFunctions getDeviceType] == IPHONE4INCH)
#define IsiPad          ([CommonFunctions getDeviceType] == IPAD)
#define IsiPadMini      ([CommonFunctions getDeviceType] == IPAD_MINI)

#define IPHONE3P5INCH   10
#define IPHONE4INCH     11
#define IPAD            12
#define IPAD_MINI       13


/**

 CommonFunctions:-

 This singleton class implements some generic methods which are frequently needed in application.

 */
@interface CommonFunctions : NSObject
{
}

/**
 returns the document directory path
 */
+ (NSString *)documentsDirectory;

/**
 opens the email editor
 */
+ (void)openEmail:(NSString *)address;

/**
 dials the specified number
 */
+ (void)openPhone:(NSString *)number;

/**
 opens message editor
 */
+ (void)openSms:(NSString *)number;

/**
 opens default browser with url
 */
+ (void)openBrowser:(NSString *)url;

/**
 opens default map with address
 */
+ (void)openMap:(NSString *)address;

/**
 tells whether current device is having retina display support or not.
 */
+ (BOOL)isRetinaDisplay;


/**
 decides and returns the image name based on the current device.

 for ex:-

 [CommonFunctions getImageNameForName:@"Konstant"]

 this method will return

 @"Konstant" for iphone

 @"Konstant_iPad" for ipad

 */
+ (NSString *)getImageNameForName:(NSString *)name;



/**
 decides and returns the image name based on the current device.

 for ex:-

 [CommonFunctions getImageNameForName:@"Konstant"]

 this method will return

 @"Konstant" for iphone

 @"Konstant_iPad" for ipad

 */
+ (NSString *)getNibNameForName:(NSString *)name;

/**
 decides and returns the the current device type.

 #define IPHONE3P5INCH 10
 #define IPHONE4INCH 11
 #define IPAD 12
 #define IPAD_MINI 13
 */
+ (int)getDeviceType;


/**
 method to change the background image of navigation bar
 */
+ (void)setNavigationBarBackgroundWithImageName:(NSString *)imageName fromViewController:(UIViewController *)viewController;
+ (void)setNavigationBarBackgroundWithImage:(UIImage *)image fromViewController:(UIViewController *)viewController;

/**
 set navigation title
 */
+ (void)setNavigationTitle:(NSString *)title ForNavigationItem:(UINavigationItem *)navigationItem;

/**
 method to change the background image of navigation bar
 */
+ (void)setNavigationBarTitleImage:(NSString *)imageName WithViewController:(UIViewController *)caller;

/**
 common method to clear unnecessary memory used in the application.

 it should be called whenever application receives a memory warning
 */
+ (void)clearApplicationCaches;

/**
 common method to add navigation bar buttons
 */
+ (void)addLeftNavigationBarButton:(UIViewController *)caller withImageName:(NSString *)imageName WithNegativeSpacerValue:(int)value;
+ (void)addRightNavigationBarButton:(UIViewController *)caller withImageName:(NSString *)imageName WithNegativeSpacerValue:(int)value;
+ (void)addLeftNavigationBarButton:(UIViewController *)caller withImageName:(NSString *)imageName WithTitle:(NSString *)title WithNegativeSpacerValue:(int)value;
+ (void)addRightNavigationBarButton:(UIViewController *)caller withImageName:(NSString *)imageName WithTitle:(NSString *)title WithNegativeSpacerValue:(int)value;
+ (void)addTwoLeftNavigationBarButton:(UIViewController *)caller withImageName1:(NSString *)imageName1 withImageName2:(NSString *)imageName2 WithNegativeSpacerValue:(int)value;
+ (void)addTwoRightNavigationBarButton:(UIViewController *)caller withImageName1:(NSString *)imageName1 withImageName2:(NSString *)imageName2 WithNegativeSpacerValue:(int)value;


/**
 method to check network reachability status and show proper alert message if required
 */
+ (BOOL)getStatusForNetworkConnectionAndShowUnavailabilityMessage:(BOOL)showMessage;

/**
 common method to show mbprogresshud with custom text
 */
+ (void)showActivityIndicatorWithText:(NSString *)text;

/**
 remove the mbprogresshud
 */
+ (void)removeActivityIndicator;

/**
 common method to show toast messages to user
 */
+ (void)showNotificationInViewController:(UIViewController *)viewController
                               withTitle:(NSString *)title
                             withMessage:(NSString *)message
                                withType:(TSMessageNotificationType)type
                            withDuration:(NSTimeInterval)duration;
+ (void)showMessageWithTitle:(NSString *)title
                 withMessage:(NSString *)message;
+ (void)showToastMessageWithMessage:(NSString *)message;
+ (void) showAlertViewWithTag:(NSInteger)tag title:(NSString*)title message:(NSString*)msg delegate:(id)delegate
            cancelButtonTitle:(NSString*)CbtnTitle otherButtonTitles:(NSString*)otherBtnTitles;

+ (BOOL)validateEmailWithString:(NSString *)email WithIdentifier:(NSString *)identifier;
+ (BOOL)validateNameWithString:(NSString *)name WithIdentifier:(NSString *)identifier;
+ (BOOL)validatePhoneNumberWithString:(NSString *)number WithIdentifier:(NSString *)identifier;
+ (BOOL)validatePinCodeWithString:(NSString *)number WithIdentifier:(NSString *)identifier;
+ (BOOL)validateNumberWithString:(NSString *)number WithIdentifier:(NSString *)identifier;
+ (BOOL)validatePasswordWithString:(NSString *)password WithIdentifier:(NSString *)identifier;
+ (BOOL)validateDOBWithString:(NSString *)DOB WithIdentifier:(NSString *)identifier;
+ (BOOL)validateComposeMessageWithString:(NSString *)name WithIdentifier:(NSString *)identifier;
@end
