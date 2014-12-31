//
//  Last Updated by Alok on 19/02/14.
//  Copyright (c) 2014 Aryansbtloe. All rights reserved.
//

#import "CommonFunctions.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "TSMessage.h"
#import "NSObject+PE.h"
#import "SDImageCache.h"
#import "AKSMethods.h"
#import "FeedItemServices.h"
#import "UIDevice+Macros.h"
#import "TSBlurView.h"
#import "ApplicationSpecificConstants.h"
#import "Toast+UIView.h"

@implementation CommonFunctions


+ (NSString *)documentsDirectory {
	NSArray *paths =
	NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
										NSUserDomainMask,
										YES);
	return [paths objectAtIndex:0];
}

+ (void)openEmail:(NSString *)address {
	NSString *url = [NSString stringWithFormat:@"mailto://%@", address];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+ (void)openPhone:(NSString *)number {
	NSString *url = [NSString stringWithFormat:@"tel://%@", number];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+ (void)openSms:(NSString *)number {
	NSString *url = [NSString stringWithFormat:@"sms://%@", number];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+ (void)openBrowser:(NSString *)url {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+ (void)openMap:(NSString *)address {
	NSString *addressText = [address stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	NSString *url = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", addressText];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+ (BOOL)isRetinaDisplay {
	if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
	    ([UIScreen mainScreen].scale == 2.0)) {
		return YES;
	}
	else {
		return NO;
	}
}

+ (int)getDeviceType {
#define IS_IPAD     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)

	static int deviceType = 0;
	if (deviceType == 0) {
		if (IS_IPAD) deviceType = IPAD;
		else if (IS_IPHONE && IS_IPHONE_5) deviceType = IPHONE4INCH;
		else if (IS_IPHONE) deviceType = IPHONE3P5INCH;
	}
	return deviceType;
}

+ (NSString *)getImageNameForName:(NSString *)name {
	return [NSString stringWithFormat:IS_IPAD ? @"%@_iPad":@"%@", name];
}

+ (NSString *)getNibNameForName:(NSString *)name {
	if (IsiPhone4Inch) {
		NSString *possibleNibName = [NSString stringWithFormat:@"%@_iPhone4Inch", name];
		if ([[NSBundle mainBundle] pathForResource:possibleNibName ofType:@"nib"] != nil) {
			return possibleNibName;
		}
	}

	return [NSString stringWithFormat:IS_IPAD ? @"%@_iPad":@"%@", name];
}

+ (void)setNavigationTitle:(NSString *)title ForNavigationItem:(UINavigationItem *)navigationItem {
	float width = 320.0f;

	if (navigationItem.leftBarButtonItem.customView && navigationItem.rightBarButtonItem.customView) {
		width = 320 - (navigationItem.leftBarButtonItem.customView.frame.size.width + navigationItem.rightBarButtonItem.customView.frame.size.width + 20);
	}
	else if (navigationItem.leftBarButtonItem.customView && !navigationItem.rightBarButtonItem.customView) {
		width = 320 - (navigationItem.leftBarButtonItem.customView.frame.size.width * 2);
	}
	else if (!navigationItem.leftBarButtonItem.customView && !navigationItem.rightBarButtonItem.customView) {
		width = 320 - (2 * navigationItem.rightBarButtonItem.customView.frame.size.width);
	}

	// find the text width; so that btn width can be calculate
	CGSize textSize = [title   sizeWithFont:[UIFont boldSystemFontOfSize:15.0]
	                      constrainedToSize:CGSizeMake(320.0f, 20.0f)
	                          lineBreakMode:NSLineBreakByWordWrapping];

	if (textSize.width < width)
		width = textSize.width;

	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, 44.0f)];

	UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 6.0f, width, 32.0f)];

	[titleLbl setFont:[UIFont boldSystemFontOfSize:15.0]];
	[titleLbl setTextColor:[UIColor colorWithRed:(113 / 255.0) green:(113 / 255.0) blue:(113 / 255.0) alpha:1]];

	[titleLbl setBackgroundColor:[UIColor clearColor]];
	[titleLbl setTextAlignment:NSTextAlignmentCenter];

	[titleLbl setTextColor:[UIColor whiteColor]];
	[titleLbl setShadowColor:[UIColor lightGrayColor]];
	[titleLbl setShadowOffset:CGSizeMake(0.0f, 1.0f)];

	[titleLbl setText:title];

	[view addSubview:titleLbl];

	[navigationItem setTitleView:view];
}

#pragma mark - common method for setting navigation bar background image

+ (void)setNavigationBarBackgroundWithImageName:(NSString *)imageName fromViewController:(UIViewController *)viewController {
	if ([self isNotNull:imageName] && [viewController.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
		[viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[CommonFunctions getImageNameForName:imageName]]
		                                                        forBarMetrics:UIBarMetricsDefault];
	}
}

+ (void)setNavigationBarBackgroundWithImage:(UIImage *)image fromViewController:(UIViewController *)viewController {
	if ([self isNotNull:image] && [viewController.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
		[viewController.navigationController.navigationBar setBackgroundImage:image
		                                                        forBarMetrics:UIBarMetricsDefault];
	}
}

#pragma mark - common method for setting navigation bar  title image view

+ (void)setNavigationBarTitleImage:(NSString *)imageName WithViewController:(UIViewController *)caller {
	UIImage *imageToUse =   [UIImage imageNamed:[CommonFunctions getImageNameForName:imageName]];
	UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, imageToUse.size.width, imageToUse.size.height)];
	[titleView setImage:imageToUse];
	[caller.navigationItem setTitleView:titleView];
}

#pragma mark - Common method to add navigation bar buttons

/**
 common method to add navigation bar buttons
 */
+ (void)addLeftNavigationBarButton:(UIViewController *)caller withImageName:(NSString *)imageName WithNegativeSpacerValue:(int)value {
	UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[leftBarButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
	[leftBarButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_hover", imageName]] forState:UIControlStateHighlighted];
	[leftBarButton setFrame:CGRectMake(0.0f, 0.0f, leftBarButton.imageView.image.size.width, NAVIGATION_BAR_HEIGHT)];

	if ([caller respondsToSelector:@selector(onClickOfLeftNavigationBarButton:)]) [leftBarButton addTarget:caller action:@selector(onClickOfLeftNavigationBarButton:) forControlEvents:UIControlEventTouchUpInside];
	else {
		//NSLog(@"\n\n%@ class forgets to implement onClickOfLeftNavigationBarButton method\n", [AKSMethods getClassNameForObject:caller]);
	}

	UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
	                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if (SYSTEM_VERSION_LESS_THAN(@"7.0"))negativeSpacer.width=value+16;else negativeSpacer.width = value;
	caller.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:leftBarButton], nil];
}

+ (void)addRightNavigationBarButton:(UIViewController *)caller withImageName:(NSString *)imageName WithNegativeSpacerValue:(int)value {
	UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[rightBarButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
	[rightBarButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_hover", imageName]] forState:UIControlStateHighlighted];
	[rightBarButton setFrame:CGRectMake(0.0f, 0.0f, rightBarButton.imageView.image.size.width, NAVIGATION_BAR_HEIGHT)];

	if ([caller respondsToSelector:@selector(onClickOfRightNavigationBarButton:)]) [rightBarButton addTarget:caller action:@selector(onClickOfRightNavigationBarButton:) forControlEvents:UIControlEventTouchUpInside];
	else {
		//NSLog(@"\n\n%@ class forgets to implement onClickOfRightNavigationBarButton method\n", [AKSMethods getClassNameForObject:caller]);
	}

	UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
	                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if (SYSTEM_VERSION_LESS_THAN(@"7.0"))negativeSpacer.width=value;else negativeSpacer.width = value;
	caller.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:rightBarButton], nil];
}

+ (void)addTwoLeftNavigationBarButton:(UIViewController *)caller withImageName1:(NSString *)imageName1 withImageName2:(NSString *)imageName2 WithNegativeSpacerValue:(int)value {
	UIButton *leftBarButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
	[leftBarButton1 setImage:[UIImage imageNamed:imageName1] forState:UIControlStateNormal];
	[leftBarButton1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_hover", imageName1]] forState:UIControlStateHighlighted];
	[leftBarButton1 setFrame:CGRectMake(0.0f, 0.0f, leftBarButton1.imageView.image.size.width, NAVIGATION_BAR_HEIGHT)];

	if ([caller respondsToSelector:@selector(onClickOfLeftNavigationBarButton1:)]) [leftBarButton1 addTarget:caller action:@selector(onClickOfLeftNavigationBarButton1:) forControlEvents:UIControlEventTouchUpInside];
	else {
		//NSLog(@"\n\n%@ class forgets to implement onClickOfLeftNavigationBarButton1 method\n", [AKSMethods getClassNameForObject:caller]);
	}


	UIButton *leftBarButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
	[leftBarButton2 setImage:[UIImage imageNamed:imageName2] forState:UIControlStateNormal];
	[leftBarButton2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_hover", imageName2]] forState:UIControlStateHighlighted];
	[leftBarButton2 setFrame:CGRectMake(0.0f, 0.0f, leftBarButton2.imageView.image.size.width, NAVIGATION_BAR_HEIGHT)];

	if ([caller respondsToSelector:@selector(onClickOfLeftNavigationBarButton2:)]) [leftBarButton2 addTarget:caller action:@selector(onClickOfLeftNavigationBarButton2:) forControlEvents:UIControlEventTouchUpInside];
	else {
		//NSLog(@"\n\n%@ class forgets to implement onClickOfLeftNavigationBarButton2 method\n", [AKSMethods getClassNameForObject:caller]);
	}


	UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
	                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if (SYSTEM_VERSION_LESS_THAN(@"7.0"))negativeSpacer.width=value+16;else negativeSpacer.width = value;
	caller.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:
	                                            negativeSpacer,
	                                            [[UIBarButtonItem alloc] initWithCustomView:leftBarButton1],
	                                            [[UIBarButtonItem alloc] initWithCustomView:leftBarButton2],
	                                            nil];
}

+ (void)addTwoRightNavigationBarButton:(UIViewController *)caller withImageName1:(NSString *)imageName1 withImageName2:(NSString *)imageName2 WithNegativeSpacerValue:(int)value {
	UIButton *rightBarButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
	[rightBarButton1 setImage:[UIImage imageNamed:imageName1] forState:UIControlStateNormal];
	[rightBarButton1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_hover", imageName1]] forState:UIControlStateHighlighted];
	[rightBarButton1 setFrame:CGRectMake(0.0f, 0.0f, rightBarButton1.imageView.image.size.width, NAVIGATION_BAR_HEIGHT)];

	if ([caller respondsToSelector:@selector(onClickOfRightNavigationBarButton1:)]) [rightBarButton1 addTarget:caller action:@selector(onClickOfRightNavigationBarButton1:) forControlEvents:UIControlEventTouchUpInside];
	else {
		//NSLog(@"\n\n%@ class forgets to implement onClickOfRightNavigationBarButton1 method\n", [AKSMethods getClassNameForObject:caller]);
	}


	UIButton *rightBarButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
	[rightBarButton2 setImage:[UIImage imageNamed:imageName2] forState:UIControlStateNormal];
	[rightBarButton2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_hover", imageName2]] forState:UIControlStateHighlighted];
	[rightBarButton2 setFrame:CGRectMake(0.0f, 0.0f, rightBarButton2.imageView.image.size.width, NAVIGATION_BAR_HEIGHT)];

	if ([caller respondsToSelector:@selector(onClickOfRightNavigationBarButton2:)]) [rightBarButton2 addTarget:caller action:@selector(onClickOfRightNavigationBarButton2:) forControlEvents:UIControlEventTouchUpInside];
	else {
		//NSLog(@"\n\n%@ class forgets to implement onClickOfRightNavigationBarButton2 method\n", [AKSMethods getClassNameForObject:caller]);
	}


	UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
	                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if (SYSTEM_VERSION_LESS_THAN(@"7.0"))negativeSpacer.width=value;else negativeSpacer.width = value;
	caller.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:
	                                             negativeSpacer,
	                                             [[UIBarButtonItem alloc] initWithCustomView:rightBarButton2],
	                                             [[UIBarButtonItem alloc] initWithCustomView:rightBarButton1],
	                                             nil];
}

/**
 common method to add navigation bar buttons
 */
+ (void)addLeftNavigationBarButton:(UIViewController *)caller withImageName:(NSString *)imageName WithTitle:(NSString *)title WithNegativeSpacerValue:(int)value {
	UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[leftBarButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
	[leftBarButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_hover", imageName]] forState:UIControlStateHighlighted];
	[leftBarButton setFrame:CGRectMake(0.0f, (NAVIGATION_BAR_HEIGHT - leftBarButton.currentBackgroundImage.size.height) / 2, leftBarButton.currentBackgroundImage.size.width, leftBarButton.currentBackgroundImage.size.height)];
	[leftBarButton setTitle:title forState:UIControlStateNormal];
	[leftBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

	if ([caller respondsToSelector:@selector(onClickOfLeftNavigationBarButton:)]) [leftBarButton addTarget:caller action:@selector(onClickOfLeftNavigationBarButton:) forControlEvents:UIControlEventTouchUpInside];
	else {
		//NSLog(@"\n\n%@ class forgets to implement onClickOfLeftNavigationBarButton method\n", [AKSMethods getClassNameForObject:caller]);
	}

	UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
	                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if (SYSTEM_VERSION_LESS_THAN(@"7.0"))negativeSpacer.width=value+16;else negativeSpacer.width = value;
	caller.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:leftBarButton], nil];
}

+ (void)addRightNavigationBarButton:(UIViewController *)caller withImageName:(NSString *)imageName WithTitle:(NSString *)title WithNegativeSpacerValue:(int)value {
	UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[rightBarButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
	[rightBarButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_hover", imageName]] forState:UIControlStateHighlighted];
	[rightBarButton setFrame:CGRectMake(0.0f, (NAVIGATION_BAR_HEIGHT - rightBarButton.currentBackgroundImage.size.height) / 2, rightBarButton.currentBackgroundImage.size.width, rightBarButton.currentBackgroundImage.size.height)];
	[rightBarButton setTitle:title forState:UIControlStateNormal];
	[rightBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

	if ([caller respondsToSelector:@selector(onClickOfRightNavigationBarButton:)]) [rightBarButton addTarget:caller action:@selector(onClickOfRightNavigationBarButton:) forControlEvents:UIControlEventTouchUpInside];
	else {
		//NSLog(@"\n\n%@ class forgets to implement onClickOfRightNavigationBarButton method\n", [AKSMethods getClassNameForObject:caller]);
	}

	UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
	                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if (SYSTEM_VERSION_LESS_THAN(@"7.0"))negativeSpacer.width=value;else negativeSpacer.width = value;
	caller.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,[[UIBarButtonItem alloc] initWithCustomView:rightBarButton], nil];
}

+ (void)clearApplicationCaches {
	[[NSURLCache sharedURLCache] removeAllCachedResponses];
	[[SDImageCache sharedImageCache] clearMemory];
	[[SDImageCache sharedImageCache] clearDisk];
	[[SDImageCache sharedImageCache] cleanDisk];
	[AKSMethods syncroniseNSUserDefaults];
}

#pragma mark - common method to show toast messages

+ (void)showNotificationInViewController:(UIViewController *)viewController
                               withTitle:(NSString *)title
                             withMessage:(NSString *)message
                                withType:(TSMessageNotificationType)type
                            withDuration:(NSTimeInterval)duration {
    [TSMessage showNotificationInViewController:viewController title:title subtitle:message image:nil type:type duration:duration callback:nil buttonTitle:nil buttonCallback:nil atPosition:TSMessageNotificationPositionTop canBeDismissedByUser:NO];
}

#pragma mark - common method to show toast messages

+ (void)showMessageWithTitle:(NSString *)title
                 withMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc]
	                      initWithTitle:title
						  message:message
						  delegate:nil
						  cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
}

+ (void)showToastMessageWithMessage:(NSString *)message {
	[APPDELEGATE.window.rootViewController.view makeToast:message
				duration:3.0
				position:@"top"
				   title:Nil];
}

+ (void) showAlertViewWithTag:(NSInteger)tag title:(NSString*)title message:(NSString*)msg delegate:(id)delegate
            cancelButtonTitle:(NSString*)CbtnTitle otherButtonTitles:(NSString*)otherBtnTitles
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate
										  cancelButtonTitle:CbtnTitle otherButtonTitles:otherBtnTitles, nil];
    alert.tag = tag;
	[alert show];
}
#pragma mark - common method for showing MBProgressHUD Activity Indicator

/*!
 @function	showActivityIndicatorWithText
 @abstract	shows the MBProgressHUD with custom text for information to user.
 @discussion
 MBProgressHUD will be added to window . hence complete ui will be blocked from any user interaction.
 @param	text
 the text which will be shown while showing progress
 */
//+(void)showSKActivityViewer{
//
//
//
//
//    if(activityView1 == nil)
//    {
//        
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//        {
//            activityView1 = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 768, 1024)];
//            
//            activityView1.backgroundColor = [UIColor blackColor];
//            activityView1.alpha = 0.7;
//            
//            
//            if (!_activityIndicatorView3) {
//                _activityIndicatorView3 = [[SKActivityIndicatorView alloc] initWithActivityIndicatorStyle:SKActivityIndicatorViewStyleLarge];
//                _activityIndicatorView3.hidesWhenStopped = NO;
//                self.activityIndicatorView3.frame = CGRectMake(334.0f, 450, 100.0f, 100.0f);
//            }
//            
//            [activityView1 addSubview:self.activityIndicatorView3];
//            
//            UILabel* lblLoading=[[UILabel alloc] initWithFrame:CGRectMake(324,555,120,60)];
//            lblLoading.numberOfLines=0;
//            lblLoading.text=message;
//            lblLoading.backgroundColor=[UIColor clearColor];
//            lblLoading.textAlignment=NSTextAlignmentCenter;
//            [lblLoading setContentMode:UIViewContentModeBottom];
//            lblLoading.textColor=[UIColor whiteColor];
//            lblLoading.font= [UIFont fontWithName:@"Roboto-Condensed" size:20];
//            
//            [activityView1 addSubview:lblLoading];
//            
//        }
//        else
//        {
//            activityView1 = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 320, 480)];
//            
//            if(IS_WIDESCREEN)
//                activityView1.frame=CGRectMake(0, 0, 320, 568);
//            
//            activityView1.backgroundColor = [UIColor blackColor];
//            activityView1.alpha = 0.7;
//            
//            
//            if (!_activityIndicatorView3) {
//                _activityIndicatorView3 = [[SKActivityIndicatorView alloc] initWithActivityIndicatorStyle:SKActivityIndicatorViewStyleLarge];
//                _activityIndicatorView3.hidesWhenStopped = NO;
//                
//                if(IS_WIDESCREEN)
//                    self.activityIndicatorView3.frame = CGRectMake(110.0f, 200, 103.0f, 103.0f);
//                else
//                    self.activityIndicatorView3.frame = CGRectMake(110.0f, 160, 103.0f, 103.0f);
//                
//            }
//            
//            [activityView1 addSubview:self.activityIndicatorView3];
//            
//            UILabel* lblLoading=[[UILabel alloc] initWithFrame:CGRectMake(90,305,140,60)];
//            if(!IS_WIDESCREEN)
//            {
//                lblLoading.frame=CGRectMake(90,265,140,60);
//                
//            }
//            lblLoading.numberOfLines=0;
//            lblLoading.backgroundColor=[UIColor clearColor];
//            lblLoading.textAlignment=NSTextAlignmentCenter;
//            [lblLoading setContentMode:UIViewContentModeBottom];
//            lblLoading.textColor=[UIColor whiteColor];
//            lblLoading.font= [UIFont fontWithName:@"Roboto-Condensed" size:15];
//            
//            [activityView1 addSubview:lblLoading];
//            
//        }
//        
//        
//        
//    }
//    [[[activityView1 subviews] objectAtIndex:1] setText:message];
//    
//    [self.window addSubview:activityView1];
//    [self.activityIndicatorView3 startAnimating];
//
//}
+ (void)showActivityIndicatorWithText:(NSString *)text {
    
	[self removeActivityIndicator];
	MBProgressHUD *hud   = [MBProgressHUD showHUDAddedTo:APPDELEGATE.window animated:YES];
	hud.labelText        = text;
	hud.detailsLabelText = NSLocalizedString(@"Please Wait...", @"");
}

/*!
 @function	removeActivityIndicator
 @abstract	removes the MBProgressHUD (if any) from window.
 */

+ (void)removeActivityIndicator {
	[MBProgressHUD hideHUDForView:APPDELEGATE.window animated:YES];
}


#pragma mark - common method for Internet reachability checking

/*!
 @function	getStatusForNetworkConnectionAndShowUnavailabilityMessage
 @abstract	get internet reachability status and optionally can show network unavailability message.
 @param	showMessage
 to decide whether to show network unreachability message.
 */

+ (BOOL)getStatusForNetworkConnectionAndShowUnavailabilityMessage:(BOOL)showMessage {
    //checking now with google.co.in else check with the server - [[NSURL URLWithString:BASE_URL]host]
	if (([[Reachability reachabilityWithHostname:[[NSURL URLWithString:BASE_URL]host]] currentReachabilityStatus] == NotReachable)) {
		if (showMessage == NO) return NO;

		UIViewController *viewController = nil;

		if ([APPDELEGATE.window.rootViewController isKindOfClass:[UINavigationController class]]) viewController = ((UINavigationController *)(APPDELEGATE.window.rootViewController)).topViewController;
		else if ([APPDELEGATE.window.rootViewController isKindOfClass:[UIViewController class]]) viewController = APPDELEGATE.window.rootViewController;
		else viewController = APPDELEGATE.window.rootViewController;

		[self showNotificationInViewController:viewController withTitle:MESSAGE_TITLE___FOR_NETWORK_NOT_REACHABILITY withMessage:MESSAGE_TEXT___FOR_NETWORK_NOT_REACHABILITY withType:TSMessageNotificationTypeError withDuration:MIN_DUR];
		return NO;
	}
	return YES;
}

+ (BOOL)isSuccess:(NSMutableDictionary *)response {
    
    if ([response isKindOfClass:[NSDictionary class]]) {
		if ([[[response objectForKey:@"CODE"] uppercaseString]isEqualToString:@"200"]) {
			return YES;
		}
	}

    
    
//	if ([response isKindOfClass:[NSDictionary class]]) {
//		if ([[[response objectForKey:@"replyCode"] uppercaseString]isEqualToString:@"SUCCESS"]) {
//			return YES;
//		}
//	}
	return NO;
}

+ (BOOL)validateEmailWithString:(NSString *)email WithIdentifier:(NSString *)identifier {
//	if ((email == nil) || (email.length == 0)) {
//		[CommonFunctions showToastMessageWithMessage:identifier];
//		return FALSE;
//	}
//	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//	if (![emailTest evaluateWithObject:email]) {
//		[CommonFunctions showToastMessageWithMessage:identifier];
//		return FALSE;
//	}
    
    if([email rangeOfString:@"@"].location==NSNotFound || [email rangeOfString:@"."].location==NSNotFound)
    {
        [CommonFunctions showToastMessageWithMessage:identifier];
        return NO;
    }
    
    NSString *accountName=[email substringToIndex: [email rangeOfString:@"@"].location];
    email=[email substringFromIndex:[email rangeOfString:@"@"].location+1];
    if([email rangeOfString:@"."].location==NSNotFound)
    {
        [CommonFunctions showToastMessageWithMessage:identifier];
        return NO;
    }
    NSString *domainName=[email substringToIndex:[email rangeOfString:@"."].location];
    NSString *subDomain=[email substringFromIndex:[email rangeOfString:@"."].location+1];
    NSString *unWantedInUName = @" ~!@#$^&*()={}[]|;':\"<>,?/`";
    NSString *unWantedInDomain = @" ~!@#$%^&*()={}[]|;':\"<>,+?/`";
    NSString *unWantedInSub = @" `~!@#$%^&*()={}[]:\";'<>,?/1234567890";
    if(!(subDomain.length>=2 && subDomain.length<=6))
    {
        [CommonFunctions showToastMessageWithMessage:identifier];
        return NO;
    }
    if([accountName isEqualToString:@""] || [accountName rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:unWantedInUName]].location!=NSNotFound || [domainName isEqualToString:@""] || [domainName rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:unWantedInDomain]].location!=NSNotFound || [subDomain isEqualToString:@""] || [subDomain rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:unWantedInSub]].location!=NSNotFound)
    {
        [CommonFunctions showToastMessageWithMessage:identifier];
        return NO;
    }
    return YES;
    
}


+ (BOOL)validateNameWithString:(NSString *)name WithIdentifier:(NSString *)identifier {
    NSString *name1 = [name stringByRemovingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if ((name1 == nil) || (name1.length == 0) || (name1.length>25)) {
		[CommonFunctions showToastMessageWithMessage:identifier];
		return FALSE;
	}
	NSString *nameRegex = @"[a-zA-Z0-9_.@ ]+$";
	NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
	if (![nameTest evaluateWithObject:name1]) {
		[CommonFunctions showToastMessageWithMessage:identifier];
		return FALSE;
	}
	else return TRUE;
}
+ (BOOL)validateComposeMessageWithString:(NSString *)name WithIdentifier:(NSString *)identifier {
    NSString *name1 = [name stringByRemovingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *name2 = [name1 stringByRemovingCharactersInSet:[NSCharacterSet newlineCharacterSet]];

	if ((name2 == nil) || (name2.length == 0)) {
		[CommonFunctions showToastMessageWithMessage:identifier];
		return FALSE;
	}
	
	else return TRUE;
}


+ (BOOL)validatePhoneNumberWithString:(NSString *)number WithIdentifier:(NSString *)identifier {
    NSString *number1 = [number stringByRemovingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if ((number1 == nil) || (number1.length == 0) || (number1.length < 7)) {
		[CommonFunctions showToastMessageWithMessage:identifier];
		return FALSE;
	}

	if (number1.length > 13) {
		[CommonFunctions showToastMessageWithMessage:identifier];
		return FALSE;
	}

	NSString *numberRegex = @"[0-9]+$";
	NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];

	if (![numberTest evaluateWithObject:number1]) {
		[CommonFunctions showToastMessageWithMessage:identifier];
		return FALSE;
	}
	else return TRUE;
}

+ (BOOL)validatePinCodeWithString:(NSString *)number WithIdentifier:(NSString *)identifier {
	if ((number == nil) || (number.length == 0)) {
		[CommonFunctions showToastMessageWithMessage:identifier];
		return FALSE;
	}

	if (number.length != 6) {
		[CommonFunctions showToastMessageWithMessage:identifier];
		return FALSE;
	}

	NSString *numberRegex = @"[0-9]+$";
	NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];

	if (![numberTest evaluateWithObject:number]) {
		[CommonFunctions showToastMessageWithMessage:identifier];
		return FALSE;
	}
	else
		return TRUE;
}

+ (BOOL)validateNumberWithString:(NSString *)number WithIdentifier:(NSString *)identifier {
	if ((number == nil) || (number.length == 0)) {
		[CommonFunctions showToastMessageWithMessage:identifier];
		return FALSE;
	}

	NSString *numberRegex = @"[0-9]+$";
	NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];

	if (![numberTest evaluateWithObject:number]) {
		[CommonFunctions showToastMessageWithMessage:identifier];
		return FALSE;
	}
	else
		return TRUE;
}

+(BOOL)validatePasswordWithString:(NSString *)password WithIdentifier:(NSString *)identifier
{
    
    if ((password == nil) || (password.length == 0) || (password.length<8)||(password.length>25)) {
		[CommonFunctions showToastMessageWithMessage:identifier];
		return FALSE;
	}
//	NSString *passwordRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//	NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
//	if (![passwordTest evaluateWithObject:password]) {
//		[CommonFunctions showToastMessageWithMessage:[NSMutableString stringWithFormat:@"Please enter valid %@", identifier]];
//		return FALSE;
//	}
	else return TRUE;
}

+(BOOL)validateDOBWithString:(NSString *)DOB WithIdentifier:(NSString *)identifier
{
    NSDateFormatter *dobFormatter = [[NSDateFormatter alloc] init];
    [dobFormatter setDateFormat:@"dd-MMMM-yyyy"];
    NSDate *date = [dobFormatter dateFromString:DOB];
    if(!date)
    {
        [CommonFunctions showToastMessageWithMessage:identifier];
        return NO;
    }
    else
        return YES;
}

@end
