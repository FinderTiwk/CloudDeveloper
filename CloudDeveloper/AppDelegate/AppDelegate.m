//
//  AppDelegate.m
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/7.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Easemob.h"         /**< 环信SDK*/
#import "AppDelegate+TouchOf3D.h"       /**< 3D Touch*/
//#import "AppDelegate+FBRetainCycleDetector.h" /**< 内存检测工具*/

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*! 1.初始化FaceBook 循环引用检测工具*/
//    [self xks_configRetainCycleDetector];
    /*! 2.初始化环信SDK*/
    [self xks_setupEasemob];
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    [self xks_easemobDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    [self xks_easemobWillEnterForeground:application];
}

#pragma mark - 3D Touch
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    
    [self xks_handler3DTouchWithShortcutItem:shortcutItem];
}



@end
