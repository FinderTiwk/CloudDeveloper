//
//  AppDelegate+FBRetainCycleDetector.h
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/20.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (FBRetainCycleDetector)

/**
 *  @author _Finder丶Tiwk, 16-04-20 10:04:36
 *
 *  @brief 初始化循环引用检测工具(在main.m中使用)
 *  @since v1.0.0
 */
+ (void)xks_setupRetainCycleDetector;

/**
 *  @author _Finder丶Tiwk, 16-04-20 10:04:12
 *
 *  @brief 配置循环引用检测工具
 *  @since v1.0.0
 */
- (void)xks_configRetainCycleDetector;


@end
