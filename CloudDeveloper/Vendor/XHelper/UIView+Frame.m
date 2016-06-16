//
//  UIView+Frame.m
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/12.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)origin{
    return  self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame   = frame;
}

////////////////////////////////////////////////////////////////////////////////////

- (CGSize)size{
    return self.frame.size;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size   = size;
    self.frame   = frame;
}

////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width{
    return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)width{
    CGRect frame     = self.frame;
    frame.size.width = width;
    self.frame       = frame;
}

////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height{
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)height{
    CGRect frame      = self.frame;
    frame.size.height = height;
    self.frame        = frame;
}

////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)left{
    return CGRectGetMinX(self.frame);
}

- (void)setLeft:(CGFloat)left{
    CGRect frame   = self.frame;
    frame.origin.x = left;
    self.frame     = frame;
}
////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top{
    return CGRectGetMinY(self.frame);
}

- (void)setTop:(CGFloat)top{
    CGRect frame   = self.frame;
    frame.origin.y = top;
    self.frame     = frame;
}

////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right{
    return CGRectGetMaxX(self.frame);
}

- (void)setRight:(CGFloat)right {
    CGRect frame   = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame     = frame;
}
////////////////////////////////////////////////////////////////////////////////////
-(CGFloat)bottom{
    return CGRectGetMaxY(self.frame);
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame   = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame     = frame;
}

@end
