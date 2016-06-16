//
//  ViewController.m
//  PaySDKDemo
//
//  Created by _Finder丶Tiwk on 15/7/22.
//  Copyright (c) 2015年 _Finder丶Tiwk. All rights reserved.
//

#import "UIButton+MBIBnspectable.h"

@implementation UIButton (MBIBnspectable)
#pragma mark - hexRgbColor
- (void)setTitleHexColor:(NSString *)titleHexColor{
    NSScanner *scanner = [NSScanner scannerWithString:titleHexColor];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return;
    [self setTitleColor:[self colorWithRGBHex:hexNum] forState:UIControlStateNormal];
}

- (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}


- (NSString *)titleHexColor{
    return @"0xffffff";
}
@end
