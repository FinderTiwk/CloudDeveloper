//
//  ViewController.m
//  PaySDKDemo
//
//  Created by _Finder丶Tiwk on 15/7/22.
//  Copyright (c) 2015年 _Finder丶Tiwk. All rights reserved.
//
#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface UIView (MBIBnspectable)

@property (assign,nonatomic) IBInspectable NSInteger cornerRadius;
@property (assign,nonatomic) IBInspectable NSInteger borderWidth;
@property (assign,nonatomic) IBInspectable BOOL      masksToBounds;
// set border hex color
@property (strong,nonatomic) IBInspectable NSString  *borderHexRgb;
@property (strong,nonatomic) IBInspectable UIColor   *borderColor;
// set background hex color
@property (assign,nonatomic) IBInspectable NSString  *hexRgbColor;
@property (assign,nonatomic) IBInspectable BOOL      onePx;

@end
