//
//  UIView+Frame.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/12.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  @author _Finder丶Tiwk, 16-01-21 00:01:04
 *
 *  @brief 爱客仕UIView扩展类，为了方便取视图的各种点坐标
 *  @since v0.1.0
 */
@interface UIView (Frame)

/*! view原点*/
@property (nonatomic,assign) CGPoint origin;

/*! view尺寸*/
@property (nonatomic,assign) CGSize  size;

/*! view宽*/
@property (nonatomic,assign) CGFloat width;

/*! view高*/
@property (nonatomic,assign) CGFloat height;

/*! view左上角x坐标*/
@property (nonatomic,assign) CGFloat left;

/*! view左上角y坐标*/
@property (nonatomic,assign) CGFloat top;

/*! view右下角x坐标*/
@property (nonatomic,assign) CGFloat right;

/*! view右下角y坐标*/
@property (nonatomic,assign) CGFloat bottom;

@end
