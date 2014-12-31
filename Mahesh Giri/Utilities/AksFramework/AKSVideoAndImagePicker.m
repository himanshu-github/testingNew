//
//  Created by Alok on 07/03/14.
//  Copyright (c) 2014 Aryansbtloe. All rights reserved.
//

#import "AKSVideoAndImagePicker.h"
#import <QuartzCore/QuartzCore.h>
#import "NSObject+PE.h"
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"
#import "Debugging+Macros.h"
#import "AKSMethods.h"
#import "NSDate+Helper.h"
#import "NSObject+PE.h"
#import "UIDevice+Macros.h"
#import "AppDelegate.h"
#import "ApplicationSpecificConstants.h"
#import "UI+Macros.h"
#import "CommonFunctions.h"


static AKSVideoAndImagePicker *aKSVideoAndImagePicker_ = nil;

@implementation AKSVideoAndImagePicker

@synthesize operationFinishedBlockAKSVIPicker;
@synthesize imagePickerController;
@synthesize lastVideoPath;
@synthesize popover;

+ (AKSVideoAndImagePicker *)sharedAKSVideoAndImagePicker {
	TCSTART

	static dispatch_once_t pred;
	dispatch_once(&pred, ^{
	    if (aKSVideoAndImagePicker_ == nil) {
	        aKSVideoAndImagePicker_ = [[AKSVideoAndImagePicker alloc]init];
	        [AKSVideoAndImagePicker resetCachedMediaFiles];
		}
	});
	return aKSVideoAndImagePicker_;

	TCEND
}

+ (void)needImage:(BOOL)imageNeeded needVideo:(BOOL)videoNeeded FromLibrary:(BOOL)fromLibrary from:(UIViewController *)viewController didFinished:(AKSVideoAndImagePickerOperationFinishedBlock)operationFinishedBlock {
	TCSTART

	if ((fromLibrary == NO) && (IS_CAMERA_AVAILABLE == NO)) {
		[CommonFunctions showNotificationInViewController:viewController withTitle:nil withMessage:@"Camera not available" withType:TSMessageNotificationTypeError withDuration:MIN_DUR];
		return;
	}

	[AKSVideoAndImagePicker sharedAKSVideoAndImagePicker];

	aKSVideoAndImagePicker_.operationFinishedBlockAKSVIPicker = operationFinishedBlock;
	[[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/UnUpdatedItems/", [AKSMethods documentsDirectory]] withIntermediateDirectories:YES attributes:nil error:nil];

	aKSVideoAndImagePicker_.imagePickerController                      = [[UIImagePickerController alloc]init];
	aKSVideoAndImagePicker_.imagePickerController.videoQuality         = UIImagePickerControllerQualityTypeLow;
	aKSVideoAndImagePicker_.imagePickerController.videoMaximumDuration = 1800;
	aKSVideoAndImagePicker_.imagePickerController.delegate             = aKSVideoAndImagePicker_;

	if (fromLibrary) aKSVideoAndImagePicker_.imagePickerController.sourceType           = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	else aKSVideoAndImagePicker_.imagePickerController.sourceType           = UIImagePickerControllerSourceTypeCamera;

	NSMutableArray *mediaType = [[NSMutableArray alloc]init];
	if (videoNeeded) [mediaType addObject:@"public.movie"];
	if (imageNeeded) [mediaType addObject:@"public.image"];

	aKSVideoAndImagePicker_.imagePickerController.mediaTypes = mediaType;


	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		aKSVideoAndImagePicker_.popover = [[UIPopoverController alloc] initWithContentViewController:aKSVideoAndImagePicker_.imagePickerController];
		[aKSVideoAndImagePicker_.popover presentPopoverFromRect:[viewController.view bounds] inView:viewController.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	} else {
		[viewController presentViewController:aKSVideoAndImagePicker_.imagePickerController animated:YES completion:nil];
	}

	TCEND
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	TCSTART dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.05 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
	    [AKSVideoAndImagePicker didFinishPickingMediaWithInfo:info];
	});

	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		
	}else{
		[picker dismissViewControllerAnimated:YES completion:nil];
	}

	imagePickerController = nil;

	TCEND
}

+ (void)didFinishPickingMediaWithInfo:(NSDictionary *)info {
	TCSTART

	NSString *mediaType = [info objectForKey:@"UIImagePickerControllerMediaType"];

	if ([mediaType isEqualToString:@"public.movie"]) {
		[AKSVideoAndImagePicker showActivityIndicatorWithText:@"optimising video for network use"];
		[AKSVideoAndImagePicker saveVideoInDocumentsTemporarily:info];
		[AKSVideoAndImagePicker compressVideo];
	}
	else if ([mediaType isEqualToString:@"public.image"]) {
		[AKSVideoAndImagePicker showActivityIndicatorWithText:@"processing"];
		UIImage *image = info[UIImagePickerControllerOriginalImage];
		image = [AKSMethods compressThisImage:image];
		if (image) {
			NSString *pathToUnupdatedDirectory = [AKSVideoAndImagePicker getFilePathToSaveUnUpdatedImage];
			[UIImagePNGRepresentation(image) writeToFile:pathToUnupdatedDirectory atomically:YES];
			aKSVideoAndImagePicker_.operationFinishedBlockAKSVIPicker(pathToUnupdatedDirectory, @"image");
		}
		[AKSVideoAndImagePicker removeActivityIndicator];
	}

	TCEND
}

+ (void)compressVideo {
	aKSVideoAndImagePicker_.lastVideoPath = [AKSVideoAndImagePicker getFilePathToSaveUnUpdatedVideo];
	[AKSVideoAndImagePicker convertVideoToLowQuailtyWithInputURL:[NSURL fileURLWithPath:[AKSVideoAndImagePicker getTemporaryFilePathToSaveVideo]] outputURL:[NSURL fileURLWithPath:aKSVideoAndImagePicker_.lastVideoPath] handler: ^(AVAssetExportSession *exportSession) {
	    [aKSVideoAndImagePicker_ performSelectorOnMainThread:@selector(compressionSuccessFull) withObject:nil waitUntilDone:NO];
	}];
}

+ (void)convertVideoToLowQuailtyWithInputURL:(NSURL *)inputURL outputURL:(NSURL *)outputURL handler:(void (^)(AVAssetExportSession *))handler {
	[[NSFileManager defaultManager] removeItemAtURL:outputURL error:nil];
	AVURLAsset *asset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
	AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetLowQuality];
	exportSession.outputURL = outputURL;
	exportSession.outputFileType = AVFileTypeQuickTimeMovie;
	exportSession.shouldOptimizeForNetworkUse = YES;
	[exportSession exportAsynchronouslyWithCompletionHandler: ^(void) {
	    handler(exportSession);
	}];
}

- (void)compressionSuccessFull {
	[AKSVideoAndImagePicker removeActivityIndicator];
	aKSVideoAndImagePicker_.operationFinishedBlockAKSVIPicker(aKSVideoAndImagePicker_.lastVideoPath, @"video");
}

+ (void)saveVideoInDocumentsTemporarily:(NSDictionary *)info {
	[[[NSData alloc] initWithContentsOfURL:info[UIImagePickerControllerMediaURL]] writeToFile:[[NSMutableString alloc] initWithString:[AKSVideoAndImagePicker getTemporaryFilePathToSaveVideo]] atomically:YES];
}

+ (NSString *)getTemporaryFilePathToSaveVideo {
	return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"capturedvideo.MOV"];
}

+ (NSString *)getFilePathToSaveUnUpdatedVideo {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *directory = [paths objectAtIndex:0];
	for (int i = 0; TRUE; i++) {
		if (![[NSFileManager defaultManager]fileExistsAtPath:[NSString stringWithFormat:@"%@/UnUpdatedItems/Video%d.mp4", directory, i]]) return [NSString stringWithFormat:@"%@/UnUpdatedItems/Video%d.mp4", directory, i];
	}
}

+ (NSString *)getFilePathToSaveUnUpdatedImage {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *directory = [paths objectAtIndex:0];
	for (int i = 0; TRUE; i++) {
		if (![[NSFileManager defaultManager]fileExistsAtPath:[NSString stringWithFormat:@"%@/UnUpdatedItems/Image%d.jpg", directory, i]]) return [NSString stringWithFormat:@"%@/UnUpdatedItems/Image%d.jpg", directory, i];
	}
}

+ (void)showActivityIndicatorWithText:(NSString *)text {
	[AKSVideoAndImagePicker removeActivityIndicator];
	MBProgressHUD *hud   = [MBProgressHUD showHUDAddedTo:APPDELEGATE.window animated:YES];
	hud.labelText        = text;
	hud.detailsLabelText = NSLocalizedString(@"Please Wait...", @"");
}

+ (void)removeActivityIndicator {
	[MBProgressHUD hideHUDForView:APPDELEGATE.window animated:YES];
}

+ (void)resetCachedMediaFiles {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	if ([paths count] > 0) {
		NSError *error = nil;
		NSFileManager *fileManager = [NSFileManager defaultManager];
		NSString *directory = [paths objectAtIndex:0];
		directory = [directory stringByAppendingString:@"/UnUpdatedItems/"];
		for (NSString *file in[fileManager contentsOfDirectoryAtPath : directory error : &error]) {
			NSString *filePath = [directory stringByAppendingPathComponent:file];
			BOOL fileDeleted = [fileManager removeItemAtPath:filePath error:&error];
			if (fileDeleted != YES || error != nil) {
				[AKSMethods printErrorMessage:error showit:NO];
			}
		}
	}
}

@end
