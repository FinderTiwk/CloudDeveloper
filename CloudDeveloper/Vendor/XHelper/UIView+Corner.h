//
//  UIView+Corner.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/2/18.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @author _Finder丶Tiwk, 16-02-18 13:02:04
 *
 *  @brief 这个分类用来为各种UIView及其子类添加圆角,圆角的位置可以自由设置
 *  @since v0.1.0
 */
@interface UIView (Corner)
/*! 圆角半径 默认为 6*/
@property (nonatomic,assign) CGFloat xks_cornerRadius;

/**
 *  @author _Finder丶Tiwk, 16-02-18 11:02:48
 *
 *  @brief 为视图添加圆角
 *  @param postion 要添加的圆角位置，可通过位或运算自定义圆角
 *  @since v0.1.0
 */
- (void)xks_addCornerAtPostion:(UIRectCorner)postion;

@end
