//
//  UIView+Resize.m
//  iSkipLines
//
//  Created by Himanshu Gupta on 27/12/13.
//  Copyright (c) 2013 Himanshu. All rights reserved.
//

#import "UIView+Resize.h"

@implementation UIView (Resize)
- (void) setHeight: (CGFloat) height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void) setWidth: (CGFloat) width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void) setTop: (CGFloat) top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}
- (void) setLeft: (CGFloat) left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}
- (void) setCGSize:(CGSize)size{
    
    
    [self setWidth:size.width];
    [self setHeight:size.height];


}

@end
