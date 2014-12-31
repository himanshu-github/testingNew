//
//  UIView+Resize.h
//  iSkipLines
//
//  Created by Himanshu Gupta on 27/12/13.
//  Copyright (c) 2013 Himanshu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Resize)
- (void) setHeight: (CGFloat) height;
- (void) setWidth: (CGFloat) width;
- (void) setTop: (CGFloat) top;
- (void) setLeft: (CGFloat) left;
- (void) setCGSize:(CGSize)size;

@end
