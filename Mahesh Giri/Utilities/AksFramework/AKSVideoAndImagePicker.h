//
//  Created by Alok on 07/03/14.
//  Copyright (c) 2014 Aryansbtloe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^AKSVideoAndImagePickerOperationFinishedBlock)(NSString *filePath, NSString *fileType);

@interface AKSVideoAndImagePicker : NSObject {
	UIImagePickerController *imagePickerController;
	UIPopoverController *popover;
	NSString *lastVideoPath;
}

@property (nonatomic, retain) UIImagePickerController *imagePickerController;
@property (nonatomic, retain) UIPopoverController *popover;
@property (nonatomic, retain) NSString *lastVideoPath;
@property (nonatomic, copy) AKSVideoAndImagePickerOperationFinishedBlock operationFinishedBlockAKSVIPicker;

+ (void)needImage:(BOOL)imageNeeded needVideo:(BOOL)videoNeeded FromLibrary:(BOOL)fromLibrary from:(UIViewController *)viewController didFinished:(AKSVideoAndImagePickerOperationFinishedBlock)operationFinishedBlock;
+ (void)resetCachedMediaFiles;

@end
