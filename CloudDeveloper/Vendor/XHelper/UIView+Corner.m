//
//  UIView+Corner.m
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/2/18.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "UIView+Corner.h"
#import <objc/runtime.h>

@implementation UIView (Corner)

- (CGFloat)xks_cornerRadius{
    NSNumber *number = objc_getAssociatedObject(self,@selector(xks_cornerRadius));
    return [number floatValue];
}

- (void)setXks_cornerRadius:(CGFloat)xks_cornerRadius{
    objc_setAssociatedObject(self, @selector(xks_cornerRadius), @(xks_cornerRadius),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)xks_addCornerAtPostion:(UIRectCorner)postion{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:postion cornerRadii:CGSizeMake(self.xks_cornerRadius, self.xks_cornerRadius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         = self.bounds;
    maskLayer.path          = maskPath.CGPath;
    self.layer.mask         = maskLayer;
    [self.layer setMasksToBounds:YES];
}

@end
